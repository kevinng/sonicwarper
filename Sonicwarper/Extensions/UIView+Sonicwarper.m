//
//  UIView+Sonicwarper.m
//  Sonicwarper
//
//  Created by Kevin Ng on 13/3/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "UIView+Sonicwarper.h"

@implementation UIView (Sonicwarper)

+ (CGFloat)centerXSubview:(UIView *)subview superview:(UIView *)superview {
  CGFloat subviewWidth = subview.bounds.size.width;
  CGFloat superviewWidth = superview.bounds.size.width;
  return (superviewWidth / 2) - (subviewWidth / 2);
}

@end
