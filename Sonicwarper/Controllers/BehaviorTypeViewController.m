//
//  BehaviorTypeViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "BehaviorTypeViewController.h"

@interface BehaviorTypeViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UITableViewCell *midiHoldToActivateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiToggleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiTouchInCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiTouchOutCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *mapToMotionHoldToActivateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *mapToMotionToggleCell;

@property (strong, nonatomic) NSArray *cells;

@end

@implementation BehaviorTypeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.cells = @[self.midiHoldToActivateCell,
                 self.midiToggleCell,
                 self.midiTouchInCell,
                 self.midiTouchOutCell,
                 self.mapToMotionHoldToActivateCell,
                 self.mapToMotionToggleCell];
  
  [self selectBehavior];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.behavior.type = (BBType)indexPath.row;
  [self selectBehavior];
}

#pragma mark - Helper methods

- (void)selectBehavior {
  for (NSInteger i = 0; i < [self.cells count]; i++) {
    UITableViewCell *cell = self.cells[i];
    if (i == self.behavior.type) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  }
}

@end
