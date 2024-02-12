//
//  ViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 15/12/15.
//  Copyright © 2015 Sonicwarper. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"
#import "UIImage+Sonicwarper.h"
#import "DataController.h"
#import "AppDelegate.h"

// View controllers.
#import "SettingsViewController.h"
#import "ConfigureButtonViewController.h"

// Views.
#import "BowswitchView.h"
#import "FullTempoClockView.h"
#import "FullMasterLevelsView.h"
#import "FullMotionLevelsView.h"
#import "FullDeckView.h"
#import "EditModeView.h"

// Singletons.
#import "Settings.h"
#import "MIDIEngine.h"
#import "MotionEngine.h"
#import "TraktorProMIDIDictionary.h"
#import "TraktorProMIDIMessageConstants.h"

@interface ViewController()

@property (nonatomic, weak) EditModeView *editMode;

@property (nonatomic, weak) BowswitchView *leftmostBowswitch;
@property (nonatomic, weak) BowswitchView *leftMidBowswitch;
@property (nonatomic, weak) BowswitchView *rightMidBowswitch;
@property (nonatomic, weak) BowswitchView *rightmostBowswitch;

//@property (nonatomic, strong) FullTempoClockView *tempoClock;
@property (nonatomic, strong) UIImageView *sonichead;
@property (nonatomic, strong) FullMasterLevelsView *masterLevels;
@property (nonatomic, strong) FullMotionLevelsView *motionLevels;
@property (nonatomic, strong) FullDeckView *deckA;
@property (nonatomic, strong) FullDeckView *deckB;
@property (nonatomic, strong) FullDeckView *deckC;
@property (nonatomic, strong) FullDeckView *deckD;

// Motion engine subscriber IDs.
//@property (nonatomic) NSInteger steerId;
@property (nonatomic) NSInteger rotateId;
@property (nonatomic) NSInteger diveRaiseId;

@end

@implementation ViewController

#pragma mark Constants

static const CGFloat DECK_1_Y_POS = 134.0;
static const CGFloat SPACE_ABOVE_ELEMENT_TO_TOP = 12.0;
static const CGFloat SPACE_BELOW_DECK = 4.0;
static const CGFloat SPACE_BELOW_DIVIDER = 7.0;
static const CGFloat SPACE_BTW_ELEMENT_CENTER_N_EDGE = 355.5;
static const CGFloat SPACE_BTW_BOWSWITCH_CLOSEST_MID_CONVEX_SIDE_N_EDGE = 393.5;
static const CGFloat SPACE_BTW_BOWSWITCH_OUTERMOST_CONVEX_SIDE_N_EDGE = 256.5;
static const CGFloat DIVIDER_WIDTH = 200.0;
static const CGFloat DIVIDER_HEIGHT = 2.0;

#pragma mark Initializers

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.view.backgroundColor = [UIColor SWBlack];
    
    // Subscribe to MIDI engine.
    [[MIDIEngine shared] subscribe:self];

    // Subscribe to motion engine.
//    self.steerId = [[MotionEngine shared] subscribe:self motionType:MEMotionTypeSteer];
    self.rotateId = [[MotionEngine shared] subscribe:self motionType:MEMotionTypeRotate];
    self.diveRaiseId = [[MotionEngine shared] subscribe:self motionType:MEMotionTypeDiveRaise];
    
    // Activate mappings.
//    [[MotionEngine shared] activate:YES subscriber:self.steerId];
    [[MotionEngine shared] activate:YES subscriber:self.rotateId];
    [[MotionEngine shared] activate:YES subscriber:self.diveRaiseId];
    
    // Start motion engine.
    [MotionEngine shared].isStarted = YES;
  }
  return self;
}

- (void)dealloc {
  [[MIDIEngine shared] unsubscribe:self];
}

- (void)viewDidLoad {
  
  // ***** Bowswitches *****
  
  // + Leftmost bowswitch +
  BowswitchView *leftmostBowswitch = [[BowswitchView alloc]
                                      initWithBowswitchPosition:BSBowswitchPositionLeftMost];
  [self.view addSubview:leftmostBowswitch];
  self.leftmostBowswitch = leftmostBowswitch;
  leftmostBowswitch.delegate = self;
  
  leftmostBowswitch.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint leftmost bowswitch's dimensions to its frame size
  [leftmostBowswitch addConstraint:[NSLayoutConstraint
                                    constraintWithItem:leftmostBowswitch
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:leftmostBowswitch.frame.size.width]];
  [leftmostBowswitch addConstraint:[NSLayoutConstraint
                                    constraintWithItem:leftmostBowswitch
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:leftmostBowswitch.frame.size.height]];
  // Align Leftmost bowswitch center vertically
  [leftmostBowswitch.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:leftmostBowswitch
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:leftmostBowswitch.superview
                                              attribute:NSLayoutAttributeCenterY
                                              multiplier:1.f
                                              constant:0.f]];
  // Position Left-closest-to-middle bowswitch so the convex side of the switch is a specific
  // distance from the left edge of the screen
  CGFloat leftmostBowswitchCvxDist = SPACE_BTW_BOWSWITCH_OUTERMOST_CONVEX_SIDE_N_EDGE;
  [leftmostBowswitch.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:leftmostBowswitch
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:leftmostBowswitch.superview
                                              attribute:NSLayoutAttributeLeft
                                              multiplier:1.f
                                              constant:leftmostBowswitchCvxDist]];
  
  // + Left-closest-to-middle bowswitch +
  BowswitchView *leftMidBowswitch = [[BowswitchView alloc]
                                     initWithBowswitchPosition:BSBowswitchPositionLeftClosestToMiddle];
  [self.view addSubview:leftMidBowswitch];
  self.leftMidBowswitch = leftMidBowswitch;
  leftMidBowswitch.delegate = self;
  
  leftMidBowswitch.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint Left-closest-to-middle bowswitch's dimensions to its frame size
  [leftMidBowswitch addConstraint:[NSLayoutConstraint
                                   constraintWithItem:leftMidBowswitch
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                   multiplier:1.0
                                   constant:leftMidBowswitch.frame.size.width]];
  [leftMidBowswitch addConstraint:[NSLayoutConstraint
                                   constraintWithItem:leftMidBowswitch
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                   multiplier:1.0
                                   constant:leftMidBowswitch.frame.size.height]];
  // Align Left-closest-to-middle bowswitch center vertically
  [leftMidBowswitch.superview addConstraint:[NSLayoutConstraint
                                             constraintWithItem:leftMidBowswitch
                                             attribute:NSLayoutAttributeCenterY
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:leftMidBowswitch.superview
                                             attribute:NSLayoutAttributeCenterY
                                             multiplier:1.f
                                             constant:0.f]];
  // Position Left-closest-to-middle bowswitch so the convex side of the switch is a specific
  // distance from the left edge of the screen
  CGFloat leftMidBowSwitchCvxDist = SPACE_BTW_BOWSWITCH_CLOSEST_MID_CONVEX_SIDE_N_EDGE;
  [leftMidBowswitch.superview addConstraint:[NSLayoutConstraint
                                             constraintWithItem:leftMidBowswitch
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:leftMidBowswitch.superview
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.f
                                             constant:leftMidBowSwitchCvxDist]];
  
  // + Right-closest-to-middle bowswitch +
  BowswitchView *rightMidBowswitch = [[BowswitchView alloc]
                                      initWithBowswitchPosition:BSBowswitchPositionRightClosestToMiddle];
  [self.view addSubview:rightMidBowswitch];
  self.rightMidBowswitch = rightMidBowswitch;
  rightMidBowswitch.leftOriented = NO;
  rightMidBowswitch.delegate = self;
  
  rightMidBowswitch.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint right-closest-to-middle bowswitch's dimensions to its frame size
  [rightMidBowswitch addConstraint:[NSLayoutConstraint
                                    constraintWithItem:rightMidBowswitch
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:rightMidBowswitch.frame.size.width]];
  [rightMidBowswitch addConstraint:[NSLayoutConstraint
                                    constraintWithItem:rightMidBowswitch
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:rightMidBowswitch.frame.size.height]];
  // Align right-closest-to-middle bowswitch center vertically
  [rightMidBowswitch.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:rightMidBowswitch
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:rightMidBowswitch.superview
                                              attribute:NSLayoutAttributeCenterY
                                              multiplier:1.f
                                              constant:0.f]];
  // Position right-closest-to-middle bowswitch so the convex side of the switch is a specific
  // distance from the right edge of the screen
  CGFloat rightMidBowSwitchCvxDist = -SPACE_BTW_BOWSWITCH_CLOSEST_MID_CONVEX_SIDE_N_EDGE;
  [rightMidBowswitch.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:rightMidBowswitch
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:rightMidBowswitch.superview
                                              attribute:NSLayoutAttributeRight
                                              multiplier:1.f
                                              constant:rightMidBowSwitchCvxDist]];
  
  // + Rightmost bowswitch +
  BowswitchView *rightmostBowswitch = [[BowswitchView alloc]
                                       initWithBowswitchPosition:BSBowswitchPositionRightMost];
  [self.view addSubview:rightmostBowswitch];
  self.rightmostBowswitch = rightmostBowswitch;
  rightmostBowswitch.leftOriented = NO;
  rightmostBowswitch.delegate = self;
  
  rightmostBowswitch.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint rightmost bowswitch's dimensions to its frame size
  [rightmostBowswitch addConstraint:[NSLayoutConstraint
                                     constraintWithItem:rightmostBowswitch
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                     multiplier:1.0
                                     constant:rightmostBowswitch.frame.size.width]];
  [rightmostBowswitch addConstraint:[NSLayoutConstraint
                                     constraintWithItem:rightmostBowswitch
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                     multiplier:1.0
                                     constant:rightmostBowswitch.frame.size.height]];
  // Align right-closest-to-middle bowswitch center vertically
  [rightmostBowswitch.superview addConstraint:[NSLayoutConstraint
                                               constraintWithItem:rightmostBowswitch
                                               attribute:NSLayoutAttributeCenterY
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:rightmostBowswitch.superview
                                               attribute:NSLayoutAttributeCenterY
                                               multiplier:1.f
                                               constant:0.f]];
  // Position rightmost bowswitch so the convex side of the switch is a specific distance from the
  // right edge of the screen
  CGFloat rightmostBowswitchCvxDist = -SPACE_BTW_BOWSWITCH_OUTERMOST_CONVEX_SIDE_N_EDGE;
  [rightmostBowswitch.superview addConstraint:[NSLayoutConstraint
                                               constraintWithItem:rightmostBowswitch
                                               attribute:NSLayoutAttributeLeft
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:rightmostBowswitch.superview
                                               attribute:NSLayoutAttributeRight
                                               multiplier:1.f
                                               constant:rightmostBowswitchCvxDist]];
  
  // ***** Tempo clock *****
  
  // Note: hide the tempo clock for now - show Sonichead in its place.
  
//  self.tempoClock = [FullTempoClockView new];
//  [self.view addSubview:self.tempoClock];
  
//  self.tempoClock.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint tempo view's dimensions to its frame size
//  [self.tempoClock addConstraint:[NSLayoutConstraint
//                                  constraintWithItem:self.tempoClock
//                                  attribute:NSLayoutAttributeWidth
//                                  relatedBy:NSLayoutRelationEqual
//                                  toItem:nil
//                                  attribute:NSLayoutAttributeNotAnAttribute
//                                  multiplier:1.0
//                                  constant:self.tempoClock.frame.size.width]];
//  [self.tempoClock addConstraint:[NSLayoutConstraint
//                                  constraintWithItem:self.tempoClock
//                                  attribute:NSLayoutAttributeHeight
//                                  relatedBy:NSLayoutRelationEqual
//                                  toItem:nil
//                                  attribute:NSLayoutAttributeNotAnAttribute
//                                  multiplier:1.0
//                                  constant:self.tempoClock.frame.size.height]];
  // Position tempo view center X a specific distance from the left edge of the screen
//  CGFloat tempoClockCtrXDist = SPACE_BTW_ELEMENT_CENTER_N_EDGE;
//  [self.tempoClock.superview addConstraint:[NSLayoutConstraint
//                                            constraintWithItem:self.tempoClock
//                                            attribute:NSLayoutAttributeCenterX
//                                            relatedBy:NSLayoutRelationEqual
//                                            toItem:self.tempoClock.superview
//                                            attribute:NSLayoutAttributeLeft
//                                            multiplier:1.f
//                                            constant:tempoClockCtrXDist]];
  // Position tempo view center Y a specific distance from the top edge of the screen
//  CGFloat tempoClockTopDist = SPACE_ABOVE_ELEMENT_TO_TOP;
//  [self.tempoClock.superview addConstraint:[NSLayoutConstraint
//                                            constraintWithItem:self.tempoClock
//                                            attribute:NSLayoutAttributeTop
//                                            relatedBy:NSLayoutRelationEqual
//                                            toItem:self.tempoClock.superview
//                                            attribute:NSLayoutAttributeTop
//                                            multiplier:1.f
//                                            constant:tempoClockTopDist]];
  
  // ***** Sonichead *****
  
  self.sonichead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sonichead"]];
  [self.view addSubview:self.sonichead];
  
  self.sonichead.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint sonichead's dimensions to its frame size
  [self.sonichead addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.sonichead
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.sonichead.frame.size.width]];
  [self.sonichead addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self.sonichead
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:self.sonichead.frame.size.height]];
  // Position sonichead center X a specific distance from the left edge of the screen
  CGFloat sonicheadCtrXDist = SPACE_BTW_ELEMENT_CENTER_N_EDGE;
  [self.sonichead.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.sonichead
                                           attribute:NSLayoutAttributeCenterX
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.sonichead.superview
                                           attribute:NSLayoutAttributeLeft
                                           multiplier:1.f
                                           constant:sonicheadCtrXDist]];
  CGFloat sonicheadTopDist = SPACE_ABOVE_ELEMENT_TO_TOP + 7.5;
  [self.sonichead.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self.sonichead
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.sonichead.superview
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.f
                                           constant:sonicheadTopDist]];
  
  // ***** Full master levels *****
  
  self.masterLevels = [FullMasterLevelsView new];
  [self.view addSubview:self.masterLevels];
  
  self.masterLevels.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint full master levels's dimensions to its frame size
  [self.masterLevels addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.masterLevels
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:self.masterLevels.frame.size.width]];
  [self.masterLevels addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.masterLevels
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:self.masterLevels.frame.size.height]];
  // Position full master levels center X a specific distance from the right edge of the screen
  CGFloat masterLevelsCtrXDist = -SPACE_BTW_ELEMENT_CENTER_N_EDGE;
  [self.masterLevels.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:self.masterLevels
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.masterLevels.superview
                                              attribute:NSLayoutAttributeRight
                                              multiplier:1.f
                                              constant:masterLevelsCtrXDist]];
  // Position full master levels center Y a specific distance from the top edge of the screen
  CGFloat masterLevelsTopDist = SPACE_ABOVE_ELEMENT_TO_TOP;
  [self.masterLevels.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:self.masterLevels
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.masterLevels.superview
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.f
                                              constant:masterLevelsTopDist]];
  
  // ***** Full motion levels *****
  
  self.motionLevels = [FullMotionLevelsView new];
  [self.view addSubview:self.motionLevels];
  
  self.motionLevels.diveRaisePctIsDisabled = NO;
  self.motionLevels.rotatePctIsDisabled = NO;
  
  self.motionLevels.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint full motion levels' dimensions to its frame size
  [self.motionLevels addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.motionLevels
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:self.motionLevels.frame.size.width]];
  [self.motionLevels addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.motionLevels
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                    attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                    constant:self.motionLevels.frame.size.height]];
  // Align full motion level center horizontally
  [self.motionLevels.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:self.motionLevels
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.motionLevels.superview
                                              attribute:NSLayoutAttributeCenterX
                                              multiplier:1.f
                                              constant:0.f]];
  // Position full motion levels center Y a specific distance from the top edge of the screen
  CGFloat motionLevelsTopDist = SPACE_ABOVE_ELEMENT_TO_TOP;
  [self.motionLevels.superview addConstraint:[NSLayoutConstraint
                                              constraintWithItem:self.motionLevels
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.motionLevels.superview
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.f
                                              constant:motionLevelsTopDist]];

  // ***** Full deck *****
  
  // + Deck 1 +
  
  self.deckA = [FullDeckView new];
  [self.view addSubview:self.deckA];
  self.deckA.label = @"A";
  
  self.deckA.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint deck 1's dimensions to its frame size
  [self.deckA addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deckA
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.deckA.frame.size.width]];
  [self.deckA addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deckA
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.deckA.frame.size.height]];
  // Align deck 1's center horizontally
  [self.deckA.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckA
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckA.superview
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.f
                                       constant:0.f]];
  // Position deck 1 center Y a specific distance from the top edge of the screen
  CGFloat deckATopDist = DECK_1_Y_POS;
  [self.deckA.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckA
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckA.superview
                                       attribute:NSLayoutAttributeTop
                                       multiplier:1.f
                                       constant:deckATopDist]];

  
  // + Divider +
  
  UIView *divider1 = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              DIVIDER_WIDTH,
                                                              DIVIDER_HEIGHT)];
  [self.view addSubview:divider1];
  divider1.backgroundColor = [UIColor SWWhite12];
  
  divider1.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint divider's dimensions to its frame size
  [divider1 addConstraint:[NSLayoutConstraint
                           constraintWithItem:divider1
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:divider1.frame.size.width]];
  [divider1 addConstraint:[NSLayoutConstraint
                           constraintWithItem:divider1
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:divider1.frame.size.height]];
  // Align divider's center horizontally
  [divider1.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:divider1
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:divider1.superview
                                     attribute:NSLayoutAttributeCenterX
                                     multiplier:1.f
                                     constant:0.f]];
  // Position divider center Y a specific distance from the top edge of the screen
  CGFloat divider1TopDist = DECK_1_Y_POS + self.deckA.frame.size.height + SPACE_BELOW_DECK;
  [divider1.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:divider1
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:divider1.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:divider1TopDist]];
  
  // + Deck 2 +
  
  self.deckB = [FullDeckView new];
  [self.view addSubview:self.deckB];
  self.deckB.label = @"B";
  
  self.deckB.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint deck 2's dimensions to its frame size
  [self.deckB addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deckB
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.deckB.frame.size.width]];
  [self.deckB addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deckB
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.deckB.frame.size.height]];
  // Align deck 2's center horizontally
  [self.deckB.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckB
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckB.superview
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.f
                                       constant:0.f]];
  // Position deck 2 center Y a specific distance from the top edge of the screen
  CGFloat deckBTopDist = DECK_1_Y_POS + self.deckA.frame.size.height + SPACE_BELOW_DECK + \
    divider1.frame.size.height + SPACE_BELOW_DIVIDER;
  [self.deckB.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckB
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckA.superview
                                       attribute:NSLayoutAttributeTop
                                       multiplier:1.f
                                       constant:deckBTopDist]];
  
  // + Divider +
  
  UIView *divider2 = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              DIVIDER_WIDTH,
                                                              DIVIDER_HEIGHT)];
  [self.view addSubview:divider2];
  divider2.backgroundColor = [UIColor SWWhite12];
  
  divider2.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint divider's dimensions to its frame size
  [divider2 addConstraint:[NSLayoutConstraint
                           constraintWithItem:divider2
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:divider2.frame.size.width]];
  [divider2 addConstraint:[NSLayoutConstraint
                           constraintWithItem:divider2
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:divider2.frame.size.height]];
  // Align divider's center horizontally
  [divider2.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:divider2
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:divider2.superview
                                     attribute:NSLayoutAttributeCenterX
                                     multiplier:1.f
                                     constant:0.f]];
  // Position divider center Y a specific distance from the top edge of the screen
  CGFloat divider2TopDist = DECK_1_Y_POS + self.deckA.frame.size.height + SPACE_BELOW_DECK + \
    divider1.frame.size.height + SPACE_BELOW_DIVIDER + self.deckB.frame.size.height + \
    SPACE_BELOW_DECK;
  [divider2.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:divider2
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:divider2.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:divider2TopDist]];
  
  // + Deck 3 +
  
  self.deckC = [FullDeckView new];
  [self.view addSubview:self.deckC];
  self.deckC.label = @"C";
  
  self.deckC.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint deck 3's dimensions to its frame size
  [self.deckC addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deckC
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.deckC.frame.size.width]];
  [self.deckC addConstraint:[NSLayoutConstraint
                        constraintWithItem:self.deckC
                        attribute:NSLayoutAttributeHeight
                        relatedBy:NSLayoutRelationEqual
                        toItem:nil
                        attribute:NSLayoutAttributeNotAnAttribute
                        multiplier:1.0
                        constant:self.deckC.frame.size.height]];
  // Align deck 3's center horizontally
  [self.deckC.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckC
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckC.superview
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.f
                                       constant:0.f]];
  // Position deck 3 center Y a specific distance from the top edge of the screen
  CGFloat deckCTopDist = DECK_1_Y_POS + self.deckA.frame.size.height + SPACE_BELOW_DECK + \
    divider1.frame.size.height + SPACE_BELOW_DIVIDER + self.deckB.frame.size.height + \
    SPACE_BELOW_DECK + divider2.frame.size.height + SPACE_BELOW_DIVIDER;
  [self.deckC.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckC
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckC.superview
                                       attribute:NSLayoutAttributeTop
                                       multiplier:1.f
                                       constant:deckCTopDist]];
  
  // + Divider +
  
  UIView *divider3 = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              DIVIDER_WIDTH,
                                                              DIVIDER_HEIGHT)];
  [self.view addSubview:divider3];
  divider3.backgroundColor = [UIColor SWWhite12];
  
  divider3.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint divider's dimensions to its frame size
  [divider3 addConstraint:[NSLayoutConstraint
                           constraintWithItem:divider3
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:divider3.frame.size.width]];
  [divider3 addConstraint:[NSLayoutConstraint
                           constraintWithItem:divider3
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:divider3.frame.size.height]];
  // Align divider's center horizontally
  [divider3.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:divider3
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:divider3.superview
                                     attribute:NSLayoutAttributeCenterX
                                     multiplier:1.f
                                     constant:0.f]];
  // Position divider center Y a specific distance from the top edge of the screen
  CGFloat divider3TopDist = DECK_1_Y_POS + self.deckA.frame.size.height + SPACE_BELOW_DECK + \
    divider1.frame.size.height + SPACE_BELOW_DIVIDER + self.deckB.frame.size.height + \
    SPACE_BELOW_DECK + divider2.frame.size.height + SPACE_BELOW_DIVIDER + \
    self.deckC.frame.size.height + SPACE_BELOW_DECK;
  [divider3.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:divider3
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:divider3.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:divider3TopDist]];
  
  // + Deck 4 +
  
  self.deckD = [FullDeckView new];
  [self.view addSubview:self.deckD];
  self.deckD.label = @"D";
  
  self.deckD.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint deck 4's dimensions to its frame size
  [self.deckD addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deckD
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.deckD.frame.size.width]];
  [self.deckD addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.deckD
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0
                             constant:self.deckD.frame.size.height]];
  // Align deck 4's center horizontally

  [self.deckD.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckD
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckD.superview
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.f
                                       constant:0.f]];
  // Position deck 4 center Y a specific distance from the top edge of the screen
  CGFloat deckDTopDist = DECK_1_Y_POS + self.deckA.frame.size.height + SPACE_BELOW_DECK + \
    divider1.frame.size.height + SPACE_BELOW_DIVIDER + self.deckB.frame.size.height + \
    SPACE_BELOW_DECK + divider2.frame.size.height + SPACE_BELOW_DIVIDER + \
    self.deckC.frame.size.height + SPACE_BELOW_DECK + divider3.frame.size.height + \
    SPACE_BELOW_DIVIDER;
  [self.deckD.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.deckD
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.deckD.superview
                                       attribute:NSLayoutAttributeTop
                                       multiplier:1.f
                                       constant:deckDTopDist]];
  
  
  // ***** Settings button *****
  
  UIButton *settings = [UIButton buttonWithType:UIButtonTypeCustom];
  [settings addTarget:self
               action:@selector(showSettingsMenu)
     forControlEvents:UIControlEventTouchUpInside];
  
  // Common text attributes
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  // Settings button label
  NSDictionary *settingsLblAttr = @{
    NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                        size:[Fonts SmallSize]],
    NSForegroundColorAttributeName:[UIColor SWWhite87],
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *settingsLblStr = [[NSAttributedString alloc]
                                        initWithString:@"SETTINGS"
                                        attributes:settingsLblAttr];
  
  [settings setAttributedTitle:settingsLblStr forState:UIControlStateNormal];
  [settings setBackgroundImage:[UIImage imageWithColor:[UIColor SWBlue]]
                      forState:UIControlStateNormal];
  [settings setBackgroundImage:[UIImage imageWithColor:[UIColor SWBlueDark]]
                      forState:UIControlStateSelected];
  settings.frame = CGRectMake(0, 0, 75, 22);
  
  [self.view addSubview:settings];
  
  settings.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint settings's dimensions to its frame size
  [settings addConstraint:[NSLayoutConstraint
                           constraintWithItem:settings
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:settings.frame.size.width]];
  [settings addConstraint:[NSLayoutConstraint
                           constraintWithItem:settings
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:settings.frame.size.height]];
  // Align settings's center horizontally
  [settings.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:settings
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:settings.superview
                                     attribute:NSLayoutAttributeCenterX
                                     multiplier:1.f
                                     constant:0.f]];
  // Position settings center Y a specific distance from the top edge of the screen
  CGFloat settingsTopDist = DECK_1_Y_POS + self.deckA.frame.size.height + SPACE_BELOW_DECK + \
    divider1.frame.size.height + SPACE_BELOW_DIVIDER + self.deckB.frame.size.height + \
    SPACE_BELOW_DECK + divider2.frame.size.height + SPACE_BELOW_DIVIDER + \
    self.deckC.frame.size.height + SPACE_BELOW_DECK + divider3.frame.size.height + \
    SPACE_BELOW_DIVIDER + self.deckD.frame.size.height + SPACE_BELOW_DECK + \
    divider3.frame.size.height + SPACE_BELOW_DIVIDER;
  [settings.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:settings
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:settings.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:settingsTopDist]];
  
  // ***** Edit mode *****
  
  EditModeView *editMode = [EditModeView new];
  [self.view addSubview:editMode];
  self.editMode = editMode;
  
  editMode.translatesAutoresizingMaskIntoConstraints = NO;
  
  // Constraint edit mode's dimensions to its frame size
  [editMode addConstraint:[NSLayoutConstraint
                           constraintWithItem:editMode
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                           constant:editMode.frame.size.width]];
  [editMode addConstraint:[NSLayoutConstraint
                           constraintWithItem:editMode
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1.0
                                constant:editMode.frame.size.height]];
  // Position loop active's center a specific distance from the left of the view
  CGFloat editModeXDist = SPACE_BTW_ELEMENT_CENTER_N_EDGE;
  [editMode.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:editMode
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:editMode.superview
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1.f
                                     constant:editModeXDist]];
  // Position settings center Y a specific distance from the top edge of the screen
  CGFloat editModeYPos = settingsTopDist + (settings.frame.size.height/2) - \
    (editMode.frame.size.height/2);
  [editMode.superview addConstraint:[NSLayoutConstraint
                                     constraintWithItem:editMode
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:editMode.superview
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.f
                                     constant:editModeYPos]];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  Settings * settings = [Settings shared];
  [self showEditMode:settings.editModeIsOn];
}

-(BOOL)prefersStatusBarHidden { return YES; }

#pragma mark - Helper methods

- (void)refreshLooks {
  // Leftmost bowswitch.
  for (NSInteger i = 0; i < BSButtonCount; i++) {
    ButtonLook *look = [self.looks lookForBowswitch:BSBowswitchPositionLeftMost button:i];
    [self.leftmostBowswitch setLook:look forButton:i];
  }
  
  // Leftmid bowswitch.
  for (NSInteger i = 0; i < BSButtonCount; i++) {
    ButtonLook *look = [self.looks lookForBowswitch:BSBowswitchPositionLeftClosestToMiddle button:i];
    [self.leftMidBowswitch setLook:look forButton:i];
  }

  // Rightmid bowswitch.
  for (NSInteger i = 0; i < BSButtonCount; i++) {
    ButtonLook *look = [self.looks lookForBowswitch:BSBowswitchPositionRightClosestToMiddle button:i];
    [self.rightMidBowswitch setLook:look forButton:i];
  }

  // Rightmost bowswitch.
  for (NSInteger i = 0; i < BSButtonCount; i++) {
    ButtonLook *look = [self.looks lookForBowswitch:BSBowswitchPositionRightMost button:i];
    [self.rightmostBowswitch setLook:look forButton:i];
  }
}

#pragma mark - BowswitchViewDelegate methods

- (BOOL)willChangeState:(BSButtonState)state
              forButton:(BSButtonPosition)button
          fromBowswitch:(BSBowswitchPosition)bowswitch {
  Settings *settings = [Settings shared];
  if (settings.editModeIsOn) {
    // Allow state change for all buttons in edit mode.
    return YES;
  } else {
    // Do not allow state change for empty buttons except in edit mode.
    BSButtonColor color = BSButtonColorEmpty;
    if (bowswitch == BSBowswitchPositionLeftMost) {
      color = [self.leftmostBowswitch getColorForButton:button];
    } else if (bowswitch == BSBowswitchPositionLeftClosestToMiddle) {
      color = [self.leftMidBowswitch getColorForButton:button];
    } else if (bowswitch == BSBowswitchPositionRightClosestToMiddle) {
      color = [self.rightMidBowswitch getColorForButton:button];
    } else if (bowswitch == BSBowswitchPositionRightMost) {
      color = [self.rightmostBowswitch getColorForButton:button];
    }    
    if (color != BSButtonColorEmpty) {
      return YES;
    }
  }
  return NO;
}

- (void)didChangedState:(BSButtonState)state
              forButton:(BSButtonPosition)button
          fromBowswitch:(BSBowswitchPosition)bowswitch {
  
  Settings *settings = [Settings shared];
  if (settings.editModeIsOn && state == BSButtonStateTouchedIn) {
    // Do nothing.
  } else if (settings.editModeIsOn && state == BSButtonStateTouchedOut) {
    // Show configure button view controller.
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *conNav = (UINavigationController *)[main instantiateViewControllerWithIdentifier:@"ConfigureButtonNav"];
    conNav.modalPresentationStyle = UIModalPresentationFormSheet;
    conNav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    ConfigureButtonViewController *conVC =
      (ConfigureButtonViewController *)conNav.viewControllers[0];
    conVC.bowswitch = bowswitch;
    conVC.button = button;
    [self presentViewController:conNav animated:YES completion:nil];
  } else {
    // Cause button to behave.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [self.behaviors behaveButton:button bowswitch:bowswitch state:state];
    });
  }
}

#pragma mark - Action methods

- (void)showSettingsMenu {
  UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  UINavigationController *setNav = (UINavigationController *)[main instantiateViewControllerWithIdentifier:@"SettingsNav"];
  setNav.modalPresentationStyle = UIModalPresentationFormSheet;
  setNav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  SettingsViewController *setVC = (SettingsViewController *)setNav.viewControllers[0];
  setVC.parentVC = self;
  [self presentViewController:setNav animated:YES completion:nil];
}

- (void)showEditMode:(BOOL)show {
  self.editMode.hidden = !show;
}

#pragma mark - MIEMIDISubscriber methods

- (void)updateWithMIDICommand:(MIKMIDICommand *)command {
  // Update UI.
  
  // ***** Master levels *****
  
  // * Master levels left *
  if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_MasterOutLevelLOutGlobalOutput_CC:command]) {
    self.masterLevels.leftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Master levels right *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_MasterOutLevelROutGlobalOutput_CC:command]) {
    self.masterLevels.rightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // ***** Deck A *****
  
  // * Seek position *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckAOutput_CC: command]) {
    self.deckA.trackProgress = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * FX 1 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_On: command]) {
    //  - On
    self.deckA.fx1IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_Off: command]) {
    //  - Off
    self.deckA.fx1IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 2 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_On: command]) {
    //  - On
    self.deckA.fx2IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_Off: command]) {
    //  - Off
    self.deckA.fx2IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 3 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_On: command]) {
    //  - On
    self.deckA.fx3IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_Off: command]) {
    //  - Off
    self.deckA.fx3IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 4 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_On: command]) {
    //  - On
    self.deckA.fx4IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_Off: command]) {
    //  - Off
    self.deckA.fx4IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Pre-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckAOutput_CC: command]) {
    self.deckA.preLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Pre-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckAOutput_CC: command]) {
    self.deckA.preRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckAOutput_CC: command]) {
    self.deckA.postLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckAOutput_CC: command]) {
    self.deckA.postRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Filter *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FilterAdjustOutDeckAOutput_CC: command]) {
    self.deckA.filterLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Flux mode *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_On: command]) {
    //  - On
    self.deckA.fluxModeIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_Off: command]) {
    //  - Off
    self.deckA.fluxModeIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Loop active *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_On: command]) {
    //  - On
    self.deckA.loopActiveIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_Off: command]) {
    //  - Off
    self.deckA.loopActiveIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // ***** Deck B *****
  
  // * Seek position *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckBOutput_CC: command]) {
    self.deckB.trackProgress = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * FX 1 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_On: command]) {
    //  - On
    self.deckB.fx1IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_Off: command]) {
    //  - Off
    self.deckB.fx1IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 2 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_On: command]) {
    //  - On
    self.deckB.fx2IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_Off: command]) {
    //  - Off
    self.deckB.fx2IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 3 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_On: command]) {
    //  - On
    self.deckB.fx3IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_Off: command]) {
    //  - Off
    self.deckB.fx3IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 4 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_On: command]) {
    //  - On
    self.deckB.fx4IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_Off: command]) {
    //  - Off
    self.deckB.fx4IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Pre-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckBOutput_CC: command]) {
    self.deckB.preLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Pre-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckBOutput_CC: command]) {
    self.deckB.preRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckBOutput_CC: command]) {
    self.deckB.postLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckBOutput_CC: command]) {
    self.deckB.postRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Filter *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FilterAdjustOutDeckBOutput_CC: command]) {
    self.deckB.filterLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Flux mode *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_On: command]) {
    //  - On
    self.deckB.fluxModeIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_Off: command]) {
    //  - Off
    self.deckB.fluxModeIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Loop active *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_On: command]) {
    //  - On
    self.deckB.loopActiveIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_Off: command]) {
    //  - Off
    self.deckB.loopActiveIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // ***** Deck C *****
  
  // * Seek position *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckCOutput_CC: command]) {
    self.deckC.trackProgress = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * FX 1 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_On: command]) {
    //  - On
    self.deckC.fx1IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_Off: command]) {
    //  - Off
    self.deckC.fx1IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 2 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_On: command]) {
    //  - On
    self.deckC.fx2IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_Off: command]) {
    //  - Off
    self.deckC.fx2IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 3 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_On: command]) {
    //  - On
    self.deckC.fx3IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_Off: command]) {
    //  - Off
    self.deckC.fx3IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 4 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_On: command]) {
    //  - On
    self.deckC.fx4IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_Off: command]) {
    //  - Off
    self.deckC.fx4IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Pre-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckCOutput_CC: command]) {
    self.deckC.preLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Pre-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckCOutput_CC: command]) {
    self.deckC.preRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckCOutput_CC: command]) {
    self.deckC.postLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckCOutput_CC: command]) {
    self.deckC.postRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Filter *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FilterAdjustOutDeckCOutput_CC: command]) {
    self.deckC.filterLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Flux mode *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_On: command]) {
    //  - On
    self.deckC.fluxModeIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_Off: command]) {
    //  - Off
    self.deckC.fluxModeIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Loop active *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_On: command]) {
    //  - On
    self.deckC.loopActiveIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_Off: command]) {
    //  - Off
    self.deckC.loopActiveIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // ***** Deck D *****
  
  // * Seek position *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckDOutput_CC: command]) {
    self.deckD.trackProgress = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * FX 1 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_On: command]) {
    //  - On
    self.deckD.fx1IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_Off: command]) {
    //  - Off
    self.deckD.fx1IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 2 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_On: command]) {
    //  - On
    self.deckD.fx2IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_Off: command]) {
    //  - Off
    self.deckD.fx2IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 3 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_On: command]) {
    //  - On
    self.deckD.fx3IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_Off: command]) {
    //  - Off
    self.deckD.fx3IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * FX 4 *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_On: command]) {
    //  - On
    self.deckD.fx4IsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_Off: command]) {
    //  - Off
    self.deckD.fx4IsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Pre-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckDOutput_CC: command]) {
    self.deckD.preLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Pre-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckDOutput_CC: command]) {
    self.deckD.preRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-left levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckDOutput_CC: command]) {
    self.deckD.postLeftLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Post-right levels *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckDOutput_CC: command]) {
    self.deckD.postRightLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Filter *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FilterAdjustOutDeckDOutput_CC: command]) {
    self.deckD.filterLevel = [TraktorProMIDIDictionary normalizedCcValue:command];
  }
  
  // * Flux mode *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_On: command]) {
    //  - On
    self.deckD.fluxModeIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_Off: command]) {
    //  - Off
    self.deckD.fluxModeIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
  
  // * Loop active *
  else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_On: command]) {
    //  - On
    self.deckD.loopActiveIsOn = [TraktorProMIDIDictionary velocityNotZero:command];
  } else if ([TraktorProMIDIDictionary isTraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_Off: command]) {
    //  - Off
    self.deckD.loopActiveIsOn = ![TraktorProMIDIDictionary velocityNotZero:command];
  }
}

#pragma mark - MEMotionSubscriber methods

- (void)motionDidStartWithError:(NSError *)error {
  // Not implemented.
}

- (void)updateWithNormalizedValue:(float)normVal
                    startingValue:(float)startVal
                     subscriberId:(NSInteger)subscriberId {
  //  if (subscriberId == self.steerId) {
  //    float levelVal = (normVal * 2.0) - 1.0; // -1.0 to 1.0
  //    self.motionLevels.steerValue = levelVal;
  //  } else
  if (subscriberId == self.rotateId) {
    self.motionLevels.rotateValue = (normVal * 2.0) - 1.0; // -1.0 to 1.0
  } else if (subscriberId == self.diveRaiseId) {
    float levelVal = ((normVal * 2.0) - 1.0) * 2.0; // -1.0 to 1.0
    if (levelVal < -1.0) {
      levelVal = -1.0;
    } else if (levelVal > 1.0) {
      levelVal = 1.0;
    }
    
    // Update on main queue.
    dispatch_async(dispatch_get_main_queue(), ^{
      self.motionLevels.diveRaiseValue = levelVal; // -1.0 to 1.0;
    });
  }
}

@end
