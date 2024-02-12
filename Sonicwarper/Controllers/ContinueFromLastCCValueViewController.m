//
//  ContinueFromLastCCValueViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 1/12/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "ContinueFromLastCCValueViewController.h"
#import "ButtonBehavior.h"

@interface ContinueFromLastCCValueViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UITableViewCell *noCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *yesCell;

@end

@implementation ContinueFromLastCCValueViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self selectType];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    // No is selected.
    self.behavior.continueFromLastCC = NO;
  } else {
    // Yes is selected.
    self.behavior.continueFromLastCC = YES;
  }
  
  [self selectType];
}

#pragma mark - Helper methods

- (void)selectType {
  
  if (!self.behavior.continueFromLastCC) {
    // No is selected.
    self.noCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.yesCell.accessoryType = UITableViewCellAccessoryNone;
  } else {
    // Yes is selected.
    self.yesCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.noCell.accessoryType = UITableViewCellAccessoryNone;
  }
}

@end
