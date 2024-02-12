//
//  NSString+Sonicwarper.h
//  Sonicwarper
//
//  Created by Kevin Ng on 13/3/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Sonicwarper)

+ (CGFloat)centerXAttributedString:(NSAttributedString *)string superview:(UIView *)superview;
+ (CGFloat)centerYAttributedString:(NSAttributedString *)string superview:(UIView *)superview;

@end
