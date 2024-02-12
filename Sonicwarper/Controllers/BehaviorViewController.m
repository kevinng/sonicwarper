//
//  BehaviorViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 15/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "BehaviorViewController.h"
#import "ButtonBehavior.h"

@interface BehaviorViewController () <UITextFieldDelegate>

@property (nonatomic, strong) ButtonBehavior *origBehavior;
@property (nonatomic, strong) ButtonBehavior *behavior; // Should be set before this shows.

@property (weak, nonatomic) IBOutlet UITextField *descriptionTxtFld;

// Static table view cells
@property (weak, nonatomic) IBOutlet UITableViewCell *typeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *motionTypeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *motionReverseCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *motionStartCCValueCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiTypeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiNoteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiNoteOnOffCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiVelocityCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiChannelCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiCCControllerNoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *midiCCValueCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *nextMIDINoteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *nextMotionMappingCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *continueFromLastCCValueCell;

// Cell labels
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *motionTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *motionReverseLbl;
@property (weak, nonatomic) IBOutlet UILabel *motionStartCCValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *midiTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *midiNoteLbl;
@property (weak, nonatomic) IBOutlet UILabel *midiNoteOnOffLbl;
@property (weak, nonatomic) IBOutlet UILabel *midiVelocityLbl;
@property (weak, nonatomic) IBOutlet UILabel *midiChannelLbl;
@property (weak, nonatomic) IBOutlet UILabel *midiCCControllerNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *midiCCValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *nextMIDINoteLbl;
@property (weak, nonatomic) IBOutlet UILabel *nextMotionMappingLbl;
@property (weak, nonatomic) IBOutlet UILabel *continueFromLastCCValueLbl;

@property (strong, nonatomic) NSArray *typeLbls;
@property (strong, nonatomic) NSArray *midiNoteOnOffLbls;
@property (strong, nonatomic) NSArray *motionTypeLbls;
@property (strong, nonatomic) NSArray *motionReverseLbls;
@property (strong, nonatomic) NSArray *midiTypeLbls;
@property (strong, nonatomic) NSArray *nextMIDINoteLbls;
@property (strong, nonatomic) NSArray *nextMotionMappingLbls;
@property (strong, nonatomic) NSArray *continueFromLastCCValueLbls;

@end

@implementation BehaviorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.typeLbls = @[@"MIDI (Hold to Activate)",
                    @"MIDI (Toggle)",
                    @"MIDI (Touch-In)",
                    @"MIDI (Touch-Out)",
                    @"Map to Motion (Hold to Activate)",
                    @"Map to Motion (Toggle)"];
  
  self.midiNoteOnOffLbls = @[@"On",
                             @"Off"];
  
  self.motionTypeLbls = @[@"Rotate",
                          @"Dive/Raise",
                          @"Steer"];
  
  self.motionReverseLbls = @[@"No - Standard Mapping",
                             @"Yes - Reverse Mapping"];
  
  self.midiTypeLbls = @[@"Note",
                        @"CC"];
  
  self.nextMIDINoteLbls = @[@"On",
                            @"Off"];
  
  self.nextMotionMappingLbls = @[@"On - Map to Motion",
                                 @"Off - Unmap from Motion"];
  
  self.continueFromLastCCValueLbls = @[@"No",
                                       @"Yes"];
  
  // Copy original value.
  self.origBehavior = [self.behavior copy];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  // Initialize UI.
  [self initUI];
}

#pragma mark - Action methods

- (IBAction)cancelTapped:(id)sender {
  // Override with original values
  self.behavior = self.origBehavior;
  [self dismiss];
}

- (IBAction)saveTapped:(id)sender {
  if ([self canSave]) {
    
    // In case the textfield did not end editing yet - and thus, did not trigger the setting of
    // the value.
    self.behavior.behaviorDescription = self.descriptionTxtFld.text;
    
    [self.behavior save];
    [self dismiss];
  }
}

- (IBAction)endEditing:(id)sender {
  [self.view endEditing:YES];
}

#pragma mark - Helper methods

- (void)dismiss {
  if (self.createMode) {
    [self dismissViewControllerAnimated:YES completion:nil];
  } else {
    [self.navigationController popViewControllerAnimated:YES];
  }
}

- (void)initUI {
  
  // Show/hide delete button based on operation.
  [self cell:self.deleteCell setHidden:self.createMode];
  
  // Show/hide cells based on button type.
  BBType buttonType = self.behavior.type;
  if (buttonType == BBTypeMIDIHoldToActivate) {
    [self hideAllCellsExceptType];
    
    // Show relevant cells.
    [self cell:self.midiNoteCell setHidden:NO];
    [self cell:self.midiVelocityCell setHidden:NO];
    [self cell:self.midiChannelCell setHidden:NO];
    
  } else if (buttonType == BBTypeMIDIToggle) {
    [self hideAllCellsExceptType];
    
    // Show relevant cells.
    [self cell:self.midiNoteCell setHidden:NO];
    [self cell:self.midiChannelCell setHidden:NO];
    [self cell:self.nextMIDINoteCell setHidden:NO];
    
  } else if (buttonType == BBTypeMIDITouchOut) {
    // Only show MIDI type cell.
    [self hideAllCellsExceptType];
    
    // Show cells based on MIDI type.
    [self showCellsForMidiType];
    
  } else if (buttonType == BBTypeMIDITouchIn) {
    // Only show MIDI type cell.
    [self hideAllCellsExceptType];
    
    // Show cells based on MIDI type.
    [self showCellsForMidiType];
    
  } else if (buttonType == BBTypeMapToMotionHoldToActivate) {
    // Only show MIDI type cell.
    [self hideAllCellsExceptType];
    
    // Show relevant cells.
    [self cell:self.motionTypeCell setHidden:NO];
    [self cell:self.motionReverseCell setHidden:NO];
    [self cell:self.motionStartCCValueCell setHidden:NO];
    [self cell:self.midiCCControllerNoCell setHidden:NO];
    [self cell:self.midiChannelCell setHidden:NO];
    [self cell:self.continueFromLastCCValueCell setHidden:NO];
    
  } else if (buttonType == BBTypeMapToMotionToggle) {
    [self hideAllCellsExceptType];
    
    // Show relevant cells.
    [self cell:self.motionTypeCell setHidden:NO];
    [self cell:self.motionReverseCell setHidden:NO];
    [self cell:self.motionStartCCValueCell setHidden:NO];
    [self cell:self.midiCCControllerNoCell setHidden:NO];
    [self cell:self.midiChannelCell setHidden:NO];
    [self cell:self.nextMotionMappingCell setHidden:NO];
    [self cell:self.continueFromLastCCValueCell setHidden:NO];
    
  }
  
  // Set button description.
  self.descriptionTxtFld.text = self.behavior.behaviorDescription;
  
  // Set label values.
  
  self.typeLbl.text = self.typeLbls[self.behavior.type];
  self.midiNoteOnOffLbl.text = self.behavior.midiNoteIsOn ? self.midiNoteOnOffLbls[0] /* on */ : self.midiNoteOnOffLbls[1] /* off */;
  self.motionTypeLbl.text = self.motionTypeLbls[self.behavior.motionType];
  self.motionReverseLbl.text = self.motionReverseLbls[self.behavior.motionReverse];
  self.motionStartCCValueLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.motionStartCCValue];
  self.midiTypeLbl.text = self.midiTypeLbls[self.behavior.midiType];
  self.nextMIDINoteLbl.text = self.behavior.midiToggled ? self.nextMIDINoteLbls[1] /* off */ : self.nextMIDINoteLbls[0] /* on */;
  self.nextMotionMappingLbl.text = self.behavior.motionToggled ? self.nextMotionMappingLbls[1] /* off */ : self.nextMotionMappingLbls[0] /* on */;
  self.continueFromLastCCValueLbl.text = !self.behavior.continueFromLastCC ? self.continueFromLastCCValueLbls[0] /* no */ : self.continueFromLastCCValueLbls[1] /* yes */;
  
  NSArray *notes = @[@"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B"];
  NSInteger octave = ((NSInteger)(self.behavior.midiNote / 12)) - 1;
  NSString *note = notes[self.behavior.midiNote % 12];
  self.midiNoteLbl.text = [NSString stringWithFormat:@"%@%ld", note, (long)octave];
  
  self.midiVelocityLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiVelocity];
  self.midiChannelLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiChannel+1]; // Start channel from 1.
  self.midiCCControllerNoLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiCCControllerNo];
  self.midiCCValueLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiCCValue];
  
  [self reloadDataAnimated:NO];
}

- (void)hideAllCellsExceptType {
  NSArray *cells = @[self.motionTypeCell,
                     self.midiNoteOnOffCell,
                     self.motionReverseCell,
                     self.motionStartCCValueCell,
                     self.midiTypeCell,
                     self.midiNoteCell,
                     self.midiVelocityCell,
                     self.midiChannelCell,
                     self.midiCCControllerNoCell,
                     self.midiCCValueCell,
                     self.nextMIDINoteCell,
                     self.nextMotionMappingCell,
                     self.continueFromLastCCValueCell];
  
  for (NSUInteger i = 0; i < cells.count; i++) {
    [self cell:cells[i] setHidden:true];
  }
}

- (void)showCellsForMidiType {
  // Show/hide cells based on MIDI type.
  [self cell:self.midiTypeCell setHidden:NO];
  [self cell:self.midiChannelCell setHidden:NO];
  [self cell:self.midiNoteOnOffCell setHidden:self.behavior.midiType == BBMIDITypeCC];
  [self cell:self.midiCCControllerNoCell setHidden:self.behavior.midiType == BBMIDITypeNote];
  [self cell:self.midiCCValueCell setHidden:self.behavior.midiType == BBMIDITypeNote];
  [self cell:self.midiNoteCell setHidden:self.behavior.midiType == BBMIDITypeCC];
  [self cell:self.midiVelocityCell setHidden:self.behavior.midiType == BBMIDITypeCC || self.behavior.midiNoteIsOn == NO];
}

- (BOOL)canSave {
  if (self.descriptionTxtFld.text.length > 0) {
    return YES;
  }
  
  UIAlertController *alert = [UIAlertController
                              alertControllerWithTitle:@"Missing Field"
                              message:@"Please enter a description."
                              preferredStyle: UIAlertControllerStyleAlert];
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                             handler:nil];
  [alert addAction:ok];
  [self presentViewController:alert animated:YES completion:nil];
  
  return NO;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 2) {
    // Delete.
    
    // Confirm action.
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"You are about to delete this behavior."
                                message:@"Is this what you intend to do?"
                                preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES"
                                                 style:UIAlertActionStyleDestructive
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                  // Delete this behavior.
                                                  [self.behavior remove];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self dismiss];
                                                  });
                                                }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO"
                                                  style:UIAlertActionStyleCancel
                                               handler:nil];
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
}

#pragma mark Segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Pass behavior into the destination view controller.
  UIViewController <BehaviorUpdater> *vc = segue.destinationViewController;
  [vc setBehavior:self.behavior];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.descriptionTxtFld resignFirstResponder];
  return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.behavior.behaviorDescription = textField.text;
}

@end
