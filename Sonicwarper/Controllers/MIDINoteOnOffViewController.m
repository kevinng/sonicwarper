//
//  MIDINoteOnOffViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 30/11/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDINoteOnOffViewController.h"
#import "ButtonBehavior.h"

@interface MIDINoteOnOffViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UITableViewCell *onCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *offCell;

@end

@implementation MIDINoteOnOffViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self selectType];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    // On is selected.
    self.behavior.midiNoteIsOn = YES;
  } else {
    // Off is selected.
    self.behavior.midiNoteIsOn = NO;
  }
  
  [self selectType];
}

#pragma mark - Helper methods

- (void)selectType {
  
  if (self.behavior.midiNoteIsOn) {
    // On.
    self.onCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.offCell.accessoryType = UITableViewCellAccessoryNone;
  } else {
    // Off.
    self.offCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.onCell.accessoryType = UITableViewCellAccessoryNone;
  }
}

@end
