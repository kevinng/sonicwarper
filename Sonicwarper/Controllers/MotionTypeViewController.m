//
//  MotionTypeViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MotionTypeViewController.h"
#import "MotionEngine.h"

@interface MotionTypeViewController ()

@property (strong, nonatomic) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UITableViewCell *rotateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *diveRaiseCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *steerCell;

@property (strong, nonatomic) NSArray *cells;

@end

@implementation MotionTypeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
//  self.cells = @[self.rotateCell,
//                 self.diveRaiseCell,
//                 self.steerCell];
  // Note: steer cell is hidden.
  
  self.cells = @[self.rotateCell,
                 self.diveRaiseCell];
  
  [self selectMotionType];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.behavior.motionType = (MEMotionType)indexPath.row;
  [self selectMotionType];
}


#pragma mark - Helper methods

- (void)selectMotionType {
  for (NSInteger i = 0; i < [self.cells count]; i++) {
    UITableViewCell *cell = self.cells[i];
    if (i == self.behavior.motionType) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  }
}

@end
