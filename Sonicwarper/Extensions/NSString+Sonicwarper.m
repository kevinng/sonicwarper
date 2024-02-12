//
//  NSString+Sonicwarper.m
//  Sonicwarper
//
//  Created by Kevin Ng on 13/3/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "NSString+Sonicwarper.h"

@implementation NSString (Sonicwarper)

+ (CGFloat)centerXAttributedString:(NSAttributedString *)string superview:(UIView *)superview {
  CGFloat stringWidth = string.size.width;
  CGFloat superviewWidth = superview.bounds.size.width;
  return (superviewWidth / 2) - (stringWidth / 2);
}

+ (CGFloat)centerYAttributedString:(NSAttributedString *)string superview:(UIView *)superview {
  CGFloat stringHeight = string.size.height;
  CGFloat superviewHeight = superview.bounds.size.height;
  return (superviewHeight / 2) - (stringHeight / 2);
}

@end
