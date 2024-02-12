//
//  ColorViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 24/12/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "ColorViewController.h"
#import "ButtonLook.h"

@interface ColorViewController ()

@property (strong, nonatomic) ButtonLook *look;

@property (weak, nonatomic) IBOutlet UITableViewCell *blankCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *blueCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *purpleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *lilacCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *greenCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *redCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *yellowCell;

@property (strong, nonatomic) NSArray *cells;

@end

@implementation ColorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.cells = @[self.blankCell,
                 self.blueCell,
                 self.purpleCell,
                 self.lilacCell,
                 self.greenCell,
                 self.redCell,
                 self.yellowCell];
  
  [self selectColor];
}

- (void)setLook:(ButtonLook *)look {
  _look = look;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.look.color = (BSButtonColor)indexPath.row;
  [self selectColor];
}

#pragma mark - Helper methods

- (void)selectColor {
  for (NSInteger i = 0; i < [self.cells count]; i++) {
    UITableViewCell *cell = self.cells[i];
    if (i == self.look.color) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  }
}

@end
