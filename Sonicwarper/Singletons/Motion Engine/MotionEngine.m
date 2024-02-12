//
//  MotionEngine.m
//  Sonicwarper
//
//  Created by Kevin Ng on 15/12/15.
//  Copyright © 2015 Sonicwarper. All rights reserved.
//

@import CoreMotion;
#import "MotionEngine.h"
#import "MotionMapping.h"

@interface MotionEngine()

@property (nonatomic, strong) NSMutableDictionary *mappings;
@property (atomic) NSInteger subscriberIdCounter;

// Motion-related classes.
@property (nonatomic, strong) CMMotionManager *motManager;
@property (nonatomic) CMAttitudeReferenceFrame refFrame;

@end

@implementation MotionEngine

// ***** Error-handling *****

// Error domains for NSError.

static NSString * const SMEErrorDomain = @"SharedMotionEngineSubscriberErrorDomain";

// Error codes for NSError.

typedef enum SMEErrorCode {
  SMEDeviceMotionUnavailable,
  SMEAttitudeReferenceFrameUnavailable,
  SMESynchronizationMaximumTriesExceeded
} SMEErrorCode;

+ (MotionEngine *)shared {
  static MotionEngine *shared = nil;
  
  if (!shared) {
    shared = [[self alloc] initPrivate];
  }
  
  return shared;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use + [MotionEngine shared]"
                               userInfo:nil];
}

- (instancetype)initPrivate {
  self = [super init];
  
  if (self) {
    self.mappings = [NSMutableDictionary new];
    self.subscriberIdCounter = 0; // Start from 0.
    
    // ***** Motion-related classes *****
    self.motManager = [CMMotionManager new];
    self.refFrame = CMAttitudeReferenceFrameXArbitraryCorrectedZVertical;
  }
  
  return self;
}

- (NSInteger)subscribe:(id<MEMotionSubscriber>)subscriber
            motionType:(MEMotionType)motionType {
  MotionMapping *newMapping = [[MotionMapping alloc] initWithSubscriber:subscriber
                                                             motionType:motionType];
  self.mappings[[NSNumber numberWithInteger:self.subscriberIdCounter]] = newMapping;
  NSInteger thisId = self.subscriberIdCounter;
  self.subscriberIdCounter++;
  
  return thisId;
}

- (void)setIsStarted:(BOOL)isStarted {
  
  // Stop motion engine
  if (!isStarted) {
    [self.motManager stopDeviceMotionUpdates];
    return;
  }
  
  // ***** Pre-run checks ****
  
  // Device motion availability
  if (!self.motManager.deviceMotionAvailable) {
    NSError *error = [NSError errorWithDomain:SMEErrorDomain
                                         code:SMEDeviceMotionUnavailable
                                     userInfo:nil];
    // Inform subscribers of the error
    for (NSNumber *key in self.mappings) {
      MotionMapping *mapping = self.mappings[key];
      [mapping.subscriber motionDidStartWithError:error];
    }
    return;
  }
  
  // Reference frame availability
  if (([CMMotionManager availableAttitudeReferenceFrames] & self.refFrame) == 0) {
    NSError *error = [NSError errorWithDomain:SMEErrorDomain
                                         code:SMEAttitudeReferenceFrameUnavailable
                                     userInfo:nil];
    // Inform subscribers of the error
    for (NSNumber *key in self.mappings) {
      MotionMapping *mapping = self.mappings[key];
      [mapping.subscriber motionDidStartWithError:error];
    }
    return;
  }
  
  // Set sample rate to 100Hz (the maximum allowable on iPhone 5).
//  self.motManager.deviceMotionUpdateInterval = 0.01; // 100 times a second.
  self.motManager.deviceMotionUpdateInterval = 0.1; // 10 times a second.
  
  // Starting the device motion manager once here, and later again to the queue. I need
  // this line of code to get the magnetometer readings coming in.
  // (Tested on iPhone 5, iOS 7).
  [self.motManager startDeviceMotionUpdatesUsingReferenceFrame:self.refFrame];

  // Start the motion manager.
  [self.motManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                  withHandler:^(CMDeviceMotion *motion, NSError *error)
  {
    
    for (NSNumber *key in self.mappings) {
      MotionMapping *mapping = self.mappings[key];
      if (!mapping.activated) {
        // Mapping is not activated - skip it.
        continue;
      }
      
      id<MEMotionSubscriber> subscriber = mapping.subscriber;
      
      double normVal;
      double rawMotVal;
      switch (mapping.motionType) {
        case MEMotionTypeDiveRaise:
          rawMotVal = -motion.attitude.roll; // Flip
          normVal = ((rawMotVal / M_PI) + 1.0) / 2.0; // Range 0.f to 1.f
          break;
        case MEMotionTypeRotate:
          rawMotVal = -motion.attitude.pitch; // Flip
          normVal = ((rawMotVal / M_PI) * -1.0) + 0.5; // Range 0.f to 1.f
          break;
        case MEMotionTypeSteer:
          rawMotVal = -motion.attitude.yaw; // Flip
          normVal = ((rawMotVal / M_PI) + 1.0) / 2.0; // Range 0.f to 1.f
          break;
        default:
          break;
      }

      // Set starting value if it has not been set before.
      if (mapping.startValue == -1) {
        mapping.startValue = normVal;
      }
      
      [subscriber updateWithNormalizedValue:normVal
                              startingValue:mapping.startValue
                               subscriberId:[key integerValue]];
    }
  }];
}

- (void)unsubscribe:(NSInteger)subscriberId {
  NSNumber *key = [NSNumber numberWithInteger:subscriberId];
  [self.mappings removeObjectForKey:key];
}

- (void)activate:(Boolean)activate
      subscriber:(NSInteger)subscriberId {
  NSNumber *key = [NSNumber numberWithInteger:subscriberId];
  MotionMapping *mapping = (MotionMapping *)self.mappings[key];
  mapping.activated = activate;
}

- (MotionMapping *)mappingForSubscriberId:(NSInteger)subscriberId {
  NSNumber *key = [NSNumber numberWithInteger:subscriberId];
  MotionMapping *mapping = (MotionMapping *)self.mappings[key];
  return mapping;
}

- (BOOL)isStarted {
  return [self.motManager isDeviceMotionActive];
}

- (void)reset {
  self.isStarted = NO;
  self.motManager = [CMMotionManager new];
  self.isStarted = YES;
}

@end
