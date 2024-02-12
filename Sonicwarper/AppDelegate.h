//
//  AppDelegate.h
//  Sonicwarper
//
//  Created by Kevin Ng on 15/12/15.
//  Copyright © 2015 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DataController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DataController *dataController;

@end

