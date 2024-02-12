//
//  ViewController.h
//  Sonicwarper
//
//  Created by Kevin Ng on 15/12/15.
//  Copyright © 2015 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BowswitchView.h"
#import "MIDIEngine.h"
#import "MotionEngine.h"
#import "ButtonBehaviors.h"
#import "ButtonLooks.h"

@interface ViewController : UIViewController <BowswitchDelegate, MIEMIDISubscriber, MEMotionSubscriber>

@property (nonatomic, strong) ButtonBehaviors *behaviors;
@property (nonatomic, strong) ButtonLooks *looks;

- (void)showEditMode:(BOOL)show;
- (void)refreshLooks;

@end

