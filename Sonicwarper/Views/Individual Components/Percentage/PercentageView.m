//
//  percentageView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 11/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "PercentageView.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"
#import "NSString+Sonicwarper.h"

@implementation PercentageView

// Dimensions
static const float WIDTH = 32;
static const float HEIGHT = 16;

#pragma mark Initializers

- (instancetype)init {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later.
  self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
  if (self) {
    self.disabled = YES;
  }
  
  return self;
}

#pragma mark Overrides

- (void)setPercentage:(float)percentage {
  _percentage = percentage;
  [self setNeedsDisplay];
}

- (void)setDisabled:(BOOL)disabled {
  _disabled = disabled;
  if (!_disabled) {
    self.backgroundColor = [UIColor SWBlue];
  } else {
    self.backgroundColor = [UIColor SWEmpty];
  }
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  // Label
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  NSDictionary *lblAttr = @{NSFontAttributeName:
                              [UIFont fontWithName:[Fonts Bold]
                                              size:[Fonts XSmallSize]],
                            NSForegroundColorAttributeName:[UIColor SWWhite87],
                            NSParagraphStyleAttributeName:centerPgStyle};
  NSString *lblStr;
  if (!_disabled) {
    lblStr = [NSString stringWithFormat:@"%.0f%%", self.percentage*100]; // No decimal places
  } else {
    lblStr = @"N/A";
  }
  NSAttributedString *lblAttrStr = [[NSAttributedString alloc]
                                    initWithString:lblStr
                                    attributes:lblAttr];
  CGFloat lblCenterX = [NSString centerXAttributedString:lblAttrStr superview:self];
  CGFloat lblCenterY = [NSString centerYAttributedString:lblAttrStr superview:self];
  [lblAttrStr drawAtPoint:CGPointMake(lblCenterX, lblCenterY)];
}

@end
