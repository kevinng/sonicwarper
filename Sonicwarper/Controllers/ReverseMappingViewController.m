//
//  ReverseMappingViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "ReverseMappingViewController.h"

@interface ReverseMappingViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UITableViewCell *standardMappingCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *reverseMappingCell;

@property (strong, nonatomic) NSArray *cells;

@end

@implementation ReverseMappingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.cells = @[self.standardMappingCell,
                 self.reverseMappingCell];
  
  [self selectReverseType];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.behavior.motionReverse = (indexPath.row == 1);
  [self selectReverseType];
}

#pragma mark - Helper methods

- (void)selectReverseType {
  for (NSInteger i = 0; i < [self.cells count]; i++) {
    UITableViewCell *cell = self.cells[i];
    if (i == (self.behavior.motionReverse ? 1 : 0)) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  }
}

@end
