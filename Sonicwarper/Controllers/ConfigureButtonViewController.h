//
//  ConfigureButtonViewController.h
//  Sonicwarper
//
//  Created by Kevin Ng on 30/10/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BowswitchView.h"

@protocol LookUpdater <NSObject>

- (void)setLook:(ButtonLook *)look;

@end


@interface ConfigureButtonViewController : UITableViewController

@property (nonatomic) BSBowswitchPosition bowswitch;
@property (nonatomic) BSButtonPosition button;

@end
