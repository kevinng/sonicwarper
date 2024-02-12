//
//  BowswitchView.h
//  Sonicwarper
//
//  Created by Kevin Ng on 11/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ButtonLook;

typedef NS_ENUM(NSInteger, BSBowswitchPosition) {
  BSBowswitchPositionLeftMost,
  BSBowswitchPositionLeftClosestToMiddle,
  BSBowswitchPositionRightClosestToMiddle,
  BSBowswitchPositionRightMost,
  BSBowswitchCount
};

typedef NS_ENUM(NSInteger, BSButtonColor) {
  BSButtonColorEmpty,
  BSButtonColorBlue,
  BSButtonColorPurple,
  BSButtonColorLilac,
  BSButtonColorGreen,
  BSButtonColorRed,
  BSButtonColorYellow,
  BSButtonColorWhite,
  BSButtonColorCount
};

// For left-oriented bowswitch: button sequence is from top to bottom
//  - (i.e. 0 is topmost, 9 is bottomost)
// For right-oriented bowswitch: button sequence is from bottom to top
//  - (i.e. 0 is bottomost, 9 is topmost)
typedef NS_ENUM(NSInteger, BSButtonPosition) {
  BSButtonPosition0,
  BSButtonPosition1,
  BSButtonPosition2,
  BSButtonPosition3,
  BSButtonPosition4,
  BSButtonPosition5,
  BSButtonPosition6,
  BSButtonPosition7,
  BSButtonPosition8,
  BSButtonPosition9,
  BSButtonCount
};

typedef NS_ENUM(NSInteger, BSButtonState) {
  BSButtonStateTouchedIn,
  BSButtonStateTouchedOut,
  BSButtonStateCount
};

@class BowswitchView;

@protocol BowswitchDelegate <NSObject>

@required

- (BOOL)willChangeState:(BSButtonState)state
              forButton:(BSButtonPosition)button // Return YES if allow change
          fromBowswitch:(BSBowswitchPosition)bowswitch;
- (void)didChangedState:(BSButtonState)state
              forButton:(BSButtonPosition)button
          fromBowswitch:(BSBowswitchPosition)bowswitch;

@end

@interface BowswitchView : UIView

@property (nonatomic) BSBowswitchPosition bowswitchPosition;

@property (nonatomic, weak) id<BowswitchDelegate> delegate;
@property (nonatomic) BOOL leftOriented;

- (instancetype)initWithBowswitchPosition:(BSBowswitchPosition)bowswitchPosition;

// Index getters/setters
//  - Color
- (void)setColor:(BSButtonColor)color forButton:(BSButtonPosition)button;
- (BSButtonColor)getColorForButton:(BSButtonPosition)button;
//  - Main label
- (void)setMainLabel:(NSString *)mainLabel forButton:(BSButtonPosition)button;
- (NSString *)getMainLabelForButton:(BSButtonPosition)button;
//  - Small label
- (void)setSmallLabel:(NSString *)smallLabel forButton:(BSButtonPosition)button;
- (NSString *)getSmallLabelForButton:(BSButtonPosition)button;
//  - Look
- (ButtonLook *)getLookForButton:(BSButtonPosition)button;
- (void)setLook:(ButtonLook *)look forButton:(BSButtonPosition)button;

@end
