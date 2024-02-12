//
//  NewConditionalBehaviorViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 24/12/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "NewConditionalBehaviorViewController.h"

@interface NewConditionalBehaviorViewController ()

@end

@implementation NewConditionalBehaviorViewController

#pragma mark - Action methods

- (IBAction)cancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
  // CONTINUE - ADD INPUT CHECKS AND SAVE
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
  if(range.length + range.location > textField.text.length) {
    return NO;
  }
  
  NSUInteger newLength = [textField.text length] + [string length] - range.length;
  return newLength <= 80;
}

@end
