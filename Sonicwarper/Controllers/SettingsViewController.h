//
//  SettingsViewController.h
//  Sonicwarper
//
//  Created by Kevin Ng on 30/10/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SettingsViewController : UITableViewController

@property (nonatomic, weak) ViewController *parentVC;

@property (nonatomic) BOOL editModeIsOn;

@end
