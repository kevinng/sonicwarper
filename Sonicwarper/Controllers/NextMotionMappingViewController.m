//
//  NextMotionMappingViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 26/11/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "NextMotionMappingViewController.h"

@interface NextMotionMappingViewController()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UITableViewCell *onCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *offCell;

@end

@implementation NextMotionMappingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self selectType];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    // On is selected.
    self.behavior.motionToggled = NO;
  } else {
    // Off is selected.
    self.behavior.motionToggled = YES;
  }
  
  [self selectType];
}

#pragma mark - Helper methods

- (void)selectType {
  if (self.behavior.motionToggled) {
    // Next note is off.
    self.offCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.onCell.accessoryType = UITableViewCellAccessoryNone;
  } else {
    // Next note is on.
    self.onCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.offCell.accessoryType = UITableViewCellAccessoryNone;
  }
}

@end
