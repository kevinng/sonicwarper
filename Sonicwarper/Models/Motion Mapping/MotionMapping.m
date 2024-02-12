//
//  MotionMapping.m
//  Sonicwarper
//
//  Created by Kevin Ng on 7/4/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "MotionMapping.h"

@implementation MotionMapping

- (instancetype)initWithSubscriber:(id<MEMotionSubscriber>)subscriber
                        motionType:(MEMotionType)motionType {
  self = [super init];
  if (self) {
    self.subscriber = subscriber;
    self.motionType = motionType;
    self.activated = NO;
    
    self.startValue = -1;
  }
  return self;
}

- (void)setActivated:(BOOL)activated {
  // Reset start value on deactivation.
  if (!activated) {
    self.startValue = -1;
  }
  
  _activated = activated;
}

@end
