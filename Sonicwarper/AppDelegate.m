//
//  AppDelegate.m
//  Sonicwarper
//
//  Created by Kevin Ng on 15/12/15.
//  Copyright © 2015 Sonicwarper. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "IQKeyboardManager.h"
#import "Mappings.h"

#import "TraktorProMIDIDictionary.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSString *homeDir = NSHomeDirectory();
  NSLog(@"%@",homeDir);
  
  IQKeyboardManager *keyboard = [IQKeyboardManager sharedManager];
  keyboard.enable = YES;

  // Show main view controller.
  ViewController *vc = [ViewController new];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = vc;
  [self.window makeKeyAndVisible];
  
  // Connect to all sources/destinations on all devices.
  MIDIEngine *engine = [MIDIEngine shared];
  [engine connectAll];
  
  self.dataController = [[DataController alloc] initWithCompletionBlock:^{
    // Initialize singleton behaviors and looks classes only after the data controller is
    // initialized.
    vc.behaviors = [ButtonBehaviors shared];
    vc.looks = [ButtonLooks shared];
    
    Mappings *mappings = [Mappings shared];
    [mappings readAndSetSampleMapping]; // Will only happen the first time the app loads.
    
    // Initialize looks after the looks singleton is initialized.
    [vc refreshLooks];
    
    // Refresh behaviors.
    [vc.behaviors refreshBehaviors];
  }];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for
  // certain types of temporary interruptions (such as an incoming phone call or SMS message) or
  // when the user quits the application and it begins the transition to the background state.
  
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame
  // rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store
  // enough application state information to restore your application to its current state in case
  // it is terminated later.
  
  // If your application supports background execution, this method is called instead of
  // applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo
  // many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive.
  // If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
