//
//  ButtonLook.m
//  Sonicwarper
//
//  Created by Kevin Ng on 15/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "ButtonLook.h"

@implementation ButtonLook

- (instancetype)init {
  self = [super init];
  if (self) {
    // Set defaults
    _color = BSButtonColorEmpty;
    _mainLabel = @"";
    _smallLabel = @"";
  }
  return self;
}

- (instancetype)initWithColor:(BSButtonColor)color
                    mainLabel:(NSString *)mainLabel
                   smallLabel:(NSString *)smallLabel {
  self = [super init];
  if (self) {
    _color = color;
    _mainLabel = mainLabel;
    _smallLabel = smallLabel;
  }
  return self;
}

- (void)setColor:(BSButtonColor)color {
  // Reset main/small labels if the empty color is selected.
  if (color == BSButtonColorEmpty) {
    self.mainLabel = @"";
    self.smallLabel = @"";
  }
  
  _color = color;
}

@end
