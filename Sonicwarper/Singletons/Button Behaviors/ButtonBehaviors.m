//
//  ButtonBehaviors.m
//  Sonicwarper
//
//  Created by Kevin Ng on 5/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "ButtonBehaviors.h"
#import "ButtonBehavior.h"
#import "DataController.h"
#import "AppDelegate.h"
#import "Mappings.h"

NSString *const BBBehaviorDidUpdate = @"BBBehaviorDidUpdate";

@interface ButtonBehaviors()

// e.g. buttonBehaviors[button][bowswitch] is a mutable array of behaviors.
@property (nonatomic, strong) NSMutableArray *buttonBehaviors;

@end

@implementation ButtonBehaviors

#pragma mark - Singleton initializers

+ (ButtonBehaviors *)shared {
  static ButtonBehaviors *shared = nil;
  if (!shared) {
    shared = [[self alloc] initPrivate];
  }
  return shared;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use + [ButtonBehaviors shared]"
                               userInfo:nil];
}

- (instancetype)initPrivate {
  self = [super init];
  if (self) {
    [self refreshBehaviors];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshBehaviors)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
  }
  return self;
}

- (void)behaveButton:(BSButtonPosition)button
            bowswitch:(BSBowswitchPosition)bowswitch
                state:(BSButtonState)state {
  NSMutableArray *behaviors = (NSMutableArray *)self.buttonBehaviors[bowswitch][button];
  
  if (behaviors != nil) {
    for (NSInteger i = 0; i < behaviors.count; i++) {
      ButtonBehavior *behavior = (ButtonBehavior *)behaviors[i];
      [behavior behaveForState:state];
    }
  }
}

- (void)refreshBehaviors {
  // Unsubscribe current behaviors from the motion engine.
  for (NSMutableArray *bowswitch in self.buttonBehaviors) {
    for (NSMutableArray *buttons in bowswitch) {
      for (ButtonBehavior *behavior in buttons) {
        [behavior deconfigureMotion];
      }
    }
  }
  
  // Reset array.
  self.buttonBehaviors = [[NSMutableArray alloc] initWithCapacity:BSBowswitchCount];
  for (NSInteger i = 0; i < BSBowswitchCount; i++) {
    self.buttonBehaviors[i] = [[NSMutableArray alloc] initWithCapacity:BSButtonCount];
    for (NSInteger j = 0; j < BSButtonCount; j++) {
      self.buttonBehaviors[i][j] = [NSMutableArray new];
    }
  }
  
  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  NSFetchRequest *getBehaviors = [NSFetchRequest fetchRequestWithEntityName:@"Behavior"];
  Mappings *mappings = [Mappings shared];
  [getBehaviors setPredicate:[NSPredicate predicateWithFormat:@"page == %ld", mappings.currentPage]];
  NSArray *behResults = [context executeFetchRequest:getBehaviors error:nil];
  
  if (behResults) {
    for (NSInteger i = 0; i < behResults.count; i++) {
      NSManagedObject *behObj = behResults[i];
      
      ButtonBehavior *behavior = [[ButtonBehavior alloc] initWithManagedObject:behObj];
      [behavior configureMotion];
      
      [self.buttonBehaviors[behavior.bowswitch][behavior.button] addObject:behavior];
    }
  }
}

- (NSMutableArray *)behaviorsForButton:(BSButtonPosition)button
                             bowswitch:(BSBowswitchPosition)bowswitch {
  NSMutableArray *behaviors = (NSMutableArray *)self.buttonBehaviors[button][bowswitch];
  if (behaviors == nil) {
    return nil;
  }
  return self.buttonBehaviors[button][bowswitch];
}

- (void)addBehavior:(ButtonBehavior *)behavior
             button:(BSButtonPosition)button
          bowswitch:(BSBowswitchPosition)bowswitch {
  NSMutableArray *behaviors = (NSMutableArray *)self.buttonBehaviors[button][bowswitch];
  if (behaviors == nil) {
    behaviors = [NSMutableArray new];
  }
  [behaviors addObject:behavior];
}

- (void)removeBehavior:(ButtonBehavior *)behavior
                button:(BSButtonPosition)button
             bowswitch:(BSBowswitchPosition)bowswitch {
  NSMutableArray *behaviors = (NSMutableArray *)self.buttonBehaviors[button][bowswitch];
  if (behaviors == nil) {
    return;
  }
  [behaviors removeObject:behavior];
}

@end
