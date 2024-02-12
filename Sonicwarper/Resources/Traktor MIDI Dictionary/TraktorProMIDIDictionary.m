//
//  TraktorProMidiDictionary.m
//  Sonicwarper
//
//  Created by Kevin Ng on 2/4/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "TraktorProMIDIMessageConstants.h"
#import "TraktorProMIDIDictionary.h"
#import "MIKMidiChannelVoiceCommand.h"

@implementation TraktorProMIDIDictionary

static const Boolean SHOW_LOG_MSG__TraktorProMIDIDictionary = NO;
static const UInt8 MAX_VELOCITY = 0b01111111;

#define isImplement(COMMAND_NAME) \
+ (BOOL)is##COMMAND_NAME:(MIKMIDIChannelVoiceCommand *)command { \
  BOOL match = (((command.commandType >> 4) << 4) == ((COMMAND_NAME##_Byte1 >> 4) << 4) && \
                command.channel == (COMMAND_NAME##_Byte1 & 0b1111) && \
                command.dataByte1 == COMMAND_NAME##_Byte2); \
  if (SHOW_LOG_MSG__TraktorProMIDIDictionary) \
    printf("[%d == %d &&\n%d == %d &&\n%d == %d]", \
         (int)((command.commandType >> 4) << 4), (int)((COMMAND_NAME##_Byte1 >> 4) << 4), \
         (int)command.channel, (int)(COMMAND_NAME##_Byte1 & 0b1111), \
         (int)command.dataByte1, (int)COMMAND_NAME##_Byte2); \
  return match; \
}

#define returnImplement(COMMAND_NAME) \
+ (MIKMIDICommand *)COMMAND_NAME:(UInt8)dataByte2 { \
MIKMutableMIDICommand *command = [MIKMutableMIDICommand \
commandForCommandType: \
COMMAND_NAME##_Byte1]; \
command.dataByte1 = COMMAND_NAME##_Byte2; \
command.dataByte2 = dataByte2; \
return command; \
}

+ (float)normalizedCcValue:(MIKMIDICommand *)command {
  return (float)command.dataByte2 / (float)MAX_VELOCITY;
}

+ (BOOL)velocityNotZero:(MIKMIDICommand *)command {
  return command.dataByte2 != 0;
}

+ (BOOL)velocityOf:(MIKMIDICommand *)command isValue:(UInt8)value {
  return command.dataByte2 == value;
}

#pragma mark Is methods

// ***** Master levels *****

// * Master levels left *
isImplement(TraktorMIDIMessage_Out_MasterOutLevelLOutGlobalOutput_CC) // Master Out Level (L) Out Global Output Ch15 CC 007
returnImplement(TraktorMIDIMessage_Out_MasterOutLevelLOutGlobalOutput_CC) // Master Out Level (L) Out Global Output Ch15 CC 007

// * Master levels right *
isImplement(TraktorMIDIMessage_Out_MasterOutLevelROutGlobalOutput_CC) // Master Out Level (R) Out Global Output Ch15 CC 008
returnImplement(TraktorMIDIMessage_Out_MasterOutLevelROutGlobalOutput_CC) // Master Out Level (R) Out Global Output Ch15 CC 008

// ***** Deck A *****

// * Seek position *
isImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckAOutput_CC) // Seek Position (Deck Common) Out Deck A Output Ch07 CC 014
returnImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckAOutput_CC) // Seek Position (Deck Common) Out Deck A Output Ch07 CC 014

// * FX 1 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_On) // FX Unit 1 On Out Deck A Output Ch07 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_On) // FX Unit 1 On Out Deck A Output Ch07 Note D5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_Off) // FX Unit 1 On Out Deck A Output Ch07 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_Off) // FX Unit 1 On Out Deck A Output Ch07 Note D5

// * FX 2 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_On) // FX Unit 2 On Out Deck A Output Ch07 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_On) // FX Unit 2 On Out Deck A Output Ch07 Note D#5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_Off) // FX Unit 2 On Out Deck A Output Ch07 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_Off) // FX Unit 2 On Out Deck A Output Ch07 Note D#5

// * FX 3 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_On) // FX Unit 3 On Out Deck A Output Ch07 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_On) // FX Unit 3 On Out Deck A Output Ch07 Note E5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_Off) // FX Unit 3 On Out Deck A Output Ch07 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_Off) // FX Unit 3 On Out Deck A Output Ch07 Note E5

// * FX 4 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_On) // FX Unit 4 On Out Deck A Output Ch07 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_On) // FX Unit 4 On Out Deck A Output Ch07 Note F5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_Off) // FX Unit 4 On Out Deck A Output Ch07 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_Off) // FX Unit 4 On Out Deck A Output Ch07 Note F5

// * Pre-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckAOutput_CC) // Deck Pre-Fader Level (L) Out Deck A Output Ch07 CC 033
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckAOutput_CC) // Deck Pre-Fader Level (L) Out Deck A Output Ch07 CC 033

// * Pre-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckAOutput_CC) // Deck Pre-Fader Level (R) Out Deck A Output Ch07 CC 034
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckAOutput_CC) // Deck Pre-Fader Level (R) Out Deck A Output Ch07 CC 034

// * Post-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckAOutput_CC) // Deck Post-Fader Level (L) Out Deck A Output Ch07 CC 030
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckAOutput_CC) // Deck Post-Fader Level (L) Out Deck A Output Ch07 CC 030

// * Post-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckAOutput_CC) // Deck Post-Fader Level (R) Out Deck A Output Ch07 CC 031
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckAOutput_CC) // Deck Post-Fader Level (R) Out Deck A Output Ch07 CC 031

// * Filter *
isImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckAOutput_CC) // Filter Adjust Out Deck A Output Ch07 CC 023
returnImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckAOutput_CC) // Filter Adjust Out Deck A Output Ch07 CC 023

// * Flux mode *
//  - On
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_On) // Flux Mode On Out Deck A Output Ch07 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_On) // Flux Mode On Out Deck A Output Ch07 Note G#-1
//  - Off
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_Off) // Flux Mode On Out Deck A Output Ch07 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_Off) // Flux Mode On Out Deck A Output Ch07 Note G#-1

// * Loop active *
//  - On
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_On) // Loop Active On Out Deck A Output Ch07 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_On) // Loop Active On Out Deck A Output Ch07 Note E4
//  - Off
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_Off) // Loop Active On Out Deck A Output Ch07 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_Off) // Loop Active On Out Deck A Output Ch07 Note E4

// ***** Deck B *****

// * Seek position *
isImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckBOutput_CC) // Seek Position (Deck Common) Out Deck B Output Ch08 CC 014
returnImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckBOutput_CC) // Seek Position (Deck Common) Out Deck B Output Ch08 CC 014

// * FX 1 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_On) // FX Unit 1 On Out Deck B Output Ch08 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_On) // FX Unit 1 On Out Deck B Output Ch08 Note D5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_Off) // FX Unit 1 On Out Deck B Output Ch08 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_Off) // FX Unit 1 On Out Deck B Output Ch08 Note D5

// * FX 2 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_On) // FX Unit 2 On Out Deck B Output Ch08 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_On) // FX Unit 2 On Out Deck B Output Ch08 Note D#5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_Off) // FX Unit 2 On Out Deck B Output Ch08 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_Off) // FX Unit 2 On Out Deck B Output Ch08 Note D#5

// * FX 3 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_On) // FX Unit 3 On Out Deck B Output Ch08 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_On) // FX Unit 3 On Out Deck B Output Ch08 Note E5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_Off) // FX Unit 3 On Out Deck B Output Ch08 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_Off) // FX Unit 3 On Out Deck B Output Ch08 Note E5

// * FX 4 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_On) // FX Unit 4 On Out Deck B Output Ch08 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_On) // FX Unit 4 On Out Deck B Output Ch08 Note F5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_Off) // FX Unit 4 On Out Deck B Output Ch08 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_Off) // FX Unit 4 On Out Deck B Output Ch08 Note F5

// * Pre-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckBOutput_CC) // Deck Pre-Fader Level (L) Out Deck B Output Ch08 CC 033
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckBOutput_CC) // Deck Pre-Fader Level (L) Out Deck B Output Ch08 CC 033

// * Pre-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckBOutput_CC) // Deck Pre-Fader Level (R) Out Deck B Output Ch08 CC 034
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckBOutput_CC) // Deck Pre-Fader Level (R) Out Deck B Output Ch08 CC 034

// * Post-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckBOutput_CC) // Deck Post-Fader Level (L) Out Deck B Output Ch08 CC 030
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckBOutput_CC) // Deck Post-Fader Level (L) Out Deck B Output Ch08 CC 030

// * Post-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckBOutput_CC) // Deck Post-Fader Level (R) Out Deck B Output Ch08 CC 031
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckBOutput_CC) // Deck Post-Fader Level (R) Out Deck B Output Ch08 CC 031

// * Filter *
isImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckBOutput_CC) // Filter Adjust Out Deck B Output Ch08 CC 023
returnImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckBOutput_CC) // Filter Adjust Out Deck B Output Ch08 CC 023

// * Flux mode *
//  - On
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_On) // Flux Mode On Out Deck B Output Ch08 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_On) // Flux Mode On Out Deck B Output Ch08 Note G#-1
//  - Off
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_Off) // Flux Mode On Out Deck B Output Ch08 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_Off) // Flux Mode On Out Deck B Output Ch08 Note G#-1

// * Loop active *
//  - On
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_On) // Loop Active On Out Deck B Output Ch08 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_On) // Loop Active On Out Deck B Output Ch08 Note E4
//  - Off
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_Off) // Loop Active On Out Deck B Output Ch08 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_Off) // Loop Active On Out Deck B Output Ch08 Note E4

// ***** Deck C *****

// * Seek position *
isImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckCOutput_CC) // Seek Position (Deck Common) Out Deck C Output Ch09 CC 014
returnImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckCOutput_CC) // Seek Position (Deck Common) Out Deck C Output Ch09 CC 014

// * FX 1 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_On) // FX Unit 1 On Out Deck C Output Ch09 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_On) // FX Unit 1 On Out Deck C Output Ch09 Note D5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_Off) // FX Unit 1 On Out Deck C Output Ch09 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_Off) // FX Unit 1 On Out Deck C Output Ch09 Note D5

// * FX 2 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_On) // FX Unit 2 On Out Deck C Output Ch09 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_On) // FX Unit 2 On Out Deck C Output Ch09 Note D#5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_Off) // FX Unit 2 On Out Deck C Output Ch09 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_Off) // FX Unit 2 On Out Deck C Output Ch09 Note D#5

// * FX 3 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_On) // FX Unit 3 On Out Deck C Output Ch09 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_On) // FX Unit 3 On Out Deck C Output Ch09 Note E5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_Off) // FX Unit 3 On Out Deck C Output Ch09 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_Off) // FX Unit 3 On Out Deck C Output Ch09 Note E5

// * FX 4 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_On) // FX Unit 4 On Out Deck C Output Ch09 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_On) // FX Unit 4 On Out Deck C Output Ch09 Note F5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_Off) // FX Unit 4 On Out Deck C Output Ch09 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_Off) // FX Unit 4 On Out Deck C Output Ch09 Note F5

// * Pre-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckCOutput_CC) // Deck Pre-Fader Level (L) Out Deck C Output Ch09 CC 033
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckCOutput_CC) // Deck Pre-Fader Level (L) Out Deck C Output Ch09 CC 033

// * Pre-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckCOutput_CC) // Deck Pre-Fader Level (R) Out Deck C Output Ch09 CC 034
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckCOutput_CC) // Deck Pre-Fader Level (R) Out Deck C Output Ch09 CC 034

// * Post-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckCOutput_CC) // Deck Post-Fader Level (L) Out Deck C Output Ch09 CC 030
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckCOutput_CC) // Deck Post-Fader Level (L) Out Deck C Output Ch09 CC 030

// * Post-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckCOutput_CC) // Deck Post-Fader Level (R) Out Deck C Output Ch09 CC 031
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckCOutput_CC) // Deck Post-Fader Level (R) Out Deck C Output Ch09 CC 031

// * Filter *
isImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckCOutput_CC) // Filter Adjust Out Deck C Output Ch09 CC 023
returnImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckCOutput_CC) // Filter Adjust Out Deck C Output Ch09 CC 023

// * Flux mode *
//  - On
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_On) // Flux Mode On Out Deck C Output Ch09 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_On) // Flux Mode On Out Deck C Output Ch09 Note G#-1
//  - Off
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_Off) // Flux Mode On Out Deck C Output Ch09 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_Off) // Flux Mode On Out Deck C Output Ch09 Note G#-1

// * Loop active *
//  - On
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_On) // Loop Active On Out Deck C Output Ch09 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_On) // Loop Active On Out Deck C Output Ch09 Note E4
//  - Off
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_Off) // Loop Active On Out Deck C Output Ch09 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_Off) // Loop Active On Out Deck C Output Ch09 Note E4

// ***** Deck D *****

// * Seek position *
isImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckDOutput_CC) // Seek Position (Deck Common) Out Deck D Output Ch10 CC 014
returnImplement(TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckDOutput_CC) // Seek Position (Deck Common) Out Deck D Output Ch10 CC 014

// * FX 1 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_On) // FX Unit 1 On Out Deck D Output Ch10 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_On) // FX Unit 1 On Out Deck D Output Ch10 Note D5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_Off) // FX Unit 1 On Out Deck D Output Ch10 Note D5
returnImplement(TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_Off) // FX Unit 1 On Out Deck D Output Ch10 Note D5

// * FX 2 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_On) // FX Unit 2 On Out Deck D Output Ch10 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_On) // FX Unit 2 On Out Deck D Output Ch10 Note D#5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_Off) // FX Unit 2 On Out Deck D Output Ch10 Note D#5
returnImplement(TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_Off) // FX Unit 2 On Out Deck D Output Ch10 Note D#5

// * FX 3 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_On) // FX Unit 3 On Out Deck D Output Ch10 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_On) // FX Unit 3 On Out Deck D Output Ch10 Note E5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_Off) // FX Unit 3 On Out Deck D Output Ch10 Note E5
returnImplement(TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_Off) // FX Unit 3 On Out Deck D Output Ch10 Note E5

// * FX 4 *
//  - On
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_On) // FX Unit 4 On Out Deck D Output Ch10 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_On) // FX Unit 4 On Out Deck D Output Ch10 Note F5
//  - Off
isImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_Off) // FX Unit 4 On Out Deck D Output Ch10 Note F5
returnImplement(TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_Off) // FX Unit 4 On Out Deck D Output Ch10 Note F5

// * Pre-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckDOutput_CC) // Deck Pre-Fader Level (L) Out Deck D Output Ch10 CC 033
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckDOutput_CC) // Deck Pre-Fader Level (L) Out Deck D Output Ch10 CC 033

// * Pre-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckDOutput_CC) // Deck Pre-Fader Level (R) Out Deck D Output Ch10 CC 034
returnImplement(TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckDOutput_CC) // Deck Pre-Fader Level (R) Out Deck D Output Ch10 CC 034

// * Post-left levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckDOutput_CC) // Deck Post-Fader Level (L) Out Deck D Output Ch10 CC 030
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckDOutput_CC) // Deck Post-Fader Level (L) Out Deck D Output Ch10 CC 030

// * Post-right levels *
isImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckDOutput_CC) // Deck Post-Fader Level (R) Out Deck D Output Ch10 CC 031
returnImplement(TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckDOutput_CC) // Deck Post-Fader Level (R) Out Deck D Output Ch10 CC 031

// * Filter *
isImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckDOutput_CC) // Filter Adjust Out Deck D Output Ch10 CC 023
returnImplement(TraktorMIDIMessage_Out_FilterAdjustOutDeckDOutput_CC) // Filter Adjust Out Deck D Output Ch10 CC 023

// * Flux mode *
//  - On
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_On) // Flux Mode On Out Deck D Output Ch10 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_On) // Flux Mode On Out Deck D Output Ch10 Note G#-1
//  - Off
isImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_Off) // Flux Mode On Out Deck D Output Ch10 Note G#-1
returnImplement(TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_Off) // Flux Mode On Out Deck D Output Ch10 Note G#-1

// * Loop active *
//  - On
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_On) // Loop Active On Out Deck D Output Ch10 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_On) // Loop Active On Out Deck D Output Ch10 Note E4
//  - Off
isImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_Off) // Loop Active On Out Deck D Output Ch10 Note E4
returnImplement(TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_Off) // Loop Active On Out Deck D Output Ch10 Note E4

@end
