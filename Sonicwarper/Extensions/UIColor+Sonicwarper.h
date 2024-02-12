//  UIColor with Sonicwarper color palette colors class method added via category.
//
//  UIColor+Sonicwarper.h
//  Sonicwarper
//
//  Created by Kevin Ng on 27/1/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Sonicwarper)

// ***** Colors *****

// Empty
+ (UIColor *)SWEmpty;
+ (UIColor *)SWEmptyLight;

// Green
+ (UIColor *)SWGreenLight;
+ (UIColor *)SWGreen;
+ (UIColor *)SWGreenDark;
+ (UIColor *)SWGreenDark2;

// Red
+ (UIColor *)SWRed;
+ (UIColor *)SWRedDark;
+ (UIColor *)SWRedDark2;

// Yellow
+ (UIColor *)SWYellow;
+ (UIColor *)SWYellowDark;

// Blue
+ (UIColor *)SWBlue;
+ (UIColor *)SWBlueDark;

// Purple
+ (UIColor *)SWPurple;
+ (UIColor *)SWPurpleDark;
+ (UIColor *)SWPurpleDark2;

// Lilac
+ (UIColor *)SWLilac;
+ (UIColor *)SWLilacDark;

// White
+ (UIColor *)SWWhite;
+ (UIColor *)SWWhiteDark;

// ***** Grays *****

+ (UIColor *)SWWhite100; // 100% white
+ (UIColor *)SWWhite87; // 87% white
+ (UIColor *)SWWhite54; // 54% white
+ (UIColor *)SWWhite26; // 26% white
+ (UIColor *)SWWhite12; // 12% white
+ (UIColor *)SWBlack; // Black replacement

// ***** Color list *****

+ (NSArray *)Colors;
+ (NSArray *)ColorNames;

@end
