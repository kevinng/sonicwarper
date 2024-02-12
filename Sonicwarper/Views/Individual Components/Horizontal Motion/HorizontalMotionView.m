//
//  HorizontalMotionView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 16/2/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "HorizontalMotionView.h"
#import "UIColor+Sonicwarper.h"

@implementation HorizontalMotionView

#pragma mark Constants

// Dimensions
// Frame
static const CGFloat FRAME_HEIGHT = 12.5;
static const CGFloat FRAME_WIDTH = 53.2;
static const CGFloat STROKE_WIDTH = 2.f;
// Center bar
static const CGFloat CBAR_THICK = 2.F;

#pragma mark Initializers

- (instancetype)init {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later.
  CGFloat width = FRAME_WIDTH;
  CGFloat height = FRAME_HEIGHT;
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  if (self) {
    // Default value
    self.level = 0;
    
    self.opaque = NO; // Remove default black background
  }
  return self;
}

#pragma mark Overrides

- (void)setLevel:(float)level {
  if (level < -1.f || level > 1.f) {
    NSException* lvlException = [NSException
                                 exceptionWithName:@"InvalidLevelException"
                                 reason:@"Level should be a value from -1.f to 1.f"
                                 userInfo:nil];
    [lvlException raise];
  }
  
  _level = level;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  
  // Border
  CGFloat halfBorderWidth = STROKE_WIDTH / 2;
  CGFloat borderWidth = FRAME_WIDTH - STROKE_WIDTH;
  CGFloat borderHeight = FRAME_HEIGHT - STROKE_WIDTH;
  UIBezierPath *border = [UIBezierPath
                          bezierPathWithRect:CGRectMake(halfBorderWidth,
                                                        halfBorderWidth,
                                                        borderWidth,
                                                        borderHeight)];
  border.lineWidth = STROKE_WIDTH;
  [[UIColor SWWhite12] setStroke];
  [border stroke];
  
  // Positive fill
  CGFloat fillLength = (FRAME_WIDTH - (2*STROKE_WIDTH)) / 2;
  CGFloat centerXPos = fillLength  + STROKE_WIDTH;
  CGFloat fillHeight = FRAME_HEIGHT - (2*STROKE_WIDTH);
  CGFloat posFillWidth = self.level < 0 ? 0 : self.level * fillLength;
  UIBezierPath *posFill = [UIBezierPath
                           bezierPathWithRect:CGRectMake(centerXPos,
                                                         STROKE_WIDTH,
                                                         posFillWidth,
                                                         fillHeight)];
  [[UIColor SWBlue] setFill];
  [posFill fill];

  // Negative fill
  CGFloat negFillWidth = self.level > 0 ? 0 : (-1*self.level) * fillLength; // level is negative
  CGFloat negXPos = fillLength + STROKE_WIDTH - negFillWidth;
  UIBezierPath *negFill = [UIBezierPath
                           bezierPathWithRect:CGRectMake(negXPos,
                                                         STROKE_WIDTH,
                                                         negFillWidth,
                                                         fillHeight)];
  [[UIColor SWBlue] setFill];
  [negFill fill];

  // Center bar
  CGFloat cbarXPos = centerXPos - (CBAR_THICK/2);
  CGFloat cbarHeight = FRAME_HEIGHT;
  UIBezierPath *centerBar = [UIBezierPath
                             bezierPathWithRect:CGRectMake(cbarXPos,
                                                           0,
                                                           CBAR_THICK,
                                                           cbarHeight)];
  [[UIColor SWWhite87] setFill];
  
  [centerBar fill];
}



@end
