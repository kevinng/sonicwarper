//
//  ButtonLooks.h
//  Sonicwarper
//
//  Created by Kevin Ng on 28/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ButtonLook.h"

@interface ButtonLooks : NSObject

+ (ButtonLooks *)shared;
- (ButtonLook *)lookForBowswitch:(BSBowswitchPosition)bowswitch
                          button:(BSButtonPosition)button;

@end
