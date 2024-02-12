//
//  BehaviorViewController.h
//  Sonicwarper
//
//  Created by Kevin Ng on 15/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticDataTableViewController.h"
#import "ButtonBehavior.h"

@protocol BehaviorUpdater <NSObject>

- (void)setBehavior:(ButtonBehavior *)behavior;

@end

@interface BehaviorViewController : StaticDataTableViewController <BehaviorUpdater>

@property (nonatomic) BOOL createMode;

@end
