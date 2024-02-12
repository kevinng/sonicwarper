//
//  MIDICCValueViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDICCValueViewController.h"

@interface MIDICCValueViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation MIDICCValueViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setLabel];
  
  self.stepper.value = self.behavior.midiCCValue;
  self.slider.value = self.behavior.midiCCValue;
}

- (void)setValue:(NSInteger)value {
  self.behavior.midiCCValue = value;
  [self setLabel];
}

#pragma mark - Helper methods

- (void)setLabel {
  self.valueLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiCCValue];
}

#pragma mark - Action methods

- (IBAction)stepperDidChanged:(id)sender {
  self.value = ((UIStepper *) sender).value;
  
  self.slider.value = self.behavior.midiCCValue;
}

- (IBAction)sliderDidChanged:(id)sender {
  self.value = ((UISlider *) sender).value;
  
  self.stepper.value = self.behavior.midiCCValue;
}

@end
