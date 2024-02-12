//
//  EditModeView.m
//  Sonicwarper
//
//  Created by Kevin Ng on 19/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "EditModeView.h"
#import "Fonts+Sonicwarper.h"
#import "UIColor+Sonicwarper.h"

@interface EditModeView()

@property (nonatomic, strong) NSAttributedString *editModeStr;

@end

@implementation EditModeView

#pragma mark Constants

static const CGFloat OVAL_DIAMETER = 10;
static const CGFloat SPACE_BTW_OVAL_N_LABEL = 4;

#pragma mark Initializers

- (instancetype)init {
  
  // Common text attributes
  NSMutableParagraphStyle *centerPgStyle = [[NSMutableParagraphStyle alloc] init];
  [centerPgStyle setAlignment:NSTextAlignmentCenter];
  
  // Edit mode string
  NSDictionary *editModeAttr = @{
                                 NSFontAttributeName:[UIFont fontWithName:[Fonts Bold]
                                                                     size:[Fonts SmallSize]],
                                 NSForegroundColorAttributeName:[UIColor SWRed],
                                 NSParagraphStyleAttributeName:centerPgStyle};
  NSAttributedString *editModeStr = [[NSAttributedString alloc]
                                     initWithString:@"EDIT MODE"
                                     attributes:editModeAttr];
  
  CGFloat width = OVAL_DIAMETER + SPACE_BTW_OVAL_N_LABEL + editModeStr.size.width;
  CGFloat height = OVAL_DIAMETER;
  
  self = [super initWithFrame:CGRectMake(0, 0, width, height)];
  
  if (self) {
    self.editModeStr = editModeStr;
    
    self.opaque = NO; // Remove default black background
  }
  
  return self;
}

- (void)drawRect:(CGRect)rect {
  UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0,
                                                                         OVAL_DIAMETER,
                                                                         OVAL_DIAMETER)];
  [[UIColor SWRed] setFill];
  [oval fill];
  
  CGFloat editModeStrXPos = OVAL_DIAMETER + SPACE_BTW_OVAL_N_LABEL;
  CGFloat editModeStrYPos = (self.frame.size.height/2) - (self.editModeStr.size.height/2);
  [self.editModeStr drawAtPoint:CGPointMake(editModeStrXPos, editModeStrYPos)];
}


@end
