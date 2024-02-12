//
//  UIColor+Sonicwarper.m
//  Sonicwarper
//
//  Created by Kevin Ng on 27/1/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "UIColor+Sonicwarper.h"

@implementation UIColor (Sonicwarper)

#define ColorImplement(COLOR_NAME,HEX) \
+ (UIColor *)COLOR_NAME { \
\
static UIColor* COLOR_NAME##_color; \
static dispatch_once_t COLOR_NAME##_onceToken; \
dispatch_once(&COLOR_NAME##_onceToken, ^{ \
COLOR_NAME##_color = [UIColor colorFromHex:HEX]; \
}); \
\
return COLOR_NAME##_color; \
}

// ***** Colors *****

// Empty
ColorImplement(SWEmpty, 0x5B5B5B)
ColorImplement(SWEmptyLight, 0x727272)

// Green
ColorImplement(SWGreenLight, 0x88C057)
ColorImplement(SWGreen, 0x1F7F5C)
ColorImplement(SWGreenDark, 0x19664A)
ColorImplement(SWGreenDark2, 0x546979)

// Red
ColorImplement(SWRed, 0xE56C69)
ColorImplement(SWRedDark, 0xB75654)
ColorImplement(SWRedDark2, 0x604443)

// Yellow
ColorImplement(SWYellow, 0xDBA571)
ColorImplement(SWYellowDark, 0xAF845A)

// Blue
ColorImplement(SWBlue, 0x5A9AA8)
ColorImplement(SWBlueDark, 0x487B86)

// Purple
ColorImplement(SWPurple, 0x6A5A8C)
ColorImplement(SWPurpleDark, 0x554870)
ColorImplement(SWPurpleDark2, 0x534B66)

// Lilac
ColorImplement(SWLilac, 0x704A61)
ColorImplement(SWLilacDark, 0x8C5D79)

// White (for button)
ColorImplement(SWWhite, 0xE9F2F4)
ColorImplement(SWWhiteDark, 0xCCE0E4)

// ***** Grays *****

ColorImplement(SWWhite100, 0xFFFFFF) // 100% white
ColorImplement(SWWhite12, 0x3D3D3D) // 12% white
ColorImplement(SWWhite26, 0x5B5B5B) // 26% white
ColorImplement(SWWhite54, 0x9A9A9A) // 54% white
ColorImplement(SWWhite87, 0xE2E2E2) // 87% white

ColorImplement(SWBlack, 0x232323) // Black replacement

+ (UIColor *)colorFromHex:(UInt32)hex {
  
  static const CGFloat ColorDenominator = 255.0;
  
  UIColor *color =
  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/ColorDenominator
                  green:((float)((hex & 0x00FF00) >>  8))/ColorDenominator
                   blue:((float)((hex & 0x0000FF) >>  0))/ColorDenominator
                  alpha:1.0];

  return color;
}

+ (UIColor *)colorFromHexString:(NSString*)hexString {
  
  unsigned int hex = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  
  if ([[hexString substringToIndex:1] isEqualToString:@"#"]) {
    [scanner setScanLocation:1]; // bypass '#' character
  }
  
  [scanner scanHexInt:&hex];
  
  return [UIColor colorFromHex:hex];
}

+ (NSArray *)Colors {
  return @[[UIColor SWEmpty],
           [UIColor SWBlue],
           [UIColor SWPurple],
           [UIColor SWLilac],
           [UIColor SWGreen],
           [UIColor SWRed],
           [UIColor SWYellow],
           [UIColor SWWhite]];
}

+ (NSArray *)ColorNames {
  return @[@"Blank",
           @"Blue",
           @"Purple",
           @"Lilac",
           @"Green",
           @"Red",
           @"Yellow",
           @"White"];
}

@end
