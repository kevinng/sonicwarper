//
//  MIDIVelocityViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDIVelocityViewController.h"

@interface MIDIVelocityViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation MIDIVelocityViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setLabel];
  
  self.stepper.value = self.behavior.midiVelocity;
  self.slider.value = self.behavior.midiVelocity;
}

- (void)setValue:(NSInteger)value {
  self.behavior.midiVelocity = value;
  [self setLabel];
}

#pragma mark - Helper methods

- (void)setLabel {
  self.valueLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiVelocity];
}

#pragma mark - Action methods

- (IBAction)stepperDidChanged:(id)sender {
  self.value = ((UIStepper *) sender).value;
  
  self.slider.value = self.behavior.midiVelocity;
}

- (IBAction)sliderDidChanged:(id)sender {
  self.value = ((UISlider *) sender).value;
  
  self.stepper.value = self.behavior.midiVelocity;
}
@end
