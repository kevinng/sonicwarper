//
//  Settings.m
//  Sonicwarper
//
//  Created by Kevin Ng on 18/5/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "Settings.h"

@implementation Settings

@synthesize editModeIsOn = _editModeIsOn;

static NSString * const EDIT_MODE_KEY = @"SharedSettings_EditModeIsOn";

+ (Settings *)shared {
  static Settings *shared = nil;
  
  if (!shared) {
    shared = [[Settings alloc] initPrivate];
  }
  
  return shared;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use + [Settings shared]"
                               userInfo:nil];
}

- (instancetype)initPrivate {
  return self;
}

#pragma mark - Getters/Setters

- (BOOL)editModeIsOn {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  _editModeIsOn = [defaults boolForKey:EDIT_MODE_KEY]; // NO is doesn't exist.
  return _editModeIsOn;
}

- (void)setEditModeIsOn:(BOOL)editModeIsOn {
  _editModeIsOn = editModeIsOn;
  // Save value in NSUserDefaults
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setBool:editModeIsOn forKey:EDIT_MODE_KEY];
  [defaults synchronize];
}

@end
