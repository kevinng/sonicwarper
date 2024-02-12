//
//  MotionEngine.h
//  Sonicwarper
//
//  Singleton class that manages the outputs of the iPad’s motion engine.
//
//  Created by Kevin Ng on 15/12/15.
//  Copyright © 2015 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MotionMapping;

#ifndef MOTION_ENGINE

typedef NS_ENUM(NSInteger, MEMotionType) {
  MEMotionTypeRotate,
  MEMotionTypeDiveRaise,
  MEMotionTypeSteer
};

#endif

@protocol MEMotionSubscriber <NSObject>

@required

- (void)motionDidStartWithError:(NSError *)error;
- (void)updateWithNormalizedValue:(float)normVal
                    startingValue:(float)startVal
                     subscriberId:(NSInteger)subscriberId;

@end

@interface MotionEngine : NSObject

@property (nonatomic) BOOL isStarted;

+ (instancetype)shared;

- (NSInteger)subscribe:(id<MEMotionSubscriber>)subscriber
            motionType:(MEMotionType)motionType;
- (void)unsubscribe:(NSInteger)subscriberId;
- (void)activate:(Boolean)activate
      subscriber:(NSInteger)subscriberId;
- (MotionMapping *)mappingForSubscriberId:(NSInteger)subscriberId;
- (void)reset;

@end
