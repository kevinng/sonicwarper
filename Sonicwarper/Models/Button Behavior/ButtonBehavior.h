//
//  ButtonBehavior.h
//  Sonicwarper
//
//  Created by Kevin Ng on 5/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BowswitchView.h"
#import "MotionEngine.h"
#import "MotionMapping.h"
@import CoreData;

#ifndef BUTTON_BEHAVIOR

typedef NS_ENUM(NSInteger, BBType) {
  BBTypeMIDIHoldToActivate,
  BBTypeMIDIToggle,
  BBTypeMIDITouchIn,
  BBTypeMIDITouchOut,
  BBTypeMapToMotionHoldToActivate,
  BBTypeMapToMotionToggle
};

typedef NS_ENUM(NSInteger, BBMIDIType) {
  BBMIDITypeNote,
  BBMIDITypeCC
};

#endif

@interface ButtonBehavior : NSObject <MEMotionSubscriber, NSCopying>

@property (nonatomic) BSBowswitchPosition bowswitch;
@property (nonatomic) BSButtonPosition button;
@property (nonatomic) NSString *createdTimestamp;

// Properties in order of appearance on the scene

@property (nonatomic, strong) NSString *behaviorDescription;

@property (nonatomic) BBType type; // Behavior type
@property (nonatomic) MEMotionType motionType; // Motion - motion type (e.g. rotate)
@property (nonatomic) Boolean motionReverse; // Motion - reverse mapping?
@property (nonatomic) NSInteger motionStartCCValue; // Motion - starting CC value: 0 to 127
@property (nonatomic) BBMIDIType midiType; // MIDI type: CC or Note
@property (nonatomic) NSInteger midiNote; // MIDI note: 0 to 127
@property (nonatomic) NSInteger midiNoteIsOn; // MIDI note is on? If false - is off.
@property (nonatomic) NSInteger midiVelocity; // MIDI velocity: 0 to 127
@property (nonatomic) NSInteger midiChannel; // MIDI channel: 0 to 15
@property (nonatomic) NSInteger midiCCControllerNo; // MIDI CC controller no.: 0 to 127
@property (nonatomic) NSInteger midiCCValue; // MIDI CC value: 0 to 127
@property (nonatomic) Boolean midiToggled; // If NO, the next MIDI note to send is on. Begins false.
@property (nonatomic) Boolean motionToggled; // If NO, the next motion mapping is on. Begins false.
@property (nonatomic) Boolean continueFromLastCC; // If YES, CC +/- continues from last CC value.

// Motion
@property (nonatomic) NSInteger subscriberId; // -1 if no motion

- (void)behaveForState:(BSButtonState)state;
- (void)configureMotion;
- (void)deconfigureMotion;
- (void)activateMotion;
- (void)deactivateMotion;

- (void)save;
- (void)remove;

- (instancetype)initWithManagedObject:(NSManagedObject *)behObj;

@end
