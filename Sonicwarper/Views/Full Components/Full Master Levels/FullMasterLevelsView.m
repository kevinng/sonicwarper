//
//  FullMasterLevelsView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 16/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "FullMasterLevelsView.h"
#import "UIColor+Sonicwarper.h"
#import "LevelView.h"
#import "Fonts+Sonicwarper.h"
#import "NSString+Sonicwarper.h"

@interface FullMasterLevelsView()

@property (nonatomic, strong) NSAttributedString *mstrLvlsLblStr;
@property (nonatomic, strong) NSAttributedString *lLblStr;
@property (nonatomic, strong) NSAttributedString *rLblStr;

@property (nonatomic, strong) LevelView *lLevel;
@property (nonatomic, strong) LevelView *rLevel;

@end

@implementation FullMasterLevelsView

#pragma mark Constants

// Dimensions
static const CGFloat SPACE_ABOVE_LEVELS = 3.0;
static const CGFloat SPACE_BELOW_LEVELS = 3.0;
static const CGFloat SPACE_BESIDE_LEVELS = 24.0;

#pragma mark Initializers

- (instancetype)init {
  
  // ***** Label *****
  
  // Common text attributes
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  // Master levels label
  NSDictionary *mstrLvlsLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
                                 NSForegroundColorAttributeName:[UIColor SWWhite87],
                                 NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *mstrLvlsLblStr = [[NSAttributedString alloc]
                                        initWithString:@"MASTER LEVELS"
                                        attributes:mstrLvlsLblAttr];
  
  // L label
  NSDictionary *lLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *lLblStr = [[NSAttributedString alloc]
                                 initWithString:@"L"
                                 attributes:lLblAttr];
  
  // R label
  NSDictionary *rLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *rLblStr = [[NSAttributedString alloc]
                                 initWithString:@"R"
                                 attributes:rLblAttr];
  
  // L level
  LevelView *lLevel = [[LevelView alloc] initAsMasterLevel];
  
  
  // R level
  LevelView *rLevel = [[LevelView alloc] initAsMasterLevel];
  
  // Calculate dimensions
  CGFloat width = mstrLvlsLblStr.size.width; // Largest of the elements
  CGFloat height = mstrLvlsLblStr.size.height + SPACE_ABOVE_LEVELS + \
    lLevel.bounds.size.height + SPACE_BELOW_LEVELS + lLblStr.size.height;
  
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  
  if (self) {
    self.mstrLvlsLblStr = mstrLvlsLblStr;
    self.lLblStr = lLblStr;
    self.rLblStr = rLblStr;
    
    self.lLevel = lLevel;
    self.rLevel = rLevel;
    
    self.opaque = NO; // Remove default black background
  }
  
  return self;
}

#pragma mark Overrides

- (void)layoutSubviews {
  
  // ***** Master levels *****
  
  // Distance of levels from the top of the screen
  CGFloat lvlsDistFromTop = self.mstrLvlsLblStr.size.height + SPACE_ABOVE_LEVELS;
  
  // + L levels +
  [self addSubview:self.lLevel];
  
  self.lLevel.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint L level's dimensions to its frame size
  [self.lLevel addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.lLevel
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.lLevel.frame.size.width]];
  [self.lLevel addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.lLevel
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.lLevel.frame.size.height]];
  // Constraint L levels a specific distance from the left of the view
  [self.lLevel.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.lLevel
                                           attribute:NSLayoutAttributeLeft
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.lLevel.superview
                                           attribute:NSLayoutAttributeLeft
                                           multiplier:1.f
                                           constant:SPACE_BESIDE_LEVELS]];
  // Constraint L levels a specific distance from the top of the view
  [self.lLevel.superview addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.lLevel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.lLevel.superview
                                        attribute:NSLayoutAttributeTop
                                        multiplier:1.f
                                        constant:lvlsDistFromTop]];

  // + R levels +
  [self addSubview:self.rLevel];
  
  self.rLevel.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint R level's dimensions to its frame size
  [self.rLevel addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.rLevel
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.rLevel.frame.size.width]];
  [self.rLevel addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.rLevel
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.rLevel.frame.size.height]];
  // Constraint R levels a specific distance from the right of the view
  [self.rLevel.superview addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.rLevel
                                        attribute:NSLayoutAttributeRight
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.rLevel.superview
                                        attribute:NSLayoutAttributeRight
                                        multiplier:1.f
                                        constant:-SPACE_BESIDE_LEVELS]];
  // Constraint R levels a specific distance from the top of the view
  [self.rLevel.superview addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.rLevel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.rLevel.superview
                                        attribute:NSLayoutAttributeTop
                                        multiplier:1.f
                                        constant:lvlsDistFromTop]];
}

-(void)drawRect:(CGRect)rect {
  // Draw master levels label
  CGFloat masterLabelXPos = [NSString centerXAttributedString:self.mstrLvlsLblStr superview:self];
  [self.mstrLvlsLblStr drawAtPoint:CGPointMake(masterLabelXPos, 0)];
  
  // Draw L label
  CGFloat lLabelXPos = self.lLevel.center.x - (self.lLblStr.size.width/2);
  CGFloat lLabelYPos = self.lLevel.frame.origin.y + self.lLevel.frame.size.height + \
    SPACE_BELOW_LEVELS;
  [self.lLblStr drawAtPoint:CGPointMake(lLabelXPos, lLabelYPos)];
  
  // Draw R label
  CGFloat rLabelXPos = self.rLevel.center.x - (self.rLblStr.size.width/2);
  CGFloat rLabelYPos = self.rLevel.frame.origin.y + self.rLevel.frame.size.height + \
    SPACE_BELOW_LEVELS;
  [self.rLblStr drawAtPoint:CGPointMake(rLabelXPos, rLabelYPos)];
}

#pragma mark Levels

- (float)leftLevel {
  return self.lLevel.level;
}

- (void)setLeftLevel:(float)leftLevel {
  self.lLevel.level = leftLevel;
}

- (float)rightLevel {
  return self.rLevel.level;
}

- (void)setRightLevel:(float)rightLevel {
  self.rLevel.level = rightLevel;
}

@end
