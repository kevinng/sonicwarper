//
//  MIDIEngine.m
//  Sonicwarper
//
//  Created by Kevin Ng on 2/5/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "MIDIEngine.h"

@interface MIDIEngine() <MIKMIDIConnectionManagerDelegate>

@property (nonatomic, strong) MIKMIDIDeviceManager *deviceManager;
@property (nonatomic, strong) MIKMIDIConnectionManager *connectionManager;
@property (nonatomic, strong) NSMutableArray<id<MIEMIDISubscriber>> *subscribers;

@end

@implementation MIDIEngine

#pragma mark - Singleton initializers

+ (MIDIEngine *)shared {
  static MIDIEngine *shared = nil;
  if (!shared) {
    shared = [[self alloc] initPrivate];
  }
  return shared;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use + [MIDIEngine shared]"
                               userInfo:nil];
}

- (instancetype)initPrivate {
  self = [super init];
  if (self) {
    _connectionManager = [[MIKMIDIConnectionManager alloc] initWithName:@"Sonicwarper"];
    _deviceManager = [MIKMIDIDeviceManager sharedDeviceManager];
    _subscribers = [NSMutableArray new];
  }
  return self;
}

- (void)handleMIDICommand:(MIKMIDICommand *)command {
  // Update all subscribers.
  for (id<MIEMIDISubscriber> subscriber in self.subscribers) {
    [subscriber updateWithMIDICommand:command];
  }
}

- (void)connect:(MIKMIDIDevice *)device {
  NSError *error = nil;
  [self.connectionManager connectToDevice:device error:&error];
  
  // Add handler to all sources of the device.
  NSArray *sources = [device.entities valueForKeyPath:@"@unionOfArrays.sources"];
  for (NSInteger i = 0; i < sources.count; i++) {
    MIKMIDISourceEndpoint *source = sources[i];
    NSError *error = nil;
    BOOL success = (BOOL)[self.deviceManager
                          connectInput:source
                          error:&error
                          eventHandler:^(MIKMIDISourceEndpoint *source, NSArray *commands) {
      for (MIKMIDICommand *command in commands) {
        // Handle each command
        [self handleMIDICommand:command];
      }
    }];
    if (!success) {
      NSLog(@"Unable to connect to %@: %@", source, error);
    } else {
      NSLog(@"Connected: %@", source.displayName);
    }
  }
}

- (void)connectAll {
  MIKMIDIDeviceManager *manager = [MIKMIDIDeviceManager sharedDeviceManager];
//  NSLog(@"MIDI endpoints:");
  for (MIKMIDIDevice *device in manager.availableDevices) {
    
//    NSLog(@"\t- %@", device.name);
//    for (MIKMIDIEntity *entity in device.entities) {
//      NSLog(@"\t\t - %@", entity.name);
//
//      for (MIKMIDISourceEndpoint *source in entity.sources) {
//        NSLog(@"\t\t\t in: %@", source.name);
//      }
//
//      for (MIKMIDIDestinationEndpoint *destination in entity.destinations) {
//        NSLog(@"\t\t\t out: %@", destination.name);
//      }
//    }
    
    MIDIEngine *engine = [MIDIEngine shared];
    [engine connect:device];
  }
}

- (void)disconnect:(MIKMIDIDevice *)device {
  [self.connectionManager disconnectFromDevice:device];
}

- (NSInteger)connectedDevicesCount {
  return self.connectionManager.connectedDevices.count;
}

- (void)subscribe:(id<MIEMIDISubscriber>)subscriber {
  [self.subscribers addObject:subscriber];
}

- (void)unsubscribe:(id<MIEMIDISubscriber>)subscriber {
  [self.subscribers removeObject:subscriber];
}

#pragma mark - MIKMIDIConnectionManagerDelegate methods

- (MIKMIDIAutoConnectBehavior)connectionManager:(MIKMIDIConnectionManager *)manager
                shouldConnectToNewlyAddedDevice:(MIKMIDIDevice *)device {
  // Only connect to devices the user selects.
  return MIKMIDIAutoConnectBehaviorDoNotConnect;
}

@end
