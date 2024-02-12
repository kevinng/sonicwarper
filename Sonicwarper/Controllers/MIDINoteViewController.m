//
//  MIDINoteViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDINoteViewController.h"

@interface MIDINoteViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UILabel *noteLbl;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation MIDINoteViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setLabel];
  
  self.stepper.value = self.behavior.midiNote;
  self.slider.value = self.behavior.midiNote;
}

- (void)setValue:(NSInteger)value {
  self.behavior.midiNote = value;
  [self setLabel];
}

#pragma mark - Helper methods

- (void)setLabel {
  NSArray *notes = @[@"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B"];
  
  NSInteger octave = ((NSInteger)(self.behavior.midiNote / 12)) - 1;
  NSString *note = notes[self.behavior.midiNote % 12];
  
  self.noteLbl.text = [NSString stringWithFormat:@"%@%ld", note, (long)octave];
}

#pragma mark - Action methods

- (IBAction)stepperDidChanged:(id)sender {
  self.value = ((UIStepper *) sender).value;
  
  self.slider.value = self.behavior.midiNote;
}

- (IBAction)sliderDidChanged:(id)sender {
  self.value = ((UISlider *) sender).value;
  
  self.stepper.value = self.behavior.midiNote;
}

@end
