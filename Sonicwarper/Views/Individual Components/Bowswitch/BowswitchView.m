//
//  BowswitchView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 11/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "BowswitchView.h"
#import "UIColor+Sonicwarper.h"
#import "Fonts+Sonicwarper.h"
#import "ButtonLook.h"

@interface BowswitchView()

@property (nonatomic, strong) NSArray<UIBezierPath *> *buttons;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *colors;
@property (nonatomic, strong) NSMutableArray<NSString *> *mainLabels;
@property (nonatomic, strong) NSMutableArray<NSString *> *smallLabels;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *states;

// Property targetActions is a mutable dictionary of mutable dictionaries. The key in targetActions
// is a Number of BSButtonPosition, and the value a mutable dictionary with 2 keys - for the 2
// BSButtonState: touched in and touched out. Each value of the mutable dictionary is a mutable
// array of selectors which will be called in the order they're added when the button state is
// set.
//@property (nonatomic, strong)
//  NSMutableDictionary<NSNumber *,
//    NSMutableDictionary<NSNumber *, NSMutableArray *> *> *targetActions;

@end

@implementation BowswitchView

// Dimensions
//  - Bowswitch
static const float OUT_CIRCLE_RADIUS = 452.6; // 905.5/2
static const float IN_CIRCLE_RADIUS = 369.58; // 739.16/2
static const float ARC_CENTER_X_POS = 0;
static const float ARC_CENTER_Y_POS = OUT_CIRCLE_RADIUS;
static const float BUTTON_SPACING = 5.4;
static const float NUM_BUTTONS_IN_QUAD_CIRCLE = 8;
static const float NUM_BUTTONS_IN_FULL_CIRCLE = NUM_BUTTONS_IN_QUAD_CIRCLE * 4;
//  - Frame/bounds
static const float EDGE_BUFFER = 2; // Some buffer for the edge; else the circle will be cropped
static const float WIDTH = OUT_CIRCLE_RADIUS + EDGE_BUFFER;
static const float HEIGHT = OUT_CIRCLE_RADIUS * 2;
//  - Typography
static const CGFloat SPACE_BTW_MAIN_LBL_N_BASE = 44; // Main label position from button bottom
static const CGFloat SPACE_BTW_SMALL_LBL_N_BASE = 7.6; // Small label position from button bottom

#pragma mark - Initializers

- (instancetype)initWithBowswitchPosition:(BSBowswitchPosition)bowswitchPosition {
  // Frame position at (0, 0); Will be positioned with programmatically constraints later
  self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
  if (self) {
    self.bowswitchPosition = bowswitchPosition;
    
    // Default values
    self.colors = [NSMutableArray
                   arrayWithArray:@[[NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty],
                                    [NSNumber numberWithInteger:BSButtonColorEmpty]]];
    
    self.mainLabels = [NSMutableArray
                       arrayWithArray:@[@"",
                                        @"",
                                        @"",
                                        @"",
                                        @"",
                                        @"",
                                        @"",
                                        @"",
                                        @"",
                                        @""]]; // ABCEDEF
    
    self.smallLabels = [NSMutableArray
                        arrayWithArray:@[@"",
                                         @"",
                                         @"",
                                         @"",
                                         @"",
                                         @"",
                                         @"",
                                         @"",
                                         @"",
                                         @""]]; // ABCDEFGH
    
    self.states = [NSMutableArray
                   arrayWithArray:@[[NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut],
                                    [NSNumber numberWithInteger:BSButtonStateTouchedOut]]];
    
    self.leftOriented = YES;
    
    self.opaque = NO; // Remove default black background
  }
  
  return self;
}

#pragma mark - Overrides

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  // Return true only if the point is in one of the buttons
  for (UIBezierPath *button in self.buttons) {
    if ([button containsPoint:point]) {
      return YES;
    }
  }
  return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self setState:BSButtonStateTouchedIn forButtonsWithTouches:touches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self setState:BSButtonStateTouchedOut forButtonsWithTouches:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self setState:BSButtonStateTouchedOut forButtonsWithTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    NSUInteger button = 0; // Button index according to BSButtonPosition implementation
    for (UIBezierPath *buttonPath in self.buttons) {
      if ([buttonPath containsPoint:[touch locationInView:self]] &&
          ![buttonPath containsPoint:[touch previousLocationInView:self]]) {
        // The touch moved into this button
        [self setState:BSButtonStateTouchedIn forButton:button];
      } else if (![buttonPath containsPoint:[touch locationInView:self]] &&
                 [buttonPath containsPoint:[touch previousLocationInView:self]]) {
        // The touch moved out of this button
        [self setState:BSButtonStateTouchedOut forButton:button];
      }
      // Do nothing if the touch stayed outside or inside the button
      button++;
    }
  }
}

#pragma mark - State setting (event handling)

- (void)setState:(BSButtonState)state forButtonsWithTouches:(NSSet<UITouch *> *)touches {
  // Emit an event if a button is touched
  for (UITouch *touch in touches) {
    NSUInteger button = 0; // Button index according to BSButtonPosition implementation
    for (UIBezierPath *buttonPath in self.buttons) {
      if ([buttonPath containsPoint:[touch locationInView:self]]) {
        [self setState:state forButton:button];
      }
      button++;
    }
  }
}

- (void)setState:(BSButtonState)state forButton:(BSButtonPosition)button {
  // Allow the setting of state if the delegate is okay with it
  if ([self.delegate willChangeState:state forButton:button fromBowswitch:self.bowswitchPosition]) {
    self.states[button] = [NSNumber numberWithInteger:state];
    // Notify the delegate
    [self.delegate didChangedState:state forButton:button fromBowswitch:self.bowswitchPosition];
    [self setNeedsDisplay];
  }
}

#pragma mark - Property getters/setters

//  - Color
- (void)setColor:(BSButtonColor)color forButton:(BSButtonPosition)button {
  self.colors[button] = [NSNumber numberWithInteger:color];
  [self setNeedsDisplay];
}

- (BSButtonColor)getColorForButton:(BSButtonPosition)button {
  return (BSButtonColor)[self.colors[button] integerValue];
}

//  - Main label
- (void)setMainLabel:(NSString *)mainLabel forButton:(BSButtonPosition)button {
  self.mainLabels[button] = mainLabel;
  [self setNeedsDisplay];
}

- (NSString *)getMainLabelForButton:(BSButtonPosition)button {
  return self.mainLabels[button];
}

//  - Small label
- (void)setSmallLabel:(NSString *)smallLabel forButton:(BSButtonPosition)button {
  self.smallLabels[button] = smallLabel;
  [self setNeedsDisplay];
}

- (NSString *)getSmallLabelForButton:(BSButtonPosition)button {
  return self.smallLabels[button];
}

//  - Button Look
- (ButtonLook *)getLookForButton:(BSButtonPosition)button {
  ButtonLook *look = [[ButtonLook alloc] initWithColor:[self.colors[button] integerValue]
                                             mainLabel:self.mainLabels[button]
                                            smallLabel:self.smallLabels[button]];
  return look;
}

- (void)setLook:(ButtonLook *)look forButton:(BSButtonPosition)button {
  self.colors[button] = [NSNumber numberWithInteger:look.color];
  self.mainLabels[button] = look.mainLabel;
  self.smallLabels[button] = look.smallLabel;
  [self setNeedsDisplay];
}

// - Left oriented
- (void)setLeftOriented:(BOOL)leftOriented {
  _leftOriented = leftOriented;
  [self setNeedsDisplay];
}

#pragma mark - Drawing methods

- (void)drawRect:(CGRect)rect {
  // References to button UI bezier paths are used for hit detection.
  NSMutableArray *buttons = [NSMutableArray new];
  for (NSUInteger i = 0; i < 10; i++) {
    [buttons addObject:[self drawButton:i]];
  }
  self.buttons = buttons;
}

- (UIBezierPath *)drawButton:(BSButtonPosition)buttonPos {
  // The number of spaces we need equals to the number of buttons we want
  CGFloat numSpaces = NUM_BUTTONS_IN_FULL_CIRCLE;
  
  // Total space length (same for both inner and outer arc circumferences)
  CGFloat totalSpaces = numSpaces * BUTTON_SPACING;
  
  // Circumferences
  CGFloat outCir = 2 * M_PI * OUT_CIRCLE_RADIUS;
  
  // Total button length on the circumference of the outer arc
  CGFloat outTtlButton = outCir - totalSpaces;
  
  // Length of each button on the circumferences
  CGFloat outButtonLength = outTtlButton / NUM_BUTTONS_IN_FULL_CIRCLE;
  
  // The visible buttons are numbered, top to bottom, 1 to 10
  // The invisible buttons are numbered, from the last visible button onwards, going in full
  // circle until 1 position before the first visible button, 11 to NUM_BUTTONS_IN_FULL_CIRCLE.
  
  // For left oriented:
  // Button 1 is 27th button beginning from angle 0 moving downwards in a circular order. Including
  // the 1/2 button space (a full button space is split along the X-axis), there are 27 and a 1/2
  // spacings from angle 0 to button 1. We use 27 as the starting index, and increment from there
  // where the bowswitch is left-oriented.
  CGFloat baseButtonIdx = 27;
  
  // For right oriented:
  // Follows the same logic as left oriented drawing. Button 1 is the 11th button from angle 0
  // moving downwards in a circular order.
  if (!self.leftOriented) {
    baseButtonIdx = 11;
  }
  
  CGFloat buttonIdx = baseButtonIdx + buttonPos;
  
  // + Outer arc +
  
  // Distance on the circumference to move from 0 to the top/bottom of the outer arc
  // Note: we are moving in a (large) circle downwards before going up.
  CGFloat totalButtonSpace = ((buttonIdx + 0.5) * BUTTON_SPACING);
  CGFloat cirOutTop = totalButtonSpace + (buttonIdx * outButtonLength);
  CGFloat cirOutMid = totalButtonSpace + ((buttonIdx + 0.5) * outButtonLength);
  CGFloat cirOutBot = totalButtonSpace + ((buttonIdx + 1) * outButtonLength);
  // Angle distance needed to move to move the distance calculation.
  //
  //  Full rotation = 2*PI rads = 360 degs
  //  Full circumference = 2*PI*radius
  //  Angle to move = a
  //  Distance to move on circumference = d
  //  So,
  //    a / full rotation = d / circumference
  //    a / 2*PI = d / 2*PI*radius
  //    a = d/radius
  CGFloat angleTop = cirOutTop / OUT_CIRCLE_RADIUS; // Same for inner arc
  CGFloat angleMid = cirOutMid / OUT_CIRCLE_RADIUS; // Same for inner arc
  CGFloat angleBot = cirOutBot / OUT_CIRCLE_RADIUS; // Same for inner arc
  
  // Draw outer arc.
  CGFloat arcCenterXPos = ARC_CENTER_X_POS;
  if (!self.leftOriented) {
    arcCenterXPos += WIDTH; // Move arc center to the other side of the view
  }
  
  UIBezierPath *button = [UIBezierPath bezierPath];
  [button addArcWithCenter:CGPointMake(arcCenterXPos,
                                       ARC_CENTER_Y_POS)
                    radius:OUT_CIRCLE_RADIUS
                startAngle:angleTop
                  endAngle:angleBot
                 clockwise:YES];
  [button addArcWithCenter:CGPointMake(arcCenterXPos,
                                       ARC_CENTER_Y_POS)
                    radius:IN_CIRCLE_RADIUS
                startAngle:angleBot
                  endAngle:angleTop
                 clockwise:NO];
  [button closePath];
  
  BSButtonState event = [self.states[buttonPos] integerValue];
  BSButtonColor color = [self.colors[buttonPos] integerValue];
  
  UIColor *buttonCol = event == BSButtonStateTouchedOut ?
    [BowswitchView lightColors][color] : [BowswitchView darkColors][color];
  [buttonCol setFill];
  [button fill];
  
  
  // Common text attributes
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  
  // + Common label color +
  
  UIColor *lblColor = color == BSButtonColorWhite ? [UIColor SWBlack] : [UIColor SWWhite87];
  
  // + Main label +
  
  // Radius ending to the point where to place the main label. (The inner circle radius is the
  // bottom of the button.)
  CGFloat btMainLblRad = IN_CIRCLE_RADIUS + SPACE_BTW_MAIN_LBL_N_BASE;
  
  NSDictionary *mainLblAttr = \
    @{NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                          size:[Fonts LargeSize]],
    NSForegroundColorAttributeName:lblColor,
    NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *mainLblAttrStr = [[NSAttributedString alloc]
                                        initWithString:self.mainLabels[buttonPos]
                                        attributes:mainLblAttr];
  
  // Position based on angles.
  // Note: in the calculations, we add the X/Y positions of the arc center to offset the positions
  // because the formulas assume the calculations from the origin.
  //
  // Formulas:
  // x = radius * cos(angle)
  // y = radius * sin(angle)
  CGFloat mainLblMidPtXPos = (btMainLblRad * cos(angleMid)) + arcCenterXPos;
  CGFloat mainLblMidPtYPos = (btMainLblRad * sin(angleMid)) + ARC_CENTER_Y_POS;
  // Position to center the label on the button. We will be drawing the label at this point; and
  // rotating the label around this point.
  CGFloat mainLblHalfXPos = mainLblAttrStr.size.width / 2;
  CGFloat mainLblHalfYPos = mainLblAttrStr.size.height / 2;
  CGFloat mainLblCtrXPos = mainLblMidPtXPos - mainLblHalfXPos;
  CGFloat mainLblCtrYPos = mainLblMidPtYPos - mainLblHalfYPos;
  
  // Make the text spin another right angle so it looks right.
  CGFloat angTextRot = angleMid + M_PI_2;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGAffineTransform identity = CGAffineTransformIdentity;
  
  // Translate the main label center to (0, 0) before rotating it
  // Note: "mid" not "center"
  CGAffineTransform translate = CGAffineTransformTranslate(identity,
                                                           -mainLblMidPtXPos,
                                                           -mainLblMidPtYPos);
  
  CGAffineTransform rotate = CGAffineTransformRotate(identity, angTextRot);
  
  // Translate back
  CGAffineTransform translateBack = CGAffineTransformTranslate(identity,
                                                               mainLblMidPtXPos,
                                                               mainLblMidPtYPos);
  
  CGAffineTransform transRot = CGAffineTransformConcat(translate, rotate);
  CGAffineTransform rotBack = CGAffineTransformConcat(transRot, translateBack);
  
  CGContextConcatCTM(context, rotBack);
  
  [mainLblAttrStr drawAtPoint:CGPointMake(mainLblCtrXPos, mainLblCtrYPos)];
  
  UIGraphicsEndImageContext();
  CGContextRestoreGState(context);
  
  
  
  // + Small label +
  
  // Radius ending to the point where to place the small label. (The inner circle radius is the
  // bottom of the button.)
  CGFloat btSmallLblRad = IN_CIRCLE_RADIUS + SPACE_BTW_SMALL_LBL_N_BASE;
  
  NSDictionary *smallLblAttr = \
    @{NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                          size:[Fonts SmallSize]],
      NSForegroundColorAttributeName:lblColor,
      NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *smallLblAttrStr = [[NSAttributedString alloc]
                                         initWithString:self.smallLabels[buttonPos]
                                         attributes:smallLblAttr];
  
  // Position based on angles.
  // Note: in the calculations, we add the X/Y positions of the arc center to offset the positions
  // because the formulas assume the calculations from the origin.
  //
  // Formulas:
  // x = radius * cos(angle)
  // y = radius * sin(angle)
  CGFloat smallLblMidPtXPos = (btSmallLblRad * cos(angleMid)) + arcCenterXPos;
  CGFloat smallLblMidPtYPos = (btSmallLblRad * sin(angleMid)) + ARC_CENTER_Y_POS;
  // Position to center the label on the button. We will be drawing the label at this point; and
  // rotating the label around this point.
  CGFloat smallLblHalfXPos = smallLblAttrStr.size.width / 2;
  CGFloat smallLblHalfYPos = smallLblAttrStr.size.height / 2;
  CGFloat smallLblCtrXPos = smallLblMidPtXPos - smallLblHalfXPos;
  CGFloat smallLblCtrYPos = smallLblMidPtYPos - smallLblHalfYPos;
  
  context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  identity = CGAffineTransformIdentity;
  
  // Translate the small label center to (0, 0) before rotating it
  // Note: "mid" not "center"
  translate = CGAffineTransformTranslate(identity,
                                         -smallLblMidPtXPos,
                                         -smallLblMidPtYPos);
  
  rotate = CGAffineTransformRotate(identity, angTextRot);
  
  // Translate back
  translateBack = CGAffineTransformTranslate(identity,
                                             smallLblMidPtXPos,
                                             smallLblMidPtYPos);
  
  transRot = CGAffineTransformConcat(translate, rotate);
  rotBack = CGAffineTransformConcat(transRot, translateBack);
  
  CGContextConcatCTM(context, rotBack);
  
  [smallLblAttrStr drawAtPoint:CGPointMake(smallLblCtrXPos, smallLblCtrYPos)];
  
  UIGraphicsEndImageContext();
  CGContextRestoreGState(context);
  
  return button;
}

+ (NSArray *)lightColors {
  static NSArray *_lightColors;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _lightColors = @[[UIColor SWEmpty],
                     [UIColor SWBlue],
                     [UIColor SWPurple],
                     [UIColor SWLilac],
                     [UIColor SWGreen],
                     [UIColor SWRed],
                     [UIColor SWYellow],
                     [UIColor SWWhite]];
  });
  return _lightColors;
}

+ (NSArray *)darkColors {
  static NSArray *_darkColors;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _darkColors = @[[UIColor SWEmptyLight],
                    [UIColor SWBlueDark],
                    [UIColor SWPurpleDark],
                    [UIColor SWLilacDark],
                    [UIColor SWGreenDark],
                    [UIColor SWRedDark],
                    [UIColor SWYellowDark],
                    [UIColor SWWhiteDark]];
  });
  return _darkColors;
}

@end
