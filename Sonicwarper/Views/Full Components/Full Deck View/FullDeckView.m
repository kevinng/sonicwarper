//
//  FullDeckView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 16/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "FullDeckView.h"
#import "TrackView.h"
#import "OnOffView.h"
#import "LevelView.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"

@interface FullDeckView()

@property (nonatomic, strong) TrackView *track;
@property (nonatomic, strong) OnOffView *fx1;
@property (nonatomic, strong) OnOffView *fx2;
@property (nonatomic, strong) OnOffView *fx3;
@property (nonatomic, strong) OnOffView *fx4;
@property (nonatomic, strong) LevelView *preLeft;
@property (nonatomic, strong) LevelView *preRight;
@property (nonatomic, strong) LevelView *postLeft;
@property (nonatomic, strong) LevelView *postRight;
@property (nonatomic, strong) LevelView *filter;
@property (nonatomic, strong) OnOffView *fluxMode;
@property (nonatomic, strong) OnOffView *loopActive;

@property (nonatomic, strong) NSAttributedString *fxLblStr;
@property (nonatomic, strong) NSAttributedString *fxOneLblStr;
@property (nonatomic, strong) NSAttributedString *fxTwoLblStr;
@property (nonatomic, strong) NSAttributedString *fxThreeLblStr;
@property (nonatomic, strong) NSAttributedString *fxFourLblStr;
@property (nonatomic, strong) NSAttributedString *preLblStr;
@property (nonatomic, strong) NSAttributedString *preLeftLblStr;
@property (nonatomic, strong) NSAttributedString *preRightLblStr;
@property (nonatomic, strong) NSAttributedString *postLblStr;
@property (nonatomic, strong) NSAttributedString *postLeftLblStr;
@property (nonatomic, strong) NSAttributedString *postRightLblStr;
@property (nonatomic, strong) NSAttributedString *filterLblStr;
@property (nonatomic, strong) NSAttributedString *fluxModeLblStr;
@property (nonatomic, strong) NSAttributedString *loopActiveLblStr;

@end

@implementation FullDeckView

#pragma mark Constants

// Dimensions
static const CGFloat SPACE_BELOW_TRACK = 7.0;
static const CGFloat SPACE_BELOW_ON_OFF = 7.0;
static const CGFloat SPACE_BELOW_PRE_LABEL = 3.0;
static const CGFloat SPACE_BELOW_PRE_LEFT_LVL = 6.0;
static const CGFloat SPACE_BTW_FX_N_EDGE = 7.0;
static const CGFloat SPACE_BTW_FX_N_ELEMENT = 4.0;
static const CGFloat SPACE_BELOW_FX = 7.0;
static const CGFloat SPACE_BELOW_SECTION_LBL = 3.0;
static const CGFloat SPACE_BTW_SECTION_N_EDGE = 4.75;
static const CGFloat SPACE_BTW_LEVELS = 3.0;
static const CGFloat SPACE_BTW_PRE_POST = 5.0;
static const CGFloat SPACE_BELOW_FLUX_MODE = 5.0;

#pragma mark Initializers

- (instancetype)init {
  
  // ***** Views *****
  
  // Track
  TrackView *track = [TrackView new];
  // FX
  OnOffView *fx1 = [[OnOffView alloc] initAsSmall:YES];
  OnOffView *fx2 = [[OnOffView alloc] initAsSmall:YES];
  OnOffView *fx3 = [[OnOffView alloc] initAsSmall:YES];
  OnOffView *fx4 = [[OnOffView alloc] initAsSmall:YES];
  // Pre/Post levels
  LevelView *preLeft = [[LevelView alloc] initAsTrackLevel];
  LevelView *preRight = [[LevelView alloc] initAsTrackLevel];
  LevelView *postLeft = [[LevelView alloc] initAsTrackLevel];
  LevelView *postRight = [[LevelView alloc] initAsTrackLevel];
  // Filter
  LevelView *filter = [[LevelView alloc] initAsTrackLevel];
  [filter setFillColorToBlue];
  // Flux mode/Loop active
  OnOffView *fluxMode = [[OnOffView alloc] initAsSmall:NO];
  OnOffView *loopActive = [[OnOffView alloc] initAsSmall:NO];
  
  // ***** Labels *****
  
  // Common text attributes
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  // FX label
  NSDictionary *fxLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *fxLblStr = [[NSAttributedString alloc]
                                  initWithString:@"FX"
                                  attributes:fxLblAttr];
  
  // FX 1 label
  NSDictionary *fxOneLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *fxOneLblStr = [[NSAttributedString alloc]
                                     initWithString:@"1"
                                     attributes:fxOneLblAttr];
  
  // FX 2 label
  NSDictionary *fxTwoLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *fxTwoLblStr = [[NSAttributedString alloc]
                                     initWithString:@"2"
                                     attributes:fxTwoLblAttr];
  
  // FX 3 label
  NSDictionary *fxThreeLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *fxThreeLblStr = [[NSAttributedString alloc]
                                       initWithString:@"3"
                                       attributes:fxThreeLblAttr];
  
  // FX 4 label
  NSDictionary *fxFourLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *fxFourLblStr = [[NSAttributedString alloc]
                                      initWithString:@"4"
                                      attributes:fxFourLblAttr];
  
  // Pre label
  NSDictionary *preLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *preLblStr = [[NSAttributedString alloc]
                                   initWithString:@"PRE"
                                   attributes:preLblAttr];
  
  // Pre L label
  NSDictionary *preLeftLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *preLeftLblStr = [[NSAttributedString alloc]
                                       initWithString:@"L"
                                       attributes:preLeftLblAttr];
  
  // Pre R label
  NSDictionary *preRightLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *preRightLblStr = [[NSAttributedString alloc]
                                        initWithString:@"R"
                                        attributes:preRightLblAttr];
  
  // Post label
  NSDictionary *postLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *postLblStr = [[NSAttributedString alloc]
                                    initWithString:@"POST"
                                    attributes:postLblAttr];
  
  // Post L label
  NSDictionary *postLeftLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *postLeftLblStr = [[NSAttributedString alloc]
                                        initWithString:@"L"
                                        attributes:postLeftLblAttr];
  
  // Post R label
  NSDictionary *postRightLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *postRightLblStr = [[NSAttributedString alloc]
                                         initWithString:@"R"
                                         attributes:postRightLblAttr];
  
  // Filter label
  NSDictionary *filterLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *filterLblStr = [[NSAttributedString alloc]
                                      initWithString:@"FILTER"
                                      attributes:filterLblAttr];
  
  // Flux mode label
  NSDictionary *fluxModeLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *fluxModeLblStr = [[NSAttributedString alloc]
                                        initWithString:@"FLUX MODE"
                                        attributes:fluxModeLblAttr];
  
  // Loop active label
  NSDictionary *loopActiveLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *loopActiveLblStr = [[NSAttributedString alloc]
                                          initWithString:@"LOOP ACTIVE"
                                          attributes:loopActiveLblAttr];
  
  // ***** Calculate dimensions *****
  
  CGFloat width = track.frame.size.width;
  CGFloat height = track.frame.size.height + SPACE_BELOW_TRACK + fx1.frame.size.height + \
    SPACE_BELOW_ON_OFF + preLblStr.size.height + SPACE_BELOW_PRE_LABEL + \
    preLeft.frame.size.height + SPACE_BELOW_PRE_LEFT_LVL + preLeftLblStr.size.height;
  
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  if (self) {
    self.track = track;
    self.fx1 = fx1;
    self.fx2 = fx2;
    self.fx3 = fx3;
    self.fx4 = fx4;
    self.preLeft = preLeft;
    self.preRight = preRight;
    self.postLeft = postLeft;
    self.postRight = postRight;
    self.filter = filter;
    self.fluxMode = fluxMode;
    self.loopActive = loopActive;
    
    self.fxLblStr = fxLblStr;
    self.fxOneLblStr = fxOneLblStr;
    self.fxTwoLblStr = fxTwoLblStr;
    self.fxThreeLblStr = fxThreeLblStr;
    self.fxFourLblStr = fxFourLblStr;
    self.preLblStr = preLblStr;
    self.preLeftLblStr = preLeftLblStr;
    self.preRightLblStr = preRightLblStr;
    self.postLblStr = postLblStr;
    self.postLeftLblStr = postLeftLblStr;
    self.postRightLblStr = postRightLblStr;
    self.filterLblStr = filterLblStr;
    self.fluxModeLblStr = fluxModeLblStr;
    self.loopActiveLblStr = loopActiveLblStr;
    
    self.opaque = NO; // Remove default black background
  }
  return self;
}

- (void)layoutSubviews {
  
  // ***** Track *****
  
  [self addSubview:self.track];
  
  self.track.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint track's dimensions to its frame size
  [self.track addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.track
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.track.frame.size.width]];
  [self.track addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.track
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.track.frame.size.height]];
  // Align track center horizontally
  [self.track.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.track
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.track.superview
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.f
                                       constant:0.f]];
  // Position dive/raise view a specific distance from the top of the view
  [self.track.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.track
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.track.superview
                                       attribute:NSLayoutAttributeTop
                                       multiplier:1.f
                                       constant:0]];
  
  // ***** FX *****
  
  CGFloat fxOnOffYPos = self.track.frame.size.height + SPACE_BELOW_TRACK;
  
  // + FX 4 +
  
  [self addSubview:self.fx4];
  
  self.fx4.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint FX 4's dimensions to its frame size
  [self.fx4 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx4
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx4.frame.size.width]];
  [self.fx4 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx4
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx4.frame.size.height]];
  // Position FX 4 a specific distance from the left of the view
  [self.fx4.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx4
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx4.superview
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.f
                                     constant:-SPACE_BTW_FX_N_EDGE]];
  // Position FX 4 a specific distance from the top of the view
  [self.fx4.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx4
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx4.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:fxOnOffYPos]];
  
  // + FX 3 +
  
  [self addSubview:self.fx3];
  
  self.fx3.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint FX 3's dimensions to its frame size
  [self.fx3 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx3
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx3.frame.size.width]];
  [self.fx3 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx3
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx3.frame.size.height]];
  // Position FX 3 a specific distance from the left of the view
  CGFloat fx3SpaceToEdge = SPACE_BTW_FX_N_EDGE + self.fx4.frame.size.width + \
    SPACE_BTW_FX_N_ELEMENT + self.fxFourLblStr.size.width + SPACE_BTW_FX_N_ELEMENT;
  [self.fx3.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx3
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx3.superview
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.f
                                     constant:-fx3SpaceToEdge]];
  // Position FX 3 a specific distance from the top of the view
  [self.fx3.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx3
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx3.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:fxOnOffYPos]];
  
  // + FX 2 +
  
  [self addSubview:self.fx2];
  
  self.fx2.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint FX 2's dimensions to its frame size
  [self.fx2 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx2
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx2.frame.size.width]];
  [self.fx2 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx2
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx2.frame.size.height]];
  // Position FX 2 a specific distance from the left of the view
  CGFloat fx2SpaceToEdge = SPACE_BTW_FX_N_EDGE + self.fx4.frame.size.width + \
    SPACE_BTW_FX_N_ELEMENT + self.fxFourLblStr.size.width + SPACE_BTW_FX_N_ELEMENT + \
    self.fx3.frame.size.width + SPACE_BTW_FX_N_ELEMENT + self.fxThreeLblStr.size.width + \
    SPACE_BTW_FX_N_ELEMENT;
  [self.fx2.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx2
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx2.superview
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.f
                                     constant:-fx2SpaceToEdge]];
  // Position FX 2 a specific distance from the top of the view
  [self.fx2.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx2
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx2.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:fxOnOffYPos]];
  
  // + FX 1 +
  
  [self addSubview:self.fx1];
  
  self.fx1.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint FX 1's dimensions to its frame size
  [self.fx1 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx1
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx1.frame.size.width]];
  [self.fx1 addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.fx1
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:self.fx1.frame.size.height]];
  // Position FX 1 a specific distance from the right of the view
  CGFloat fx1SpaceToEdge = SPACE_BTW_FX_N_EDGE + self.fx4.frame.size.width + \
    SPACE_BTW_FX_N_ELEMENT + self.fxFourLblStr.size.width + SPACE_BTW_FX_N_ELEMENT + \
    self.fx3.frame.size.width + SPACE_BTW_FX_N_ELEMENT + self.fxThreeLblStr.size.width + \
    SPACE_BTW_FX_N_ELEMENT + self.fx2.frame.size.width + SPACE_BTW_FX_N_ELEMENT + \
    self.fxTwoLblStr.size.width + SPACE_BTW_FX_N_ELEMENT;
  [self.fx1.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx1
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx1.superview
                                     attribute:NSLayoutAttributeRight
                                     multiplier:1.f
                                     constant:-fx1SpaceToEdge]];
  // Position FX 1 a specific distance from the top of the view
  [self.fx1.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fx1
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.fx1.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:fxOnOffYPos]];
  
  // ***** Secondary section *****
  
  // *** Pre-levels ***
  
  CGFloat secSectionEleYPos = self.track.frame.size.height + SPACE_BELOW_TRACK + \
    self.fx1.frame.origin.y + self.fx1.frame.size.height + SPACE_BELOW_FX + \
    self.preLblStr.size.height + SPACE_BELOW_SECTION_LBL;
  
  // + Left pre-level +
  
  [self addSubview:self.preLeft];
  
  self.preLeft.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint left pre-levels's dimensions to its frame size
  [self.preLeft addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.preLeft
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                               multiplier:1.0
                               constant:self.preLeft.frame.size.width]];
  [self.preLeft addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.preLeft
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                               multiplier:1.0
                               constant:self.preLeft.frame.size.height]];
  // Position left pre-levels a specific distance from the left of the view
  CGFloat preLvlLXPos = SPACE_BTW_SECTION_N_EDGE;
  [self.preLeft.superview addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.preLeft
                                         attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.preLeft.superview
                                         attribute:NSLayoutAttributeLeft
                                         multiplier:1.f
                                         constant:preLvlLXPos]];
  // Position left pre-levels a specific distance from the top of the view
  [self.preLeft.superview addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.preLeft
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.preLeft.superview
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.f
                                         constant:secSectionEleYPos]];
  
  // + Right pre-level +
  
  [self addSubview:self.preRight];
  
  self.preRight.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint right pre-levels's dimensions to its frame size
  [self.preRight addConstraint:[NSLayoutConstraint
                                constraintWithItem:self.preRight
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                constant:self.preRight.frame.size.width]];
  [self.preRight addConstraint:[NSLayoutConstraint
                                constraintWithItem:self.preRight
                                attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                constant:self.preRight.frame.size.height]];
  // Position right pre-levels a specific distance from the left of the view
  CGFloat preLvlRXPos = SPACE_BTW_SECTION_N_EDGE + self.preLeft.frame.size.width + \
    SPACE_BTW_LEVELS;
  [self.preRight.superview addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.preRight
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.preRight.superview
                                          attribute:NSLayoutAttributeLeft
                                          multiplier:1.f
                                          constant:preLvlRXPos]];
  // Position right pre-levels a specific distance from the top of the view
  [self.preRight.superview addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.preRight
                                          attribute:NSLayoutAttributeTop
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.preRight.superview
                                          attribute:NSLayoutAttributeTop
                                          multiplier:1.f
                                          constant:secSectionEleYPos]];
  
  // *** Post-levels ***
  
  // + Left post-level +
  
  [self addSubview:self.postLeft];
  
  self.postLeft.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint left post-levels's dimensions to its frame size
  [self.postLeft addConstraint:[NSLayoutConstraint
                                constraintWithItem:self.postLeft
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                constant:self.postLeft.frame.size.width]];
  [self.postLeft addConstraint:[NSLayoutConstraint
                                constraintWithItem:self.postLeft
                                attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                constant:self.preLeft.frame.size.height]];
  // Position left post-levels a specific distance from the left of the view
  CGFloat postLvlLXPos = SPACE_BTW_SECTION_N_EDGE + self.preLeft.frame.size.width + \
    SPACE_BTW_LEVELS + self.preRight.frame.size.width + SPACE_BTW_PRE_POST;
  [self.postLeft.superview addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.postLeft
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.postLeft.superview
                                          attribute:NSLayoutAttributeLeft
                                          multiplier:1.f
                                          constant:postLvlLXPos]];
  // Position left post-levels a specific distance from the top of the view
  [self.postLeft.superview addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.postLeft
                                          attribute:NSLayoutAttributeTop
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.postLeft.superview
                                          attribute:NSLayoutAttributeTop
                                          multiplier:1.f
                                          constant:secSectionEleYPos]];
  
  // + Right post-level +
  
  [self addSubview:self.postRight];
  
  self.postRight.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint right post-levels's dimensions to its frame size
  [self.postRight addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.postRight
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.postRight.frame.size.width]];
  [self.postRight addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.postRight
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.postRight.frame.size.height]];
  // Position right post-levels a specific distance from the left of the view
  CGFloat postLvlRXPos = SPACE_BTW_SECTION_N_EDGE + self.preLeft.frame.size.width + \
    SPACE_BTW_LEVELS + self.postRight.frame.size.width + SPACE_BTW_PRE_POST + \
    self.postLeft.frame.size.width + SPACE_BTW_LEVELS;
  [self.postRight.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.postRight
                                           attribute:NSLayoutAttributeLeft
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.postRight.superview
                                           attribute:NSLayoutAttributeLeft
                                           multiplier:1.f
                                           constant:postLvlRXPos]];
  // Position right post-levels a specific distance from the top of the view
  [self.postRight.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.postRight
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.postRight.superview
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.f
                                           constant:secSectionEleYPos]];
  
  // + Filter level +
  
  [self addSubview:self.filter];
  
  self.filter.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint filter levels's dimensions to its frame size
  [self.filter addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.filter
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.filter.frame.size.width]];
  [self.filter addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.filter
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.filter.frame.size.height]];
  // Align filter level center horizontally
  [self.filter.superview addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.filter
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.filter.superview
                                        attribute:NSLayoutAttributeCenterX
                                        multiplier:1.f
                                        constant:0.f]];
  // Position filter level a specific distance from the top of the view
  [self.filter.superview addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.filter
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.filter.superview
                                        attribute:NSLayoutAttributeTop
                                        multiplier:1.f
                                        constant:secSectionEleYPos]];
  
  // ***** Flux mode and loop active *****
  
  CGFloat fluxLoopXPos = self.frame.size.width - SPACE_BTW_SECTION_N_EDGE - \
    (self.loopActiveLblStr.size.width/2) - (self.fluxMode.frame.size.width/2);
  
  // + Flux mode +
  
  [self addSubview:self.fluxMode];
  
  self.fluxMode.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint flux mode's dimensions to its frame size
  [self.fluxMode addConstraint:[NSLayoutConstraint
                                constraintWithItem:self.fluxMode
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                constant:self.fluxMode.frame.size.width]];
  [self.fluxMode addConstraint:[NSLayoutConstraint
                                constraintWithItem:self.fluxMode
                                attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                constant:self.fluxMode.frame.size.height]];
  // Position flux mode a specific distance from the left of the view
  [self.fluxMode.superview addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.fluxMode
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.fluxMode.superview
                                          attribute:NSLayoutAttributeLeft
                                          multiplier:1.f
                                          constant:fluxLoopXPos]];
  // Position flux mode a specific distance from the top of the view
  CGFloat fluxModeYPos = self.track.frame.size.height + SPACE_BELOW_TRACK + \
    self.fx1.frame.size.height + SPACE_BELOW_FX + self.fxOneLblStr.size.height + \
    SPACE_BELOW_SECTION_LBL;
  [self.fluxMode.superview addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.fluxMode
                                          attribute:NSLayoutAttributeTop
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.fluxMode.superview
                                          attribute:NSLayoutAttributeTop
                                          multiplier:1.f
                                          constant:fluxModeYPos]];
  
  // + Loop active +
  
  [self addSubview:self.loopActive];
  
  self.loopActive.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint loop active's dimensions to its frame size
  [self.loopActive addConstraint:[NSLayoutConstraint
                                  constraintWithItem:self.loopActive
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0
                                  constant:self.loopActive.frame.size.width]];
  [self.loopActive addConstraint:[NSLayoutConstraint
                                  constraintWithItem:self.loopActive
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0
                                  constant:self.loopActive.frame.size.height]];
  // Position loop active a specific distance from the left of the view
  [self.loopActive.superview addConstraint:[NSLayoutConstraint
                                            constraintWithItem:self.loopActive
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.loopActive.superview
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.f
                                            constant:fluxLoopXPos]];
  // Position loop active a specific distance from the top of the view
  CGFloat loopActiveYPos = self.track.frame.size.height + SPACE_BELOW_TRACK + \
  self.fx1.frame.size.height + SPACE_BELOW_FX + self.fxOneLblStr.size.height + \
    SPACE_BELOW_SECTION_LBL + self.fluxMode.frame.size.height + SPACE_BELOW_FLUX_MODE + \
    self.loopActiveLblStr.size.height + SPACE_BELOW_SECTION_LBL;
  [self.loopActive.superview addConstraint:[NSLayoutConstraint
                                            constraintWithItem:self.loopActive
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.loopActive.superview
                                            attribute:NSLayoutAttributeTop
                                            multiplier:1.f
                                            constant:loopActiveYPos]];
}

- (void)drawRect:(CGRect)rect {
  
  // ***** FX labels *****
  
  CGFloat fxNumLblYPos = self.fx1.center.y - (self.fxOneLblStr.size.height/2);
  
  // + FX 1 +
  
  CGFloat fx1LblXPos = self.fx1.frame.origin.x - SPACE_BTW_FX_N_ELEMENT - \
    self.fxOneLblStr.size.width;
  [self.fxOneLblStr drawAtPoint:CGPointMake(fx1LblXPos, fxNumLblYPos)];
  
  // + FX 2 +
  
  CGFloat fx2LblXPos = self.fx2.frame.origin.x - SPACE_BTW_FX_N_ELEMENT - \
    self.fxTwoLblStr.size.width;
  [self.fxTwoLblStr drawAtPoint:CGPointMake(fx2LblXPos, fxNumLblYPos)];
  
  // + FX 3 +
  
  CGFloat fx3LblXPos = self.fx3.frame.origin.x - SPACE_BTW_FX_N_ELEMENT - \
    self.fxThreeLblStr.size.width;
  [self.fxThreeLblStr drawAtPoint:CGPointMake(fx3LblXPos, fxNumLblYPos)];
  
  // + FX 4 ++
  
  CGFloat fx4LblXPos = self.fx4.frame.origin.x - SPACE_BTW_FX_N_ELEMENT - \
    self.fxFourLblStr.size.width;
  [self.fxFourLblStr drawAtPoint:CGPointMake(fx4LblXPos, fxNumLblYPos)];
  
  // + FX label +
  
  CGFloat fxLblXPos = SPACE_BTW_FX_N_EDGE;
  
  [self.fxLblStr drawAtPoint:CGPointMake(fxLblXPos, fxNumLblYPos)];
  
  // ***** Secondary section top levels (except flux mode) *****
  
  CGFloat secSectionLblYPos = self.fx1.frame.origin.y + self.fx1.frame.size.height + \
    SPACE_BELOW_FX;
  
  // + Pre-levels +
  
  CGFloat preLblXPos = self.preLeft.frame.origin.x + \
    ((self.preRight.frame.origin.x + self.preRight.frame.size.width - \
      self.preLeft.frame.origin.x) / 2) - (self.preLblStr.size.width/2);
  [self.preLblStr drawAtPoint:CGPointMake(preLblXPos, secSectionLblYPos)];
  
  // + Post-levels +
  
  CGFloat postLblXPos = self.postLeft.frame.origin.x + \
  ((self.postRight.frame.origin.x + self.postRight.frame.size.width - \
    self.postLeft.frame.origin.x) / 2) - (self.postLblStr.size.width/2);
  [self.postLblStr drawAtPoint:CGPointMake(postLblXPos, secSectionLblYPos)];
  
  // + Filter +
  
  CGFloat filterLblXPos = (self.frame.size.width/2) - (self.filterLblStr.size.width/2);
  [self.filterLblStr drawAtPoint:CGPointMake(filterLblXPos, secSectionLblYPos)];
  
  // ***** Levels L/R labels *****
  
  CGFloat lvlsLRYPos = self.preLeft.frame.origin.y + self.preLeft.frame.size.height + \
    SPACE_BELOW_PRE_LEFT_LVL;
  
  // + Pre-left level +
  
  CGFloat preLeftLblXPos = self.preLeft.frame.origin.x + (self.preLeft.frame.size.width/2) - \
    (self.preLeftLblStr.size.width/2);
  [self.preLeftLblStr drawAtPoint:CGPointMake(preLeftLblXPos, lvlsLRYPos)];
  
  // + Pre-right level +
  
  CGFloat preRightLblXPos = self.preRight.frame.origin.x + (self.preRight.frame.size.width/2) - \
  (self.preRightLblStr.size.width/2);
  [self.preRightLblStr drawAtPoint:CGPointMake(preRightLblXPos, lvlsLRYPos)];
  
  // + Post-left level +
  
  CGFloat postLeftLblXPos = self.postLeft.frame.origin.x + (self.postLeft.frame.size.width/2) - \
    (self.postLeftLblStr.size.width/2);
  [self.postLeftLblStr drawAtPoint:CGPointMake(postLeftLblXPos, lvlsLRYPos)];
  
  // + Post-right level +
  
  CGFloat postRightLblXPos = self.postRight.frame.origin.x + (self.postRight.frame.size.width/2) - \
    (self.postRightLblStr.size.width/2);
  [self.postRightLblStr drawAtPoint:CGPointMake(postRightLblXPos, lvlsLRYPos)];
  
  // ***** Flux mode and loop active labels *****
  
  // + Loop active +
  
  CGFloat loopActiveLblXPos = self.frame.size.width - SPACE_BTW_SECTION_N_EDGE - \
    self.loopActiveLblStr.size.width;
  CGFloat loopActiveLblYPos = self.fluxMode.frame.origin.y + self.fluxMode.frame.size.height + \
    SPACE_BELOW_FLUX_MODE;
  [self.loopActiveLblStr drawAtPoint:CGPointMake(loopActiveLblXPos, loopActiveLblYPos)];
  
  // + Flux mode +
  
  CGFloat fluxModeLblXPos = self.frame.size.width - SPACE_BTW_SECTION_N_EDGE - \
    (self.loopActiveLblStr.size.width/2) - (self.fluxModeLblStr.size.width/2);
  CGFloat fluxModeLblYPos = secSectionLblYPos;
  [self.fluxModeLblStr drawAtPoint:CGPointMake(fluxModeLblXPos, fluxModeLblYPos)];
}

#pragma mark Properties

// ***** Label *****

- (void)setLabel:(NSString *)label {
  self.track.label = label;
}

- (NSString *)label {
  return self.track.label;
}

// ***** Track progress *****

- (void)setTrackProgress:(float)trackProgress {
  self.track.trackProgress = trackProgress;
}

- (float)trackProgress {
  return self.track.trackProgress;
}

// ***** Track ending *****

- (void)setTrackEnding:(BOOL)trackEnding {
  self.track.trackEnding = trackEnding;
}

- (BOOL)trackEnding {
  return self.track.trackEnding;
}

// ***** FX 1 is on *****

- (void)setFx1IsOn:(BOOL)fx1IsOn {
  self.fx1.isOn = fx1IsOn;
}

- (BOOL)fx1IsOn {
  return self.fx1.isOn;
}

// ***** FX 2 is on *****

- (void)setFx2IsOn:(BOOL)fx2IsOn {
  self.fx2.isOn = fx2IsOn;
}

- (BOOL)fx2IsOn {
  return self.fx2.isOn;
}

// ***** FX 3 is on *****

- (void)setFx3IsOn:(BOOL)fx3IsOn {
  self.fx3.isOn = fx3IsOn;
}

- (BOOL)fx3IsOn {
  return self.fx3IsOn;
}

// ***** FX 4 is on *****

- (void)setFx4IsOn:(BOOL)fx4IsOn {
  self.fx4.isOn = fx4IsOn;
}

- (BOOL)fx4IsOn {
  return self.fx4.isOn;
}

// ***** Pre left level *****

- (void)setPreLeftLevel:(float)preLeftLevel {
  self.preLeft.level = preLeftLevel;
}

- (float)preLeftLevel {
  return self.preLeft.level;
}

// ***** Pre right level *****

- (void)setPreRightLevel:(float)preRightLevel {
  self.preRight.level = preRightLevel;
}

- (float)preRightLevel {
  return self.preRight.level;
}

// ***** Post left level *****

- (void)setPostLeftLevel:(float)postLeftLevel {
  self.postLeft.level = postLeftLevel;
}

- (float)postLeftLevel {
  return self.postLeft.level;
}

// ***** Post right level *****

- (void)setPostRightLevel:(float)postRightLevel {
  self.postRight.level = postRightLevel;
}

- (float)postRightLevel {
  return self.postRight.level;
}

// ***** Filter level *****

- (void)setFilterLevel:(float)filterLevel {
  self.filter.level = filterLevel;
}

- (float)filterLevel {
  return self.filter.level;
}

// ***** Flux mode is on *****

- (void)setFluxModeIsOn:(BOOL)fluxModeIsOn {
  self.fluxMode.isOn = fluxModeIsOn;
}

- (BOOL)fluxModeIsOn {
  return self.fluxMode.isOn;
}

// ***** Loop active is on *****

- (void)setLoopActiveIsOn:(BOOL)loopActiveIsOn {
  self.loopActive.isOn = loopActiveIsOn;
}

- (BOOL)loopActiveIsOn {
  return self.loopActive.isOn;
}

@end
