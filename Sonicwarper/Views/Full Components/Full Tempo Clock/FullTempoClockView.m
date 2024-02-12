//
//  FullTempoClockView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 16/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "FullTempoClockView.h"
#import "UIColor+Sonicwarper.h"
#import "TempoView.h"
#import "Fonts+Sonicwarper.h"
#import "NSString+Sonicwarper.h"

@interface FullTempoClockView()

@property (nonatomic, strong) NSAttributedString *tempoLblStr;
@property (nonatomic, strong) TempoView *tempoView;

@end

@implementation FullTempoClockView

#pragma mark Constants

// Dimensions
static const CGFloat SPACE_BTW_CLOCK_N_LBL = 9.0;

#pragma mark Initializers

- (instancetype)init {
  
  // ***** Label *****
  
  // Label
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  NSDictionary *tempoLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  
  NSAttributedString *tempoLblStr = [[NSAttributedString alloc]
                                     initWithString:@"TEMPO"
                                     attributes:tempoLblAttr];
  
  // Tempo view
  TempoView *tempoView = [TempoView new];
  
  // Calculate dimensions
  CGFloat width = tempoView.frame.size.width; // Largest of the elements
  CGFloat height = tempoLblStr.size.height + SPACE_BTW_CLOCK_N_LBL + \
    tempoView.frame.size.height;
  
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  
  if (self) {
    self.tempoLblStr = tempoLblStr;
    self.tempoView = tempoView;
    
    self.opaque = NO; // Remove default black background
  }
  return self;
}

#pragma mark Overrides

- (void)layoutSubviews {
  // Add tempo view
  [self addSubview:self.tempoView];
  
  self.tempoView.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint tempo view's dimensions to its frame size
  [self.tempoView addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.tempoView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.tempoView.frame.size.width]];
  [self.tempoView addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.tempoView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.tempoView.frame.size.height]];
  // Center tempo view horizontally in the view
  [self.tempoView.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.tempoView
                                           attribute:NSLayoutAttributeCenterX
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.tempoView.superview
                                           attribute:NSLayoutAttributeCenterX
                                           multiplier:1.f
                                           constant:0.f]];
  // Position tempo view a specific distance from the top of the view
  CGFloat tempoViewTopDist = self.tempoLblStr.size.height + SPACE_BTW_CLOCK_N_LBL;
  [self.tempoView.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.tempoView
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.tempoView.superview
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.f
                                           constant:tempoViewTopDist]];
}

- (void)drawRect:(CGRect)rect {
  // Draw label
  CGFloat tempoLblXPos = [NSString centerXAttributedString:self.tempoLblStr superview:self];
  [self.tempoLblStr drawAtPoint:CGPointMake(tempoLblXPos, 0)];
}

#pragma mark Properties

- (void)setBpm:(float)bpm {
  self.tempoView.bpm = bpm;
}

- (float)bpm {
  return self.tempoView.bpm;
}

@end
