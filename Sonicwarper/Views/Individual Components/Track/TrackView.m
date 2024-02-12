//
//  TrackView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 10/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "TrackView.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"

@implementation TrackView

#pragma mark constants

// Dimensions
static const CGFloat LABEL_WIDTH = 41;
static const CGFloat LABEL_HEIGHT = 41;
static const CGFloat BASE_WIDTH = 149;
static const CGFloat BASE_HEIGHT = 4;
static const CGFloat BORDER_WIDTH = 2;
static const CGFloat NEEDLE_WIDTH = 2;

#pragma mark Initializers

- (instancetype)init {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later.
  CGFloat width = LABEL_WIDTH + BASE_WIDTH;
  CGFloat height = LABEL_HEIGHT;
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  if (self) {
    // Default values
    self.label = @"A";
    self.trackProgress = 0;
    self.trackEnding = NO;
    
    self.backgroundColor = [UIColor blackColor];
  }
  return self;
}

#pragma mark Overrides

- (void)setLabel:(NSString *)label {
  _label = label;
  [self setNeedsDisplay];
}

- (void)setTrackProgress:(float)trackProgress {
  _trackProgress = trackProgress;
  [self setNeedsDisplay];
}

- (void)setTrackEnding:(BOOL)trackEnding {
  _trackEnding = trackEnding;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  // Label
  UIBezierPath *label = [UIBezierPath bezierPathWithRect:
                         CGRectMake(0,
                                    0,
                                    LABEL_WIDTH,
                                    LABEL_HEIGHT)];
  [[UIColor SWPurple] setFill];
  [label fill];
  
  // Base
  CGFloat baseYPos = LABEL_HEIGHT - BASE_HEIGHT;
  UIBezierPath *base = [UIBezierPath bezierPathWithRect:
                        CGRectMake(LABEL_WIDTH,
                                   baseYPos,
                                   BASE_WIDTH,
                                   BASE_HEIGHT)];
  [[UIColor SWPurple] setFill];
  [base fill];
  
  // Top border
  CGFloat topBorXPos = LABEL_WIDTH;
  UIBezierPath *topBorder = [UIBezierPath bezierPathWithRect:
                             CGRectMake(topBorXPos,
                                        0,
                                        BASE_WIDTH,
                                        BORDER_WIDTH)];
  [[UIColor SWWhite12] setFill];
  [topBorder fill];
  
  // Right border
  CGFloat rightBorXPos = LABEL_WIDTH + BASE_WIDTH - BORDER_WIDTH;
  CGFloat rightBorHeight = LABEL_HEIGHT - BORDER_WIDTH - BASE_HEIGHT;
  UIBezierPath *rightBorder = [UIBezierPath bezierPathWithRect:
                               CGRectMake(rightBorXPos,
                                          BORDER_WIDTH,
                                          BORDER_WIDTH,
                                          rightBorHeight)];
  [[UIColor SWWhite12] setFill];
  [rightBorder fill];
  
  // Label
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  NSDictionary *lblAttr =
  @{NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts LabelSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *lblAttrStr = [[NSAttributedString alloc] initWithString:self.label
                                                                   attributes:lblAttr];
  CGFloat lblXPos = (LABEL_WIDTH/2) - (lblAttrStr.size.width/2);
  CGFloat lblYPos = (LABEL_HEIGHT/2) - (lblAttrStr.size.height/2);
  [lblAttrStr drawAtPoint:CGPointMake(lblXPos, lblYPos)];
  
  // Track progress
  CGFloat progressWidth = self.trackProgress * (BASE_WIDTH - BORDER_WIDTH);
  CGFloat progressHeight = LABEL_HEIGHT - BORDER_WIDTH - BASE_HEIGHT;
  UIBezierPath *trackProgress = [UIBezierPath bezierPathWithRect:
                                 CGRectMake(LABEL_WIDTH,
                                            BORDER_WIDTH,
                                            progressWidth,
                                            progressHeight)];
  [[UIColor SWPurpleDark2] setFill];
  [trackProgress fill];
  
  // Needle
  CGFloat needleXPos = LABEL_WIDTH + progressWidth;
  CGFloat needleHeight = LABEL_HEIGHT - BASE_HEIGHT;
  UIBezierPath *needle = [UIBezierPath bezierPathWithRect:
                          CGRectMake(needleXPos,
                                     0,
                                     NEEDLE_WIDTH,
                                     needleHeight)];
  [[UIColor SWPurple] setFill];
  [needle fill];
  
  // Track ending
  if (self.trackEnding) {
    CGFloat endXPos = needleXPos + NEEDLE_WIDTH;
    CGFloat endWidth = (1 - self.trackProgress) * (BASE_WIDTH - BORDER_WIDTH) - NEEDLE_WIDTH;
    if (endWidth < 0) endWidth = 0;
    CGFloat endHeight = LABEL_HEIGHT - BORDER_WIDTH - BASE_HEIGHT;
    UIBezierPath *ending = [UIBezierPath bezierPathWithRect:
                            CGRectMake(endXPos,
                                       BORDER_WIDTH,
                                       endWidth,
                                       endHeight)];
    [[UIColor SWRedDark2] setFill];
    [ending fill];
  }
}

@end
