//
//  MIDIEngine.h
//  Sonicwarper
//
//  Created by Kevin Ng on 2/5/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MIKMIDI/MIKMIDI.h>

@protocol MIEMIDISubscriber <NSObject>

@required

- (void)updateWithMIDICommand:(MIKMIDICommand *)command;

@end

@interface MIDIEngine : NSObject

+ (MIDIEngine *)shared;

@property (nonatomic, strong, readonly) MIKMIDIConnectionManager *connectionManager;

- (void)connect:(MIKMIDIDevice *)device;
- (void)disconnect:(MIKMIDIDevice *)device;
- (void)connectAll;

- (void)subscribe:(id<MIEMIDISubscriber>)subscriber;
- (void)unsubscribe:(id<MIEMIDISubscriber>)subscriber;

- (NSInteger)connectedDevicesCount;

@end
