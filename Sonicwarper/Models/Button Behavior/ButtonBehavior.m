//
//  ButtonBehavior.m
//  Sonicwarper
//
//  Created by Kevin Ng on 5/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

@import CoreData;
#import "ButtonBehavior.h"
#import "MIKMIDI.h"
#import "MIDIEngine.h"
#import "MotionEngine.h"
#import "DataController.h"
#import "AppDelegate.h"
#import "ButtonBehaviors.h"
#import "Mappings.h"

@interface ButtonBehavior()

@property (nonatomic, strong) MIKMIDIConnectionManager *connectionManager;
@property (nonatomic, strong) MIKMIDIDeviceManager *deviceManager;
@property (nonatomic) NSInteger lastCCValue;
@property (nonatomic) NSInteger motionContinueCCValue;

@end

@implementation ButtonBehavior

- (instancetype)init {
  self = [super init];
  if (self) {
    // Set default values.
    _bowswitch = BSBowswitchPositionLeftMost;
    _button = BSButtonPosition0;
    _type = BBTypeMIDIHoldToActivate;
    _behaviorDescription = @"";
    _midiType = BBMIDITypeNote;
    _midiNote = 0;
    _midiChannel = 0;
    _midiVelocity = 127;
    _midiCCControllerNo = 0;
    _midiCCValue = 0;
    _midiToggled = NO;
    _midiNoteIsOn = YES;
    _continueFromLastCC = NO;
    _motionType = MEMotionTypeDiveRaise;
    _motionReverse = NO;
    _motionStartCCValue = 0;
    
    // Start from false.
    _midiToggled = NO;
    _motionToggled = NO;
    
    _lastCCValue = -1;
    _subscriberId = -1;
    
    // Assign a new created timestamp.
    NSDate *now = [NSDate new];
    _createdTimestamp = [NSString stringWithFormat:@"%F", [now timeIntervalSince1970]];
    
    [self initSingletons];
  }
  return self;
}

- (instancetype)initWithManagedObject:(NSManagedObject *)behObj {
  self = [super init];
  if (self) {
    _createdTimestamp = [behObj valueForKey:@"createdTimestamp"];
    _bowswitch = (BSBowswitchPosition)[[behObj valueForKey:@"bowswitch"] integerValue];
    _button = (BSButtonPosition)[[behObj valueForKey:@"button"] integerValue];
    _type = (BBType)[[behObj valueForKey:@"type"] integerValue];
    _behaviorDescription = [behObj valueForKey:@"behaviorDescription"];
    _midiType = (BBMIDIType)[[behObj valueForKey:@"midiType"] integerValue];
    _midiNote = [[behObj valueForKey:@"midiNote"] integerValue];
    _midiChannel = [[behObj valueForKey:@"midiChannel"] integerValue];
    _midiVelocity = [[behObj valueForKey:@"midiVelocity"] integerValue];
    _midiCCControllerNo = [[behObj valueForKey:@"midiCCControllerNo"] integerValue];
    _midiCCValue = [[behObj valueForKey:@"midiCCValue"] integerValue];
    _midiNoteIsOn = [[behObj valueForKey:@"midiNoteIsOn"] boolValue];
    _continueFromLastCC = [[behObj valueForKey:@"continueFromLastCC"] boolValue];
    _motionType = (MEMotionType)[[behObj valueForKey:@"motionType"] integerValue];
    _motionReverse = [[behObj valueForKey:@"motionReverse"] boolValue];
    _motionStartCCValue = [[behObj valueForKey:@"motionStartCCValue"] integerValue];
    
    // Start from false.
    _midiToggled = NO;
    _motionToggled = NO;
    
    _lastCCValue = -1;
    _subscriberId = -1;
    
    [self initSingletons];
  }
  return self;
}

- (void)initSingletons {
  self.deviceManager = [MIKMIDIDeviceManager sharedDeviceManager];
  self.connectionManager = [MIDIEngine shared].connectionManager;
}

- (void)save {
  // Save to Core Data.
  
  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  // Query for this beh2vior.
  NSFetchRequest *getBehavior = [NSFetchRequest fetchRequestWithEntityName:@"Behavior"];
  NSInteger currentPage = [Mappings shared].currentPage;
  [getBehavior setPredicate:
   [NSPredicate predicateWithFormat:@"bowswitch == %d && button == %d && createdTimestamp == %@ && page == %ld",
    self.bowswitch, self.button, self.createdTimestamp, currentPage]];
  
  NSError *behaviorErr = nil;
  NSInteger behaviorCount = [context countForFetchRequest:getBehavior error:&behaviorErr];

  if (behaviorCount > 0) {
    // Existing entry found - use it.
    NSArray *behaviorResults = [context executeFetchRequest:getBehavior error:&behaviorErr];
    NSManagedObject *behObj = behaviorResults.firstObject;
    if (behObj) {
      [self setValuesToNSManagedObject:behObj];
    }
  } else {
    // No existing entry found - use default.
    NSManagedObject *newBehObj = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Behavior"
                                  inManagedObjectContext:context];
    [self setValuesToNSManagedObject:newBehObj];
  }
  
  // Save context.
  NSError *error = nil;
  if ([context save:&error] == NO) {
    NSAssert(NO, @"Error saving context: %@\n%@",
             [error localizedDescription],
             [error userInfo]);
  }
}

- (void)remove {
  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  // Query for this behavior.
  NSFetchRequest *getBehavior = [NSFetchRequest fetchRequestWithEntityName:@"Behavior"];
  NSInteger currentPage = [Mappings shared].currentPage;
  [getBehavior setPredicate:
   [NSPredicate predicateWithFormat:@"bowswitch == %d && button == %d && createdTimestamp == %@ && page == %ld",
    self.bowswitch, self.button, self.createdTimestamp, currentPage]];
  
  NSError *behaviorErr = nil;
  NSInteger behaviorCount = [context countForFetchRequest:getBehavior error:&behaviorErr];
  
  if (behaviorCount > 0) {
    // Existing entry found - delete it.
    NSArray *behaviorResults = [context executeFetchRequest:getBehavior error:&behaviorErr];
    NSManagedObject *behObj = behaviorResults.firstObject;
    if (behObj) {
      [context deleteObject:behObj];
    }
  }
  
  // Save context.
  NSError *error = nil;
  if ([context save:&error] == NO) {
    NSAssert(NO, @"Error saving context: %@\n%@",
             [error localizedDescription],
             [error userInfo]);
  }
}

- (void)behaveForState:(BSButtonState)state {
  
  if (self.type == BBTypeMIDIHoldToActivate) {
    
    if (state == BSButtonStateTouchedIn) {
      [self sendNoteOnOrCCValue];
    } else if (state == BSButtonStateTouchedOut) {
      if (self.midiType == BBMIDITypeNote) {
        [self sendNoteOff];
      }
    }
    
  } else if (self.type == BBTypeMIDIToggle) {
    
    if (state == BSButtonStateTouchedIn) {
      
      if (self.midiToggled) {
        if (self.midiType == BBMIDITypeNote) {
          self.midiVelocity = 0; // Minimum velocity.
          [self sendNoteOff];
        }
      } else {
        self.midiVelocity = 127; // Maximum velocity.
        [self sendNoteOnOrCCValue];
      }
      
      self.midiToggled = !self.midiToggled;
    }
    
  } else if (self.type == BBTypeMIDITouchOut) {
    
    if (state == BSButtonStateTouchedOut) {
      if (self.midiNoteIsOn) {
        [self sendNoteOnOrCCValue];
      } else {
        [self sendNoteOff];
      }
    }
  
  } else if (self.type == BBTypeMIDITouchIn) {
    
    if (state == BSButtonStateTouchedIn) {
      if (self.midiNoteIsOn) {
        [self sendNoteOnOrCCValue];
      } else {
        [self sendNoteOff];
      }
    }
  
  } else if (self.type == BBTypeMapToMotionHoldToActivate) {
    
    if (state == BSButtonStateTouchedIn) {
      [self activateMotion];
    } else if (state == BSButtonStateTouchedOut) {
      [self deactivateMotion];
    }
    
  } else if (self.type == BBTypeMapToMotionToggle) {
    
    if (state == BSButtonStateTouchedIn) {
      
      if (!self.motionToggled) {
        [self activateMotion];
      } else {
        [self deactivateMotion];
      }
      
      self.motionToggled = !self.motionToggled;
    }
  }
}

- (void)setMotionType:(MEMotionType)motionType {
  MotionMapping *mapping = [[MotionEngine shared] mappingForSubscriberId:self.subscriberId];
  mapping.motionType = motionType;
  _motionType = motionType;
}

#pragma mark Helper methods

- (void)sendNoteOnOrCCValue {
  if (self.midiType == BBMIDITypeNote) {
    [self sendNoteOn];
  } else if (self.midiType == BBMIDITypeCC) {
    [self sendCCValue:self.midiCCValue];
  }
}

- (void)sendNoteOn {
  MIKMIDINoteOnCommand *noteOn = [MIKMIDINoteOnCommand noteOnCommandWithNote:self.midiNote
                                                                    velocity:self.midiVelocity
                                                                     channel:self.midiChannel
                                                                   timestamp:[NSDate date]];
  [self sendCommand:noteOn];
}

- (void)sendNoteOff {
  MIKMIDINoteOffCommand *noteOff = [MIKMIDINoteOffCommand noteOffCommandWithNote:self.midiNote
                                                                        velocity:0
                                                                         channel:self.midiChannel
                                                                       timestamp:[NSDate date]];
  [self sendCommand:noteOff];
}

- (void)sendCommand:(MIKMIDICommand *)command {
  // Send to all destinations.
  for (NSInteger i = 0; i < self.connectionManager.connectedDevices.count; i++) {
    MIKMIDIDevice *device = self.connectionManager.connectedDevices.allObjects[i];
    NSArray *destinations = [device.entities valueForKeyPath:@"@unionOfArrays.destinations"];
    for (MIKMIDIDestinationEndpoint *destination in destinations) {
      NSError *error = nil;
      if (![self.deviceManager sendCommands:@[command] toEndpoint:destination error:&error]) {
        NSLog(@"Unable to send command %@ to endpoint %@: %@", command, destination, error);
      }
    }
  }
}

- (void)sendCCValue:(NSInteger)ccValue {
  MIKMutableMIDIControlChangeCommand *command = \
    [MIKMutableMIDIControlChangeCommand commandForCommandType:MIKMIDICommandTypeControlChange];
  command.channel = self.midiChannel;
  command.controllerNumber = self.midiCCControllerNo;
  command.controllerValue = ccValue;
  command.value = ccValue;
  command.timestamp = [NSDate date];
  
  [self sendCommand:command];
}

#pragma mark Motion engine methods

- (void)activateMotion {
  [[MotionEngine shared] activate:YES subscriber:self.subscriberId];
}

- (void)deactivateMotion {
  [[MotionEngine shared] activate:NO subscriber:self.subscriberId];
  if (self.continueFromLastCC) {
    // Update start CC value.
    self.motionStartCCValue = self.lastCCValue;
  }
}

- (void)configureMotion {
  if (self.type == BBTypeMapToMotionHoldToActivate || self.type == BBTypeMapToMotionToggle) {
    // Subscribe new motion.
    self.subscriberId = [[MotionEngine shared] subscribe:self
                                              motionType:self.motionType];
  } else if (self.subscriberId != -1) {
    // Unsubscribe existing motion mapping - if any.
    [[MotionEngine shared] unsubscribe:self.subscriberId];
  }
}

- (void)deconfigureMotion {
  // Unsubscribe existing motion mapping - if any.
  [[MotionEngine shared] unsubscribe:self.subscriberId];
}

#pragma mark - NSObject methods

- (void)dealloc {
  [[MotionEngine shared] unsubscribe:self.subscriberId];
}

#pragma mark - MESubscriber methods

- (void)motionDidStartWithError:(NSError *)error {
  // Do nothing.
}

- (void)updateWithNormalizedValue:(float)normVal
                    startingValue:(float)startVal
                     subscriberId:(NSInteger)subscriberId {
  if (subscriberId == self.subscriberId) {
    
    if (self.type == BBTypeMapToMotionHoldToActivate || self.type == BBTypeMapToMotionToggle) {
      
      float diff = normVal - startVal;
      if (self.motionReverse) {
        diff = startVal - normVal;
      }
      
      float sensitivity = 2.f;
      diff *= sensitivity; // Adjust sensitivity.
      
      NSInteger newCCValue = self.motionStartCCValue + (diff * 127);
      if (newCCValue < 0) {
        newCCValue = 0;
      } else if (newCCValue > 127) {
        newCCValue = 127;
      }
      
      BOOL send = self.lastCCValue != newCCValue;
      
      self.lastCCValue = newCCValue; // Record last CC value.
      
      // Do not send CC signal if it is the same as the last value.
      if (send) {
        // Send asynchronously.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          [self sendCCValue:newCCValue];
        });
      }
    }
  }
}

#pragma mark - NSCopying methods

- (id)copyWithZone:(NSZone *)zone {
  // Note: zone is ignored. It is no longer used by Objective-C.
  
  ButtonBehavior *copyBeh = [ButtonBehavior new];
  
  copyBeh.bowswitch = self.bowswitch;
  copyBeh.button = self.button;
  copyBeh.createdTimestamp = self.createdTimestamp;
  copyBeh.behaviorDescription = self.behaviorDescription;
  copyBeh.type = self.type;
  copyBeh.motionType = self.motionType;
  copyBeh.motionReverse = self.motionReverse;
  copyBeh.motionStartCCValue = self.motionStartCCValue;
  copyBeh.midiType = self.midiType;
  copyBeh.midiNote = self.midiNote;
  copyBeh.midiVelocity = self.midiVelocity;
  copyBeh.midiChannel = self.midiChannel;
  copyBeh.midiCCControllerNo = self.midiCCControllerNo;
  copyBeh.midiCCValue = self.midiCCValue;
  copyBeh.midiToggled = self.midiToggled;
  copyBeh.midiNoteIsOn = self.midiNoteIsOn;
  copyBeh.continueFromLastCC = self.continueFromLastCC;
  
  copyBeh.motionToggled = self.motionToggled;

  return copyBeh;
}

#pragma mark - Helper methods

- (void)setValuesToNSManagedObject:(NSManagedObject *)object {
  [object setValue:[NSNumber numberWithInteger:self.bowswitch] forKey:@"bowswitch"];
  [object setValue:[NSNumber numberWithInteger:self.button] forKey:@"button"];
  [object setValue:self.createdTimestamp forKey:@"createdTimestamp"];
  [object setValue:self.behaviorDescription forKey:@"behaviorDescription"];
  [object setValue:[NSNumber numberWithInteger:self.type] forKey:@"type"];
  [object setValue:[NSNumber numberWithInteger:self.motionType] forKey:@"motionType"];
  [object setValue:[NSNumber numberWithInteger:self.motionReverse] forKey:@"motionReverse"];
  [object setValue:[NSNumber numberWithInteger:self.motionStartCCValue] forKey:@"motionStartCCValue"];
  [object setValue:[NSNumber numberWithInteger:self.midiType] forKey:@"midiType"];
  [object setValue:[NSNumber numberWithInteger:self.midiNote] forKey:@"midiNote"];
  [object setValue:[NSNumber numberWithInteger:self.midiVelocity] forKey:@"midiVelocity"];
  [object setValue:[NSNumber numberWithInteger:self.midiChannel] forKey:@"midiChannel"];
  [object setValue:[NSNumber numberWithInteger:self.midiCCControllerNo] forKey:@"midiCCControllerNo"];
  [object setValue:[NSNumber numberWithInteger:self.midiCCValue] forKey:@"midiCCValue"];
  [object setValue:[NSNumber numberWithInteger:self.midiNoteIsOn] forKey:@"midiNoteIsOn"];
  [object setValue:[NSNumber numberWithInteger:self.continueFromLastCC] forKey:@"continueFromLastCC"];
  NSInteger currentPage = [Mappings shared].currentPage;
  [object setValue:[NSNumber numberWithInteger:currentPage] forKey:@"page"];
}

@end
