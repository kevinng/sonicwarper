//
//  SmallLabelViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 24/12/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "SmallLabelViewController.h"
#import "ButtonLook.h"

@interface SmallLabelViewController ()

@property (nonatomic) ButtonLook *look;
@property (weak, nonatomic) IBOutlet UITextField *smallLabel;

@end

@implementation SmallLabelViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.smallLabel.text = self.look.smallLabel;
}

- (void)setLook:(ButtonLook *)look {
  _look = look;
}

#pragma mark - Action methods

- (IBAction)endEditing:(id)sender {
  [self.view endEditing:YES];
}

#pragma mark - TextfieldDelegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.look.smallLabel = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
  if(range.length + range.location > textField.text.length) {
    return NO;
  }
  
  NSUInteger newLength = [textField.text length] + [string length] - range.length;
  return newLength <= 8;
}

@end
