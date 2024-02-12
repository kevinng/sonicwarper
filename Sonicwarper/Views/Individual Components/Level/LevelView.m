//
//  LevelView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 29/1/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "LevelView.h"
#import "UIColor+Sonicwarper.h"

@interface LevelView ()

@property (nonatomic, strong) NSMutableDictionary *levelFillColors;

@end

@implementation LevelView

#pragma mark Constants

// Dimensions
static const CGFloat WIDTH = 12.5;
static const CGFloat TRACK_HEIGHT = 33.8;
static const CGFloat MASTER_HEIGHT = 53.2;
static const CGFloat BORDER_WIDTH = 2.0;

#pragma mark Initializers

// *** Convenience initializers ***

// Initializer for level views used in master levels
- (instancetype)initAsMasterLevel {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later.
  return [self initWithFrame:CGRectMake(0, 0, WIDTH, MASTER_HEIGHT)];
}

// Initializer for level views used in tracks
- (instancetype)initAsTrackLevel {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later.
  return [self initWithFrame:CGRectMake(0, 0, WIDTH, TRACK_HEIGHT)];
}

// *** Designated initializer ***
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.level = 0.0;
    
    // Fade colors
    self.levelFillColors = [NSMutableDictionary new];
    [self addFillColor:[UIColor SWGreen] startingAtLevel:0.0];
    [self addFillColor:[UIColor SWGreen] startingAtLevel:0.75];
    [self addFillColor:[UIColor SWYellow] startingAtLevel:0.95];
    [self addFillColor:[UIColor SWRed] startingAtLevel:1.0];
    // Note: we added 2 green level breakpoints because we do not want the green color to start
    // fading to yellow from the beginning.
    
    self.opaque = NO; // Remove default black background
  }
  return self;
}

#pragma mark Level Fill Colors

- (void)addFillColor:(UIColor *)color startingAtLevel:(float)level {
  self.levelFillColors[[NSNumber numberWithFloat:level]] = color;
}

- (void)removeFillColors {
  self.levelFillColors = [NSMutableDictionary new];
}

- (void)setFillColorsToSpectrum {
  // Fade colors
  [self removeFillColors];
  [self addFillColor:[UIColor SWGreen] startingAtLevel:0.0];
  [self addFillColor:[UIColor SWGreen] startingAtLevel:0.75];
  [self addFillColor:[UIColor SWYellow] startingAtLevel:0.95];
  [self addFillColor:[UIColor SWRed] startingAtLevel:1.0];
  // Note: we added 2 green level breakpoints because we do not want the green color to start
  // fading to yellow from the beginning.
  [self setNeedsDisplay];
}

- (void)setFillColorToBlue {
  [self removeFillColors];
  [self addFillColor:[UIColor SWBlue] startingAtLevel:0.0];
  [self addFillColor:[UIColor SWBlue] startingAtLevel:1.0];
  [self setNeedsDisplay];
}

#pragma mark Overrides

- (void)drawRect:(CGRect)rect {
  CGFloat width = self.bounds.size.width;
  CGFloat height = self.bounds.size.height;
  
  // Frame
  CGFloat halfBorderWidth = BORDER_WIDTH / 2;
  CGFloat framePathWidth = width - BORDER_WIDTH;
  CGFloat framePathHeight = height - BORDER_WIDTH;
  UIBezierPath *frame = [UIBezierPath bezierPathWithRect:
                         CGRectMake(halfBorderWidth,
                                    halfBorderWidth,
                                    framePathWidth,
                                    framePathHeight)];
  frame.lineWidth = BORDER_WIDTH;
  [[UIColor SWWhite12] setStroke];
  [frame stroke];
  
  // Fill
  CGFloat fillPathWidth = width - (2 * BORDER_WIDTH);
  CGFloat fillPathHeight = height - (2 * BORDER_WIDTH);
  CGFloat fillYPos = BORDER_WIDTH + (fillPathHeight * (1 - self.level)); // Fill from bottom up
  fillPathHeight = fillPathHeight * self.level; // Fill up to the level percentage.
  UIBezierPath *fill = [UIBezierPath bezierPathWithRect:
                        CGRectMake(BORDER_WIDTH,
                                   fillYPos,
                                   fillPathWidth,
                                   fillPathHeight)];
  [self setFillForLevel:self.level];
  [fill fill];
}

- (void)setLevel:(float)level {
  _level = level;
  [self setNeedsDisplay];
}

#pragma mark Utility Methods

- (UIColor *)colorBetweenStartColor:(UIColor *)startColor
                       atStartLevel:(float)startLevel
                        andEndColor:(UIColor *)endColor
                         atEndLevel:(float)endLevel
                    forCurrentLevel:(float)thisLevel {
  
  if (!((startLevel <= thisLevel) && (thisLevel <= endLevel))) {
    NSString *reason = [NSString stringWithFormat:@"This level (%f) should be between start level\
                        (%f) and end level (%f)", thisLevel, startLevel, endLevel];
    NSException* lvlException = [NSException
                                 exceptionWithName:@"InvalidLevelException"
                                 reason:reason
                                 userInfo:nil];
    [lvlException raise];
  }
  
  // Start color RGBA
  CGFloat sRed;
  CGFloat sGreen;
  CGFloat sBlue;
  CGFloat sAlpha;
  BOOL gotStartCol = [startColor getRed:&sRed green:&sGreen blue:&sBlue alpha:&sAlpha];
  
  // End color RGBA
  CGFloat eRed;
  CGFloat eGreen;
  CGFloat eBlue;
  CGFloat eAlpha;
  BOOL gotEndCol = [endColor getRed:&eRed green:&eGreen blue:&eBlue alpha:&eAlpha];
  
  // Make sure we're able to extract RGBA values from both colors
  if (!(gotStartCol == gotEndCol == YES)) return nil;
  
  float moveDist = thisLevel - startLevel; // Distance to move
  float totalDist = endLevel - startLevel; // Total distance
  float normMoveDist = moveDist / totalDist; // Normalized distance to move
  
  // Calculate the RGBA values for the between color
  CGFloat bRed = sRed + (normMoveDist * (eRed - sRed));
  CGFloat bGreen = sGreen + (normMoveDist * (eGreen - sGreen));
  CGFloat bBlue = sBlue + (normMoveDist * (eBlue - sBlue));
  CGFloat bAlpha = sAlpha + (normMoveDist * (eAlpha - sAlpha));
  
  // Initialize and return the between color
  UIColor *bColor = [UIColor colorWithRed:bRed green:bGreen blue:bBlue alpha:bAlpha];
  return bColor;
}

- (void)setFillForLevel:(float)level {
  
  if (!((0.0 <= level) && (level <= 1.0))) {
    NSException* lvlException = [NSException
                                 exceptionWithName:@"InvalidLevelException"
                                 reason:@"Level should be a value from 0.0 to 1.0"
                                 userInfo:nil];
    [lvlException raise];
  }
  
  // The keys in self.levelFillColors are level breakpoints for fill colors
  // Get them in ascending order (i.e. index 0 is the smallest)
  NSArray *sortedKeys = [self.levelFillColors.allKeys
                         sortedArrayUsingComparator:^(id keyOne, id keyTwo) {
    NSNumber *keyOneNum = (NSNumber *)keyOne;
    NSNumber *keyTwoNum = (NSNumber *)keyTwo;
    
    if (keyOneNum.floatValue > keyTwoNum.floatValue) {
      return (NSComparisonResult)NSOrderedDescending;
    } else if (keyOneNum.floatValue < keyTwoNum.floatValue) {
      return (NSComparisonResult)NSOrderedAscending;
    }
    
    return (NSComparisonResult)NSOrderedSame;
  }];
  
  // Find out if the level is on a breakpoint (in this case, we will set the breakpoint color as
  // fill immediately), or in-between two breakpoints (in this case, we will compute the color
  // between those two colors).
  for (NSInteger i = sortedKeys.count-1; i >= 0; i--) { // Descending
    NSNumber *key = sortedKeys[i];
    
    if (level == key.floatValue) {
      [(UIColor *)self.levelFillColors[key] setFill]; // Level equals key, set fill immediately
    } else if (level > key.floatValue) { // Level is greater than the current key
      if (i < sortedKeys.count-1) { // There is at least one more element after (by index) this element
        NSNumber *keyAfter = (NSNumber *)sortedKeys[i+1]; // We're sure there's one more element
        // Then, the color we need is in-between the current color and the color after this
        UIColor *startColor = self.levelFillColors[key];
        UIColor *endColor = self.levelFillColors[keyAfter];
        UIColor *btwColor = [self colorBetweenStartColor:startColor
                                            atStartLevel:key.floatValue
                                             andEndColor:endColor
                                              atEndLevel:keyAfter.floatValue
                                         forCurrentLevel:level];
        [btwColor setFill];
        break;
      }
    }
  }
}

@end
