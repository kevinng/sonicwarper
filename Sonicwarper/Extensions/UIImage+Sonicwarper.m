//
//  UIImage+Sonicwarper.m
//  Sonicwarper
//
//  Created by Kevin Ng on 13/3/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "UIImage+Sonicwarper.h"

@implementation UIImage (Sonicwarper)

+ (UIImage *)imageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

@end
