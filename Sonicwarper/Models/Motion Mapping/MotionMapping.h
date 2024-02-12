//
//  MotionMapping.h
//  Sonicwarper
//
//  Created by Kevin Ng on 7/4/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MotionEngine.h"

@interface MotionMapping : NSObject

@property (nonatomic, strong) id<MEMotionSubscriber> subscriber;
@property (nonatomic) MEMotionType motionType;
@property (nonatomic) float startValue;
@property (nonatomic) BOOL activated;

// Designated initializer
- (instancetype)initWithSubscriber:(id<MEMotionSubscriber>)subscriber
                        motionType:(MEMotionType)motionType;

@end
