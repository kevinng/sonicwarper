//
//  Settings.h
//  Sonicwarper
//
//  This is a singleton class that provides the global settings for the app. Persistent data
//  is provided by NSUserDefaults. On initialization, the Settings singleton object attempts to
//  read from the NSUserDefaults class for the data it needs. If the data is not found, then the
//  initial data is inserted into the NSUserDefaults class and used.
//
//  Created by Kevin Ng on 18/5/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (Settings *)shared;

@property (nonatomic) BOOL editModeIsOn;

@end
