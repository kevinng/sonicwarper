//
//  MIDITypeViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDITypeViewController.h"

@interface MIDITypeViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UITableViewCell *noteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *ccCell;

@property (strong, nonatomic) NSArray *cells;

@end

@implementation MIDITypeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.cells = @[self.noteCell,
                 self.ccCell];
  
  [self selectType];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.behavior.midiType = (BBMIDIType)indexPath.row;
  [self selectType];
}

#pragma mark - Helper methods

- (void)selectType {
  for (NSInteger i = 0; i < [self.cells count]; i++) {
    UITableViewCell *cell = self.cells[i];
    if (i == self.behavior.midiType) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  }
}

@end
