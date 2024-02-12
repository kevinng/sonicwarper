
//
//  MIDIChannelViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDIChannelViewController.h"

@interface MIDIChannelViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UILabel *valueLbl;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation MIDIChannelViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setLabel];
  
  self.stepper.value = self.behavior.midiChannel;
  self.slider.value = self.behavior.midiChannel;
}

- (void)setValue:(NSInteger)value {
  self.behavior.midiChannel = value;
  [self setLabel];
}

#pragma mark - Helper methods

- (void)setLabel {
  self.valueLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiChannel+1]; // Start MIDI channel from 1.
}

#pragma mark - Action methods

- (IBAction)stepperDidChanged:(id)sender {
  self.value = ((UIStepper *) sender).value;
  
  self.slider.value = self.behavior.midiChannel;
}

- (IBAction)sliderDidChanged:(id)sender {
  self.value = ((UISlider *) sender).value;
  
  self.stepper.value = self.behavior.midiChannel;
}


@end
