//
//  MIDICCControllerNoViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDICCControllerNoViewController.h"

@interface MIDICCControllerNoViewController ()

@property (nonatomic, weak) ButtonBehavior *behavior;

@property (weak, nonatomic) IBOutlet UILabel *valueLbl;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation MIDICCControllerNoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setLabel];
  
  self.stepper.value = self.behavior.midiCCControllerNo;
  self.slider.value = self.behavior.midiCCControllerNo;
}

#pragma mark - Helper methods

- (void)setValue:(NSInteger)value {
  self.behavior.midiCCControllerNo = value;
  [self setLabel];
}

- (void)setLabel {
  self.valueLbl.text = [NSString stringWithFormat:@"%ld", (long)self.behavior.midiCCControllerNo];
}

#pragma mark - Action methods

- (IBAction)stepperDidChanged:(id)sender {
  self.value = ((UIStepper *) sender).value;
  
  self.slider.value = self.behavior.midiCCControllerNo;
}

- (IBAction)sliderDidChanged:(id)sender {
  self.value = ((UISlider *) sender).value;
  
  self.stepper.value = self.behavior.midiCCControllerNo;
}


@end
