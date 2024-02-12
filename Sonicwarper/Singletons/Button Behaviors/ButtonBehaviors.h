//
//  ButtonBehaviors.h
//  Sonicwarper
//
//  Created by Kevin Ng on 5/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BowswitchView.h"
#import "ButtonBehavior.h"

@interface ButtonBehaviors : NSObject

+ (ButtonBehaviors *)shared;

- (void)behaveButton:(BSButtonPosition)button
           bowswitch:(BSBowswitchPosition)bowswitch
               state:(BSButtonState)state;
- (NSMutableArray *)behaviorsForButton:(BSButtonPosition)button
                             bowswitch:(BSBowswitchPosition)bowswitch;
- (void)addBehavior:(ButtonBehavior *)behavior
             button:(BSButtonPosition)button
          bowswitch:(BSBowswitchPosition)bowswitch;
- (void)removeBehavior:(ButtonBehavior *)behavior
                button:(BSButtonPosition)button
             bowswitch:(BSBowswitchPosition)bowswitch;

- (void)refreshBehaviors;

@end
