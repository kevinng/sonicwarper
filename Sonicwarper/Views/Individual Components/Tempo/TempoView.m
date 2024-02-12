//
//  TempoView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 11/2/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "TempoView.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"
#import "NSString+Sonicwarper.h"

@implementation TempoView

#pragma mark Constants

// Dimensions
static const CGFloat WIDTH = 42; // Original 43.75; shrank to fit frame
static const CGFloat HEIGHT = 42; // Original 43.75; shrank to fit frame
static const CGFloat BORDER_WIDTH = 2.0;

// Positions
static const CGFloat SPACE_BTW_TOP_N_BPM_VAL = 12.5;
static const CGFloat SPACE_BTW_BPM_VAL_N_BPM_LBL = 23.5;

#pragma mark Initializers

- (instancetype)init {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later.
  self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
  if (self) {
    // Default value
    self.bpm = 120.f;
    
    self.opaque = NO; // Remove default black background
  }
  return self;
}

#pragma mark Overrides

- (void)setBpm:(float)bpm {
  _bpm = bpm;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  // Round frame
  CGFloat halfBorderWidth = BORDER_WIDTH / 2;
  CGFloat borderWidth = WIDTH - BORDER_WIDTH;
  CGFloat borderHeight = HEIGHT - BORDER_WIDTH;
  UIBezierPath *border = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(halfBorderWidth,
                                     halfBorderWidth,
                                     borderWidth,
                                     borderHeight)];
  border.lineWidth = BORDER_WIDTH;
  [[UIColor SWYellow] setStroke];
  [border stroke];
  
  // Common text attributes
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  // BPM value
  NSDictionary *bpmValAttr = @{
      NSFontAttributeName:[UIFont fontWithName:[Fonts Regular]
                                          size:[Fonts MediumSize]],
      NSForegroundColorAttributeName:[UIColor SWWhite87],
      NSParagraphStyleAttributeName:centerPgStyle,
  };
  NSString *bpmValStr = [NSString stringWithFormat:@"%.0f", self.bpm]; // No decimal places
  NSAttributedString *bpmValue = [[NSAttributedString alloc]
                                  initWithString:bpmValStr
                                  attributes:bpmValAttr];
  CGFloat bvCenterX = [NSString centerXAttributedString:bpmValue superview:self];
  [bpmValue drawAtPoint:CGPointMake(bvCenterX, SPACE_BTW_TOP_N_BPM_VAL)];

  // BPM label
  NSDictionary *bpmLblAttr = @{
      NSFontAttributeName:[UIFont fontWithName:[Fonts Regular]
                                        size:[Fonts XXSmallSize]],
      NSForegroundColorAttributeName:[UIColor SWWhite87],
      NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *bpmLabel = [[NSAttributedString alloc]
                                  initWithString:@"BPM"
                                  attributes:bpmLblAttr];
  CGFloat blCenterX = [NSString centerXAttributedString:bpmLabel superview:self];
  [bpmLabel drawAtPoint:CGPointMake(blCenterX, SPACE_BTW_BPM_VAL_N_BPM_LBL)];
}

@end
