//
//  OnOffView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 10/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "OnOffView.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"
#import "NSString+Sonicwarper.h"

@implementation OnOffView

#pragma mark Constants

// Dimensions
// - for small
static const CGFloat SMALL_WIDTH = 26.f;
static const CGFloat SMALL_HEIGHT = 14.f;
// - for large
static const CGFloat LARGE_WIDTH = 31.f;
static const CGFloat LARGE_HEIGHT = 15.f;

#pragma mark Initializers

// Designated initializer
- (instancetype)initAsSmall:(BOOL)isSmall {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later.
  CGFloat width = isSmall ? SMALL_WIDTH : LARGE_WIDTH;
  CGFloat height = isSmall ? SMALL_HEIGHT : LARGE_HEIGHT;
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  if (self) {
    // Default value
    self.isOn = NO;
    
    self.opaque = NO; // Remove default black background
  }
  
  return self;
}

#pragma mark Overrides

- (void)setIsOn:(BOOL)isOn {
  _isOn = isOn;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  // Background
  UIBezierPath *background = [UIBezierPath bezierPathWithRect:
                              CGRectMake(0,
                                         0,
                                         self.bounds.size.width,
                                         self.bounds.size.height)];
  if (self.isOn) {
    [[UIColor SWBlue] setFill];
    [background fill];
  } else {
    [[UIColor SWEmpty] setFill];
    [background fill];
  }
  
  // Label
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  NSDictionary *lblAttr = @{NSFontAttributeName:
                              [UIFont fontWithName:[Fonts Bold]
                                              size:[Fonts XSmallSize]],
                               NSForegroundColorAttributeName:[UIColor SWWhite87],
                               NSParagraphStyleAttributeName:centerPgStyle};
  NSString *lblStr;
  if (self.isOn) {
    lblStr = @"ON";
  } else {
    lblStr = @"OFF";
  }
  NSAttributedString *lblAttrStr = [[NSAttributedString alloc]
                                    initWithString:lblStr
                                    attributes:lblAttr];
  CGFloat lblCenterX = [NSString centerXAttributedString:lblAttrStr superview:self];
  CGFloat lblCenterY = [NSString centerYAttributedString:lblAttrStr superview:self];
  [lblAttrStr drawAtPoint:CGPointMake(lblCenterX, lblCenterY)];
}

@end
