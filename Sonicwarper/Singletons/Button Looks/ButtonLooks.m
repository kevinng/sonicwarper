//
//  ButtonLooks.m
//  Sonicwarper
//
//  Created by Kevin Ng on 28/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "ButtonLooks.h"
@import CoreData;
#import "AppDelegate.h"
#import "Mappings.h"

@interface ButtonLooks()

@end

@implementation ButtonLooks

#pragma mark - Singleton initializers

+ (ButtonLooks *)shared {
  static ButtonLooks *shared = nil;
  if (!shared) {
    shared = [[self alloc] initPrivate];
  }
  return shared;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use + [ButtonLooks shared]"
                               userInfo:nil];
}

- (instancetype)initPrivate {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (ButtonLook *)lookForBowswitch:(BSBowswitchPosition)bowswitch button:(BSButtonPosition)button {
  
  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  NSFetchRequest *getLook = [NSFetchRequest fetchRequestWithEntityName:@"Look"];
  NSInteger currentPage = [Mappings shared].currentPage;
  [getLook setPredicate:[NSPredicate predicateWithFormat:@"bowswitch == %d && button == %d && page == %ld",
                         bowswitch, button, currentPage]];
  
  NSError *lookErr = nil;
  NSInteger lookCount = [context countForFetchRequest:getLook error:&lookErr];
  if (lookCount > 0) {
    // Existing entry found - use it.
    NSArray *lookResults = [context executeFetchRequest:getLook error:&lookErr];
    NSManagedObject *lookObj = lookResults.firstObject;
    ButtonLook *look = [[ButtonLook alloc]
                        initWithColor:[[lookObj valueForKey:@"color"] integerValue]
                        mainLabel:[lookObj valueForKey:@"mainLabel"]
                        smallLabel:[lookObj valueForKey:@"smallLabel"]];
    return look;
  }
  
  return [ButtonLook new]; // Default look.
}

@end
