//
//  ConfigureButtonViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 30/10/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "ConfigureButtonViewController.h"
#import "ButtonLook.h"
#import "BehaviorViewController.h"
#import "ColorViewController.h"
#import "MainLabelViewController.h"
#import "SmallLabelViewController.h"
#import "ColorCell.h"
#import "TextCell.h"
#import "AppDelegate.h"
#import "DataController.h"
#import "ViewController.h"
#import "Mappings.h"

@interface ConfigureButtonViewController ()

@property (nonatomic, strong) ButtonLook *look;
@property (nonatomic, strong) NSMutableArray *behaviors;

@property (nonatomic, strong) NSArray *colors;

@end

@implementation ConfigureButtonViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.colors = @[@"Empty",
                    @"Blue",
                    @"Purple",
                    @"Lilac",
                    @"Green",
                    @"Red",
                    @"Yellow"];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // We refresh the looks separately from the rest of UI because refreshBehaviorsAndTableView will
  // be triggered on context saved. When that happens, we don't want our new look to be flushed by
  // what we already have in Core Data.
  [self refreshLooks];
  [self refreshBehaviorsAndTableView];
  
  // Reload tableview when context saves; only happens for saving behaviors. Look is saved after
  // this view controller is dismissed.
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refreshBehaviorsAndTableView)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  [self refreshBehaviorsAndTableView];
}

#pragma mark - Helper methods

- (void)refreshBehaviorsAndTableView {
  [self refreshBehaviors];
  [self.tableView reloadData];
}

- (void)refreshLooks {
  
  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  // Fetch button's look.
  
  NSFetchRequest *getLook = [NSFetchRequest fetchRequestWithEntityName:@"Look"];
  NSInteger currentPage = [Mappings shared].currentPage;
  [getLook setPredicate:[NSPredicate predicateWithFormat:@"bowswitch == %d && button == %d && page == %ld",
                         self.bowswitch, self.button, currentPage]];
  
  NSInteger lookCount = [context countForFetchRequest:getLook error:nil];
  if (lookCount > 0) {
    // Existing entry found - use it.
    NSArray *lookResults = [context executeFetchRequest:getLook error:nil];
    NSManagedObject *lookObj = lookResults.firstObject;
    self.look = [[ButtonLook alloc]
                 initWithColor:(BSButtonColor)[[lookObj valueForKey:@"color"] integerValue]
                 mainLabel:[lookObj valueForKey:@"mainLabel"]
                 smallLabel:[lookObj valueForKey:@"smallLabel"]];
  } else {
    // No existing entry found - use default.
    self.look = [ButtonLook new];
  }
}

- (void)refreshBehaviors {
  
  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  // Fetch button's behaviors
  
  self.behaviors = [NSMutableArray new];
  
  NSFetchRequest *getBehaviors = [NSFetchRequest fetchRequestWithEntityName:@"Behavior"];
  NSInteger currentPage = [Mappings shared].currentPage;
  [getBehaviors setPredicate:[NSPredicate predicateWithFormat:@"bowswitch == %d && button == %d && page == %ld",
                              self.bowswitch, self.button, currentPage]];
  
  NSInteger behCount = [context countForFetchRequest:getBehaviors error:nil];
  
  if (behCount) {
    // Existing entry found - use it.
    NSArray *behResults = [context executeFetchRequest:getBehaviors error:nil];
    if (behResults) {
      for (NSInteger i = 0; i < behResults.count; i++) {
        NSManagedObject *behObj = behResults[i];
        
        ButtonBehavior *behavior = [[ButtonBehavior alloc] initWithManagedObject:behObj];
        [self.behaviors addObject:behavior];
      }
    }
  }
}

#pragma mark - UITableViewController methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"LOOKS";
      break;
    case 1:
      return @"DEFAULT LOOKS";
      break;
    case 2:
      return @"BEHAVIORS";
      break;
    case 3:
      return @"BEHAVIORS";
      break;
      
    default:
      return @"";
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 1;
      break;
    case 1:
      if (self.look.color == BSButtonColorEmpty) {
        return 1;
      }
      
      return 3;
      break;
    case 2:
      return 1;
      break;
    case 3:
      return self.behaviors.count + 1;
      break;
      
    default:
      return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    // Looks
    if (indexPath.row == 0) {
      // Looks explainer
      return [tableView dequeueReusableCellWithIdentifier:@"LooksExplainerCell" forIndexPath:indexPath];
    }
  } else if (indexPath.section == 1) {
    // Default looks
    if (indexPath.row == 0) {
      // Color
      ColorCell *cell = (ColorCell *)[tableView dequeueReusableCellWithIdentifier:@"ColorCell"
                                                                     forIndexPath:indexPath];
      cell.title = @"Color";
      cell.subTitle = self.colors[self.look.color];
      cell.color = self.look.color;
      
      return cell;
    } else if (indexPath.row == 1) {
      // Main label
      TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:@"TextCell"
                                                                   forIndexPath:indexPath];
      cell.title = @"Main Label";
      cell.subTitle = self.look.mainLabel;
      
      return cell;
    } else if (indexPath.row == 2) {
      // Small label
      TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:@"TextCell"
                                                                   forIndexPath:indexPath];
      cell.title = @"Small Label";
      cell.subTitle = self.look.smallLabel;
      return cell;
    }
  } else if (indexPath.section == 2) {
    // Behaviors
    if (indexPath.row == 0) {
      // Behaviors explainer
      return [tableView dequeueReusableCellWithIdentifier:@"BehaviorsExplainerCell" forIndexPath:indexPath];
    }
  } else if (indexPath.section == 3) {
    // Behaviors
    if (indexPath.row == self.behaviors.count) {
      UITableViewCell *addCell = [tableView dequeueReusableCellWithIdentifier:@"AddABehaviorCell"
                                                                 forIndexPath:indexPath];
      return addCell;
    }
    
    ButtonBehavior *behavior = (ButtonBehavior *)self.behaviors[indexPath.row];
    TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:@"TextCell"
                                                                 forIndexPath:indexPath];
    cell.title = behavior.behaviorDescription;
    cell.subTitle = @""; // No subtitle.
    
    return cell;
  }
  
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    // Looks explainer
    return 300;
  } else if (indexPath.section == 1) {
    // Normal cells
    return 44;
  } else if (indexPath.section == 2) {
    // Behavior explainer
    return 360;
  } else if (indexPath.section == 3) {
    // Normal cells
    return 44;
  }
  
  return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    // Looks
    if (indexPath.row == 0) {
      // Color
      
      UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      ColorViewController *colorVC =
        (ColorViewController *)[main instantiateViewControllerWithIdentifier:@"ColorVC"];
      [colorVC setLook:self.look];
      [self showViewController:colorVC sender:nil];
      
    } else if (indexPath.row == 1) {
      // Main label
      
      UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      MainLabelViewController *mainLabelVC =
        (MainLabelViewController *)[main instantiateViewControllerWithIdentifier:@"MainLabelVC"];
      [mainLabelVC setLook:self.look];
      [self showViewController:mainLabelVC sender:nil];
      
    } else if (indexPath.row == 2) {
      // Small label
      
      UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      SmallLabelViewController *smallLabelVC =
      (SmallLabelViewController *)[main instantiateViewControllerWithIdentifier:@"SmallLabelVC"];
      [smallLabelVC setLook:self.look];
      [self showViewController:smallLabelVC sender:nil];
      
    }
  } else if (indexPath.section == 3) {
    // Behaviors
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *behNav = (UINavigationController *)[main instantiateViewControllerWithIdentifier:@"BehaviorNav"];
    behNav.modalPresentationStyle = UIModalPresentationCurrentContext;
    BehaviorViewController *behVC = (BehaviorViewController *)behNav.viewControllers[0];
    
    if (indexPath.row == self.behaviors.count) {
      // Add a new behavior
      ButtonBehavior *newBehavior = [ButtonBehavior new];
      newBehavior.bowswitch = self.bowswitch;
      newBehavior.button = self.button;
      [behVC setBehavior:newBehavior];
      behVC.createMode = YES;
      
      [self presentViewController:behNav animated:YES completion:nil];
    } else {
      // Behavior
      [behVC setBehavior:self.behaviors[indexPath.row]];
      behVC.createMode = NO;
      
      [self showViewController:behVC sender:nil];
    }
  }
}

- (void)saveAndRefreshLook {
  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  NSFetchRequest *getLook = [NSFetchRequest fetchRequestWithEntityName:@"Look"];
  NSInteger currentPage = [Mappings shared].currentPage;
  [getLook setPredicate:[NSPredicate predicateWithFormat:@"bowswitch == %d && button == %d && page == %ld",
                         self.bowswitch, self.button, currentPage]];
  
  NSError *lookErr = nil;
  NSInteger lookCount = [context countForFetchRequest:getLook error:&lookErr];
  if (lookCount > 0) {
    // Existing entry found - use it.
    NSArray *lookResults = [context executeFetchRequest:getLook error:&lookErr];
    NSManagedObject *lookObj = lookResults.firstObject;
    if (lookObj) {
      [lookObj setValue:[NSNumber numberWithInteger:self.look.color] forKey:@"color"];
      [lookObj setValue:self.look.mainLabel forKey:@"mainLabel"];
      [lookObj setValue:self.look.smallLabel forKey:@"smallLabel"];
    }
  } else {
    // No existing entry found - create a new one.
    NSManagedObject *newLookObj = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Look"
                                   inManagedObjectContext:context];
    [newLookObj setValue:[NSNumber numberWithInteger:self.bowswitch] forKey:@"bowswitch"];
    [newLookObj setValue:[NSNumber numberWithInteger:self.button] forKey:@"button"];
    [newLookObj setValue:[NSNumber numberWithInteger:self.look.color] forKey:@"color"];
    [newLookObj setValue:self.look.mainLabel forKey:@"mainLabel"];
    [newLookObj setValue:self.look.smallLabel forKey:@"smallLabel"];
    NSInteger currentPage = [Mappings shared].currentPage;
    [newLookObj setValue:[NSNumber numberWithInteger:currentPage] forKey:@"page"];
  }
  
  // Save context.
  NSError *error = nil;
  if ([context save:&error] == NO) {
    NSAssert(NO, @"Error saving context: %@\n%@",
             [error localizedDescription],
             [error userInfo]);
  }
  
  // Show changes to button looks.
  [((ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController) refreshLooks];
}

#pragma mark - Action methods

- (IBAction)done:(id)sender {
  [self saveAndRefreshLook];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
