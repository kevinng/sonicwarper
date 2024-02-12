//
//  FullMotionLevelsView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 16/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "FullMotionLevelsView.h"
#import "VerticalMotionView.h"
#import "HorizontalMotionView.h"
#import "PercentageView.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"
#import "NSString+Sonicwarper.h"

@interface FullMotionLevelsView()

@property (nonatomic, strong) NSAttributedString *motionLblStr;
@property (nonatomic, strong) NSAttributedString *diveRaiseLblStr;
@property (nonatomic, strong) NSAttributedString *rotateLblStr;
//@property (nonatomic, strong) NSAttributedString *steerLblStr;

@property (nonatomic, strong) VerticalMotionView *diveRaise;
@property (nonatomic, strong) HorizontalMotionView *rotate;
//@property (nonatomic, strong) HorizontalMotionView *steer;

@property (nonatomic, strong) PercentageView *diveRaisePct;
@property (nonatomic, strong) PercentageView *rotatePct;
//@property (nonatomic, strong) PercentageView *steerPct;

@end

@implementation FullMotionLevelsView

#pragma mark Constants

// Dimensions
static const CGFloat SPACE_BELOW_TITLE = 3.0;
static const CGFloat SPACE_BELOW_VERTICAL_LVL = 3.0;
static const CGFloat SPACE_BELOW_LABEL = 7.0;
static const CGFloat ELEMENT_CTR_X_FRM_EDGE_DIST = 25.5;

#pragma mark Initializers

- (instancetype)init {
  
  // ***** Labels *****
  
  // Common text attributes
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  // Motion label
  NSDictionary *motionLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *motionLblStr = [[NSAttributedString alloc]
                                      initWithString:@"MOTIONS"
                                      attributes:motionLblAttr];
  
  // Dive/Raise label
  NSDictionary *diveRaiseLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *diveRaiseLblStr = [[NSAttributedString alloc]
                                         initWithString:@"Dive/Raise"
                                         attributes:diveRaiseLblAttr];
  
  // Rotate label
  NSDictionary *rotateLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *rotateLblStr = [[NSAttributedString alloc]
                                      initWithString:@"Rotate"
                                      attributes:rotateLblAttr];
  
  // Steer label
//  NSDictionary *steerLblAttr = @{
//    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
//                                        size:[Fonts SmallSize]],
//    NSForegroundColorAttributeName:[UIColor SWWhite87],
//    NSParagraphStyleAttributeName:centerPgStyle};
//  NSAttributedString *steerLblStr = [[NSAttributedString alloc]
//                                     initWithString:@"Steer"
//                                     attributes:steerLblAttr];
  
  // ***** Levels *****
  
  VerticalMotionView *diveRaise = [VerticalMotionView new];
  HorizontalMotionView *rotate = [HorizontalMotionView new];
//  HorizontalMotionView *steer = [HorizontalMotionView new];
  
  // ***** Percentage labels *****
  
  PercentageView *diveRaisePct = [PercentageView new];
  PercentageView *rotatePct = [PercentageView new];
//  PercentageView *steerPct = [PercentageView new];
  
  // ***** Calculate dimensions *****
  
//  CGFloat width = (3 * rotate.frame.size.width) + (15.0 * 2); // Assume 3 horizontal motion views
  CGFloat width = (2 * rotate.frame.size.width) + (15.0 * 1); // Assume 2 horizontal motion views
  CGFloat height = motionLblStr.size.height + SPACE_BELOW_TITLE + diveRaise.frame.size.height + \
    SPACE_BELOW_VERTICAL_LVL + diveRaiseLblStr.size.height + SPACE_BELOW_LABEL + diveRaisePct.frame.size.height;
  
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  if (self) {
    self.motionLblStr = motionLblStr;
    self.diveRaiseLblStr = diveRaiseLblStr;
    self.rotateLblStr = rotateLblStr;
//    self.steerLblStr = steerLblStr;
    
    self.diveRaise = diveRaise;
    self.rotate = rotate;
//    self.steer = steer;
    
    self.diveRaisePct = diveRaisePct;
    self.rotatePct = rotatePct;
//    self.steerPct = steerPct;
    
    self.opaque = NO; // Remove default black background
  }
  
  return self;
}

#pragma mark Overrides

- (void)layoutSubviews {
  
  // ***** Motion levels *****
  
  CGFloat lvlTopDist = self.motionLblStr.size.height + SPACE_BELOW_TITLE;
  
  // Dive/Raise motion levels
  [self addSubview:self.diveRaise];
  
  self.diveRaise.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint dive/raise motion level view's dimensions to its frame size
  [self.diveRaise addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.diveRaise
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.diveRaise.frame.size.width]];
  [self.diveRaise addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.diveRaise
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.diveRaise.frame.size.height]];
  // Position dive/raise percentage view a specific distance from the left of the view
  CGFloat diveRaiseEdgeDist = ELEMENT_CTR_X_FRM_EDGE_DIST;
  [self.diveRaise.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.diveRaise
                                           attribute:NSLayoutAttributeCenterX
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.diveRaise.superview
                                           attribute:NSLayoutAttributeLeft
                                           multiplier:1.f
                                           constant:diveRaiseEdgeDist]];
  // Position dive/raise view a specific distance from the top of the view
  [self.diveRaise.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.diveRaise
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.diveRaise.superview
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.f
                                           constant:lvlTopDist]];
  
  CGFloat lvlMidDist = self.motionLblStr.size.height + SPACE_BELOW_TITLE + \
    (self.diveRaise.frame.size.height/2) - (self.rotate.frame.size.height/2);
  
  // Rotate motion levels
  [self addSubview:self.rotate];
  
  self.rotate.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint rotate motion level view's dimensions to its frame size
  [self.rotate addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.rotate
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.rotate.frame.size.width]];
  [self.rotate addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.rotate
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.rotate.frame.size.height]];
  // Center rotate percentage view horizontally in the view
//  [self.rotate.superview addConstraint:[NSLayoutConstraint
//                                        constraintWithItem:self.rotate
//                                        attribute:NSLayoutAttributeCenterX
//                                        relatedBy:NSLayoutRelationEqual
//                                        toItem:self.rotate.superview
//                                        attribute:NSLayoutAttributeCenterX
//                                        multiplier:1.f
//                                        constant:0.f]];
  // Position rotate view a specific distance from the right of the view
  CGFloat rotateEdgeDist = self.frame.size.width - ELEMENT_CTR_X_FRM_EDGE_DIST;
  [self.rotate.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.rotate
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.rotate.superview
                                       attribute:NSLayoutAttributeLeft
                                       multiplier:1.f
                                       constant:rotateEdgeDist]];
  // Position rotate view a specific distance from the top of the view
  [self.rotate.superview addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.rotate
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.rotate.superview
                                        attribute:NSLayoutAttributeTop
                                        multiplier:1.f
                                        constant:lvlMidDist]];
  
  // Steer motion levels
//  [self addSubview:self.steer];
  
//  self.steer.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint steer motion level view's dimensions to its frame size
//  [self.steer addConstraint:[NSLayoutConstraint
//                             constraintWithItem:self.steer
//                             attribute:NSLayoutAttributeWidth
//                             relatedBy:NSLayoutRelationEqual
//                             toItem:nil
//                             attribute:NSLayoutAttributeNotAnAttribute
//                             multiplier:1.0
//                             constant:self.steer.frame.size.width]];
//  [self.steer addConstraint:[NSLayoutConstraint
//                             constraintWithItem:self.steer
//                             attribute:NSLayoutAttributeHeight
//                             relatedBy:NSLayoutRelationEqual
//                             toItem:nil
//                             attribute:NSLayoutAttributeNotAnAttribute
//                             multiplier:1.0
//                             constant:self.steer.frame.size.height]];
  // Position steer view a specific distance from the right of the view
//  CGFloat steerEdgeDist = self.frame.size.width - ELEMENT_CTR_X_FRM_EDGE_DIST;
//  [self.steer.superview addConstraint:[NSLayoutConstraint
//                                       constraintWithItem:self.steer
//                                       attribute:NSLayoutAttributeCenterX
//                                       relatedBy:NSLayoutRelationEqual
//                                       toItem:self.steer.superview
//                                       attribute:NSLayoutAttributeLeft
//                                       multiplier:1.f
//                                       constant:steerEdgeDist]];
  // Position steer view a specific distance from the top of the view
//  [self.steer.superview addConstraint:[NSLayoutConstraint
//                                       constraintWithItem:self.steer
//                                       attribute:NSLayoutAttributeTop
//                                       relatedBy:NSLayoutRelationEqual
//                                       toItem:self.steer.superview
//                                       attribute:NSLayoutAttributeTop
//                                       multiplier:1.f
//                                       constant:lvlMidDist]];
  
  
  
  // ***** Percentage views *****
  
  CGFloat pctTopDist = self.motionLblStr.size.height + SPACE_BELOW_TITLE + \
    self.diveRaise.frame.size.height + SPACE_BELOW_VERTICAL_LVL + self.diveRaiseLblStr.size.height + \
    SPACE_BELOW_LABEL;
  
  // Dive/Raise percentage
  [self addSubview:self.diveRaisePct];
  
  self.diveRaisePct.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint dive/raise percentage view's dimensions to its frame size
  [self.diveRaisePct addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.diveRaisePct
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:self.diveRaisePct.frame.size.width]];
  [self.diveRaisePct addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.diveRaisePct
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:self.diveRaisePct.frame.size.height]];
  // Position dive/raise percentage view a specific distance from the left of the view
  CGFloat diveRaisePctEdgeDist = ELEMENT_CTR_X_FRM_EDGE_DIST;
  [self.diveRaisePct.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:self.diveRaisePct
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.diveRaisePct.superview
                                              attribute:NSLayoutAttributeLeft
                                              multiplier:1.f
                                              constant:diveRaisePctEdgeDist]];
  // Position dive/raise percentage view a specific distance from the top of the view
  [self.diveRaisePct.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:self.diveRaisePct
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.diveRaisePct.superview
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.f
                                              constant:pctTopDist]];
  
  // Rotate percentage
  [self addSubview:self.rotatePct];
  
  self.rotatePct.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint rotate percentage view's dimensions to its frame size
  [self.rotatePct addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.rotatePct
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.rotatePct.frame.size.width]];
  [self.rotatePct addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.rotatePct
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.rotatePct.frame.size.height]];
  // Center rotate percentage view horizontally in the view
//  [self.rotatePct.superview addConstraint:[NSLayoutConstraint
//                                           constraintWithItem:self.rotatePct
//                                           attribute:NSLayoutAttributeCenterX
//                                           relatedBy:NSLayoutRelationEqual
//                                           toItem:self.rotatePct.superview
//                                           attribute:NSLayoutAttributeCenterX
//                                           multiplier:1.f
//                                           constant:0.f]];
  // Position rotate percentage view a specific distance from the right of the view
  CGFloat rotatePctEdgeDist = self.frame.size.width - ELEMENT_CTR_X_FRM_EDGE_DIST;
  [self.rotatePct.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.rotatePct
                                           attribute:NSLayoutAttributeCenterX
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.rotatePct.superview
                                           attribute:NSLayoutAttributeLeft
                                           multiplier:1.f
                                           constant:rotatePctEdgeDist]];
  // Position rotate percentage view a specific distance from the top of the view
  [self.rotatePct.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.rotatePct
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.rotatePct.superview
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.f
                                           constant:pctTopDist]];
  
  // Steer percentage
//  [self addSubview:self.steerPct];
  
//  self.steerPct.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint steer percentage view's dimensions to its frame size
//  [self.steerPct addConstraint:[NSLayoutConstraint
//                                constraintWithItem:self.steerPct
//                                attribute:NSLayoutAttributeWidth
//                                relatedBy:NSLayoutRelationEqual
//                                toItem:nil
//                                attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1.0
//                                constant:self.steerPct.frame.size.width]];
//  [self.steerPct addConstraint:[NSLayoutConstraint
//                                constraintWithItem:self.steerPct
//                                attribute:NSLayoutAttributeHeight
//                                relatedBy:NSLayoutRelationEqual
//                                toItem:nil
//                                attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1.0
//                                constant:self.steerPct.frame.size.height]];
  // Position steer percentage view a specific distance from the right of the view
//  CGFloat steerPctEdgeDist = self.frame.size.width - ELEMENT_CTR_X_FRM_EDGE_DIST;
//  [self.steerPct.superview addConstraint:[NSLayoutConstraint
//                                          constraintWithItem:self.steerPct
//                                          attribute:NSLayoutAttributeCenterX
//                                          relatedBy:NSLayoutRelationEqual
//                                          toItem:self.steerPct.superview
//                                          attribute:NSLayoutAttributeLeft
//                                          multiplier:1.f
//                                          constant:steerPctEdgeDist]];
  // Position steer percentage view a specific distance from the top of the view
//  [self.steerPct.superview addConstraint:[NSLayoutConstraint
//                                          constraintWithItem:self.steerPct
//                                          attribute:NSLayoutAttributeTop
//                                          relatedBy:NSLayoutRelationEqual
//                                          toItem:self.steerPct.superview
//                                          attribute:NSLayoutAttributeTop
//                                          multiplier:1.f
//                                          constant:pctTopDist]];
}

- (void)drawRect:(CGRect)rect {
  
  // ***** Motion label *****
  
  CGFloat motionLblXPos = [NSString centerXAttributedString:self.motionLblStr superview:self];
  [self.motionLblStr drawAtPoint:CGPointMake(motionLblXPos, 0)];
  
  // ***** Small labels *****
  
  CGFloat smallLblYPos = self.motionLblStr.size.height + SPACE_BELOW_TITLE + \
  self.diveRaise.frame.size.height + SPACE_BELOW_VERTICAL_LVL;
  
  // Dive/Raise label
  CGFloat diveRaiseLblXPos = ELEMENT_CTR_X_FRM_EDGE_DIST - (self.diveRaiseLblStr.size.width/2);
  [self.diveRaiseLblStr drawAtPoint:CGPointMake(diveRaiseLblXPos, smallLblYPos)];
  
  // Rotate label
//  CGFloat rotateLblXPos = (self.frame.size.width/2) - (self.rotateLblStr.size.width/2);
  CGFloat rotateLblXPos = (self.frame.size.width - ELEMENT_CTR_X_FRM_EDGE_DIST) - \
    (self.rotateLblStr.size.width/2);
  [self.rotateLblStr drawAtPoint:CGPointMake(rotateLblXPos, smallLblYPos)];
  
  // Steer label
//  CGFloat steerLblXPos = (self.frame.size.width - ELEMENT_CTR_X_FRM_EDGE_DIST) - \
//    (self.steerLblStr.size.width/2);
//  [self.steerLblStr drawAtPoint:CGPointMake(steerLblXPos, smallLblYPos)];
}

#pragma mark Properties

- (void)setDiveRaiseValue:(float)diveRaiseValue {
  self.diveRaise.level = diveRaiseValue;
  self.diveRaisePct.percentage = [FullMotionLevelsView normalize:diveRaiseValue];
}

- (float)diveRaiseValue {
  return self.diveRaise.level;
}

- (void)setRotateValue:(float)rotateValue {
  self.rotate.level = rotateValue;
  self.rotatePct.percentage = [FullMotionLevelsView normalize:rotateValue];
}

- (float)rotateValue {
  return self.rotate.level;
}

//- (void)setSteerValue:(float)steerValue {
//  self.steer.level = steerValue;
//  self.steerPct.percentage = [FullMotionLevelsView normalize:steerValue];
//}

//- (float)steerValue {
//  return self.steer.level;
//}

- (void)setDiveRaisePctIsDisabled:(BOOL)diveRaisePctIsDisabled {
  self.diveRaisePct.disabled = diveRaisePctIsDisabled;
}

- (BOOL)diveRaisePctIsDisabled {
  return self.diveRaisePct.disabled;
}

- (void)setRotatePctIsDisabled:(BOOL)rotatePctIsDisabled {
  self.rotatePct.disabled = rotatePctIsDisabled;
}

- (BOOL)rotatePctIsDisabled {
  return self.rotatePct.disabled;
}

//- (void)setSteerPctIsDisabled:(BOOL)steerPctIsDisabled {
//  self.steerPct.disabled = steerPctIsDisabled;
//}

//- (BOOL)steerPctIsDisabled {
//  return self.steerPct.disabled;
//}

#pragma mark Utility methods

+ (float)normalize:(float)value {
  return (value + 1.0) / 2.0;
}

@end
