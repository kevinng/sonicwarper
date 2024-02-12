//
//  TraktorProMidiMessageConstants.h
//  Sonicwarper
//
//  Created by Kevin Ng on 3/4/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import "MIKMIDICommand.h"

#ifndef TraktorProMidiMessageConstants_h
#define TraktorProMidiMessageConstants_h

// ***** Master Levels *****

// * Master levels left *
static const MIKMIDICommandType TraktorMIDIMessage_Out_MasterOutLevelLOutGlobalOutput_CC_Byte1 = \
  0b10111110; // Master Out Level (L) Out Global Output Ch15 CC 007
static const UInt8 TraktorMIDIMessage_Out_MasterOutLevelLOutGlobalOutput_CC_Byte2 = \
  0b00000111; // Master Out Level (L) Out Global Output Ch15 CC 007

// * Master levels right *
static const MIKMIDICommandType TraktorMIDIMessage_Out_MasterOutLevelROutGlobalOutput_CC_Byte1 = \
  0b10111110; // Master Out Level (R) Out Global Output Ch15 CC 008
static const UInt8 TraktorMIDIMessage_Out_MasterOutLevelROutGlobalOutput_CC_Byte2 = \
  0b00001000; // Master Out Level (R) Out Global Output Ch15 CC 008

// ***** Deck A *****

// * Seek position *
static const MIKMIDICommandType TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckAOutput_CC_Byte1 = \
  0b10110110; // Seek Position (Deck Common) Out Deck A Output Ch07 CC 014
static const UInt8 TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckAOutput_CC_Byte2 = \
  0b00001110; // Seek Position (Deck Common) Out Deck A Output Ch07 CC 014

// * FX 1 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_On_Byte1 = \
  0b10010110; // FX Unit 1 On Out Deck A Output Ch07 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_On_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck A Output Ch07 Note D5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_Off_Byte1 = \
  0b10000110; // FX Unit 1 On Out Deck A Output Ch07 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_Off_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck A Output Ch07 Note D5

// * FX 2 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_On_Byte1 = \
  0b10010110; // FX Unit 2 On Out Deck A Output Ch07 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_On_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck A Output Ch07 Note D#5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_Off_Byte1 = \
  0b10000110; // FX Unit 2 On Out Deck A Output Ch07 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_Off_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck A Output Ch07 Note D#5

// * FX 3 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_On_Byte1 = \
  0b10010110; // FX Unit 3 On Out Deck A Output Ch07 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_On_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck A Output Ch07 Note E5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_Off_Byte1 = \
  0b10000110; // FX Unit 3 On Out Deck A Output Ch07 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_Off_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck A Output Ch07 Note E5

// * FX 4 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_On_Byte1 = \
  0b10010110; // FX Unit 4 On Out Deck A Output Ch07 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_On_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck A Output Ch07 Note F5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_Off_Byte1 = \
  0b10000110; // FX Unit 4 On Out Deck A Output Ch07 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_Off_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck A Output Ch07 Note F5

// * Pre-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckAOutput_CC_Byte1 = \
  0b10110110; // Deck Pre-Fader Level (L) Out Deck A Output Ch07 CC 033
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckAOutput_CC_Byte2 = \
  0b00100001; // Deck Pre-Fader Level (L) Out Deck A Output Ch07 CC 033

// * Pre-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckAOutput_CC_Byte1 = \
  0b10110110; // Deck Pre-Fader Level (R) Out Deck A Output Ch07 CC 034
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckAOutput_CC_Byte2 = \
  0b00100010; // Deck Pre-Fader Level (R) Out Deck A Output Ch07 CC 034

// * Post-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckAOutput_CC_Byte1 = \
  0b10110110; // Deck Post-Fader Level (L) Out Deck A Output Ch07 CC 030
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckAOutput_CC_Byte2 = \
  0b00011110; // Deck Post-Fader Level (L) Out Deck A Output Ch07 CC 030

// * Post-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckAOutput_CC_Byte1 = \
  0b10110110; // Deck Post-Fader Level (R) Out Deck A Output Ch07 CC 031
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckAOutput_CC_Byte2 = \
  0b00011111; // Deck Post-Fader Level (R) Out Deck A Output Ch07 CC 031

// * Filter *
static const MIKMIDICommandType TraktorMIDIMessage_Out_FilterAdjustOutDeckAOutput_CC_Byte1 = \
  0b10110110; // Filter Adjust Out Deck A Output Ch07 CC 023
static const UInt8 TraktorMIDIMessage_Out_FilterAdjustOutDeckAOutput_CC_Byte2 = \
  0b00010111; // Filter Adjust Out Deck A Output Ch07 CC 023

// * Flux mode *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_On_Byte1 = \
  0b10010110; // Flux Mode On Out Deck A Output Ch07 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_On_Byte2 = \
  0b00001000; // Flux Mode On Out Deck A Output Ch07 Note G#-1
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_Off_Byte1 = \
  0b10000110; // Flux Mode On Out Deck A Output Ch07 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_Off_Byte2 = \
  0b00001000; // Flux Mode On Out Deck A Output Ch07 Note G#-1

// * Loop active *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_On_Byte1 = \
  0b10010110; // Loop Active On Out Deck A Output Ch07 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_On_Byte2 = \
  0b01000000; // Loop Active On Out Deck A Output Ch07 Note E4
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_Off_Byte1 = \
  0b10000110; // Loop Active On Out Deck A Output Ch07 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_Off_Byte2 = \
  0b01000000; // Loop Active On Out Deck A Output Ch07 Note E4

// ***** Deck B *****

// * Seek position *
static const MIKMIDICommandType TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckBOutput_CC_Byte1 = \
  0b10110111; // Seek Position (Deck Common) Out Deck B Output Ch08 CC 014
static const UInt8 TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckBOutput_CC_Byte2 = \
  0b00001110; // Seek Position (Deck Common) Out Deck B Output Ch08 CC 014

// * FX 1 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_On_Byte1 = \
  0b10010111; // FX Unit 1 On Out Deck B Output Ch08 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_On_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck B Output Ch08 Note D5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_Off_Byte1 = \
  0b10000111; // FX Unit 1 On Out Deck B Output Ch08 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_Off_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck B Output Ch08 Note D5

// * FX 2 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_On_Byte1 = \
  0b10010111; // FX Unit 2 On Out Deck B Output Ch08 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_On_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck B Output Ch08 Note D#5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_Off_Byte1 = \
  0b10000111; // FX Unit 2 On Out Deck B Output Ch08 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_Off_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck B Output Ch08 Note D#5

// * FX 3 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_On_Byte1 = \
  0b10010111; // FX Unit 3 On Out Deck B Output Ch08 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_On_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck B Output Ch08 Note E5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_Off_Byte1 = \
  0b10000111; // FX Unit 3 On Out Deck B Output Ch08 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_Off_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck B Output Ch08 Note E5

// * FX 4 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_On_Byte1 = \
  0b10010111; // FX Unit 4 On Out Deck B Output Ch08 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_On_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck B Output Ch08 Note F5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_Off_Byte1 = \
  0b10000111; // FX Unit 4 On Out Deck B Output Ch08 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_Off_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck B Output Ch08 Note F5

// * Pre-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckBOutput_CC_Byte1 = \
  0b10110111; // Deck Pre-Fader Level (L) Out Deck B Output Ch08 CC 033
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckBOutput_CC_Byte2 = \
  0b00100001; // Deck Pre-Fader Level (L) Out Deck B Output Ch08 CC 033

// * Pre-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckBOutput_CC_Byte1 = \
  0b10110111; // Deck Pre-Fader Level (R) Out Deck B Output Ch08 CC 034
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckBOutput_CC_Byte2 = \
  0b00100010; // Deck Pre-Fader Level (R) Out Deck B Output Ch08 CC 034

// * Post-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckBOutput_CC_Byte1 = \
  0b10110111; // Deck Post-Fader Level (L) Out Deck B Output Ch08 CC 030
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckBOutput_CC_Byte2 = \
  0b00011110; // Deck Post-Fader Level (L) Out Deck B Output Ch08 CC 030

// * Post-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckBOutput_CC_Byte1 = \
  0b10110111; // Deck Post-Fader Level (R) Out Deck B Output Ch08 CC 031
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckBOutput_CC_Byte2 = \
  0b00011111; // Deck Post-Fader Level (R) Out Deck B Output Ch08 CC 031

// * Filter *
static const MIKMIDICommandType TraktorMIDIMessage_Out_FilterAdjustOutDeckBOutput_CC_Byte1 = \
  0b10110111; // Filter Adjust Out Deck B Output Ch08 CC 023
static const UInt8 TraktorMIDIMessage_Out_FilterAdjustOutDeckBOutput_CC_Byte2 = \
  0b00010111; // Filter Adjust Out Deck B Output Ch08 CC 023

// * Flux mode *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_On_Byte1 = \
  0b10010111; // Flux Mode On Out Deck B Output Ch08 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_On_Byte2 = \
  0b00001000; // Flux Mode On Out Deck B Output Ch08 Note G#-1
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_Off_Byte1 = \
  0b10000111; // Flux Mode On Out Deck B Output Ch08 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_Off_Byte2 = \
  0b00001000; // Flux Mode On Out Deck B Output Ch08 Note G#-1

// * Loop active *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_On_Byte1 = \
  0b10010111; // Loop Active On Out Deck B Output Ch08 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_On_Byte2 = \
  0b01000000; // Loop Active On Out Deck B Output Ch08 Note E4
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_Off_Byte1 = \
  0b10000111; // Loop Active On Out Deck B Output Ch08 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_Off_Byte2 = 0b01000000; // Loop Active On Out Deck B Output Ch08 Note E4

// ***** Deck C *****

// * Seek position *
static const MIKMIDICommandType TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckCOutput_CC_Byte1 = \
  0b10111000; // Seek Position (Deck Common) Out Deck C Output Ch09 CC 014
static const UInt8 TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckCOutput_CC_Byte2 = \
  0b00001110; // Seek Position (Deck Common) Out Deck C Output Ch09 CC 014

// * FX 1 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_On_Byte1 = \
  0b10011000; // FX Unit 1 On Out Deck C Output Ch09 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_On_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck C Output Ch09 Note D5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_Off_Byte1 = \
  0b10001000; // FX Unit 1 On Out Deck C Output Ch09 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_Off_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck C Output Ch09 Note D5

// * FX 2 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_On_Byte1 = \
  0b10011000; // FX Unit 2 On Out Deck C Output Ch09 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_On_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck C Output Ch09 Note D#5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_Off_Byte1 = \
  0b10001000; // FX Unit 2 On Out Deck C Output Ch09 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_Off_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck C Output Ch09 Note D#5

// * FX 3 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_On_Byte1 = \
  0b10011000; // FX Unit 3 On Out Deck C Output Ch09 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_On_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck C Output Ch09 Note E5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_Off_Byte1 = \
  0b10001000; // FX Unit 3 On Out Deck C Output Ch09 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_Off_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck C Output Ch09 Note E5

// * FX 4 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_On_Byte1 = \
  0b10011000; // FX Unit 4 On Out Deck C Output Ch09 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_On_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck C Output Ch09 Note F5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_Off_Byte1 = \
  0b10001000; // FX Unit 4 On Out Deck C Output Ch09 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_Off_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck C Output Ch09 Note F5

// * Pre-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckCOutput_CC_Byte1 = \
  0b10111000; // Deck Pre-Fader Level (L) Out Deck C Output Ch09 CC 033
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckCOutput_CC_Byte2 = \
  0b00100001; // Deck Pre-Fader Level (L) Out Deck C Output Ch09 CC 033

// * Pre-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckCOutput_CC_Byte1 = \
  0b10111000; // Deck Pre-Fader Level (R) Out Deck C Output Ch09 CC 034
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckCOutput_CC_Byte2 = \
  0b00100010; // Deck Pre-Fader Level (R) Out Deck C Output Ch09 CC 034

// * Post-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckCOutput_CC_Byte1 = \
  0b10111000; // Deck Post-Fader Level (L) Out Deck C Output Ch09 CC 030
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckCOutput_CC_Byte2 = \
  0b00011110; // Deck Post-Fader Level (L) Out Deck C Output Ch09 CC 030

// * Post-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckCOutput_CC_Byte1 = \
  0b10111000; // Deck Post-Fader Level (R) Out Deck C Output Ch09 CC 031
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckCOutput_CC_Byte2 = \
  0b00011111; // Deck Post-Fader Level (R) Out Deck C Output Ch09 CC 031

// * Filter *
static const MIKMIDICommandType TraktorMIDIMessage_Out_FilterAdjustOutDeckCOutput_CC_Byte1 = \
  0b10111000; // Filter Adjust Out Deck C Output Ch09 CC 023
static const UInt8 TraktorMIDIMessage_Out_FilterAdjustOutDeckCOutput_CC_Byte2 = \
  0b00010111; // Filter Adjust Out Deck C Output Ch09 CC 023

// * Flux mode *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_On_Byte1 = \
  0b10011000; // Flux Mode On Out Deck C Output Ch09 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_On_Byte2 = \
  0b00001000; // Flux Mode On Out Deck C Output Ch09 Note G#-1
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_Off_Byte1 = \
  0b10001000; // Flux Mode On Out Deck C Output Ch09 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_Off_Byte2 = \
  0b00001000; // Flux Mode On Out Deck C Output Ch09 Note G#-1

// * Loop active *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_On_Byte1 = \
  0b10011000; // Loop Active On Out Deck C Output Ch09 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_On_Byte2 = \
  0b01000000; // Loop Active On Out Deck C Output Ch09 Note E4
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_Off_Byte1 = \
  0b10001000; // Loop Active On Out Deck C Output Ch09 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_Off_Byte2 = \
  0b01000000; // Loop Active On Out Deck C Output Ch09 Note E4

// ***** Deck D *****

// * Seek position *
static const MIKMIDICommandType TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckDOutput_CC_Byte1 = \
  0b10111001; // Seek Position (Deck Common) Out Deck D Output Ch10 CC 014
static const UInt8 TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckDOutput_CC_Byte2 = \
  0b00001110; // Seek Position (Deck Common) Out Deck D Output Ch10 CC 014

// * FX 1 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_On_Byte1 = \
  0b10011001; // FX Unit 1 On Out Deck D Output Ch10 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_On_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck D Output Ch10 Note D5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_Off_Byte1 = \
  0b10001001; // FX Unit 1 On Out Deck D Output Ch10 Note D5
static const UInt8 TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_Off_Byte2 = \
  0b01001010; // FX Unit 1 On Out Deck D Output Ch10 Note D5

// * FX 2 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_On_Byte1 = \
  0b10011001; // FX Unit 2 On Out Deck D Output Ch10 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_On_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck D Output Ch10 Note D#5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_Off_Byte1 = \
  0b10001001; // FX Unit 2 On Out Deck D Output Ch10 Note D#5
static const UInt8 TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_Off_Byte2 = \
  0b01001011; // FX Unit 2 On Out Deck D Output Ch10 Note D#5

// * FX 3 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_On_Byte1 = \
  0b10011001; // FX Unit 3 On Out Deck D Output Ch10 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_On_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck D Output Ch10 Note E5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_Off_Byte1 = \
  0b10001001; // FX Unit 3 On Out Deck D Output Ch10 Note E5
static const UInt8 TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_Off_Byte2 = \
  0b01001100; // FX Unit 3 On Out Deck D Output Ch10 Note E5

// * FX 4 *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_On_Byte1 = \
  0b10011001; // FX Unit 4 On Out Deck D Output Ch10 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_On_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck D Output Ch10 Note F5
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_Off_Byte1 = \
  0b10001001; // FX Unit 4 On Out Deck D Output Ch10 Note F5
static const UInt8 TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_Off_Byte2 = \
  0b01001101; // FX Unit 4 On Out Deck D Output Ch10 Note F5

// * Pre-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckDOutput_CC_Byte1 = \
  0b10111001; // Deck Pre-Fader Level (L) Out Deck D Output Ch10 CC 033
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckDOutput_CC_Byte2 = \
  0b00100001; // Deck Pre-Fader Level (L) Out Deck D Output Ch10 CC 033

// * Pre-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckDOutput_CC_Byte1 = \
  0b10111001; // Deck Pre-Fader Level (R) Out Deck D Output Ch10 CC 034
static const UInt8 TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckDOutput_CC_Byte2 = \
  0b00100010; // Deck Pre-Fader Level (R) Out Deck D Output Ch10 CC 034

// * Post-left levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckDOutput_CC_Byte1 = \
  0b10111001; // Deck Post-Fader Level (L) Out Deck D Output Ch10 CC 030
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckDOutput_CC_Byte2 = \
  0b00011110; // Deck Post-Fader Level (L) Out Deck D Output Ch10 CC 030

// * Post-right levels *
static const MIKMIDICommandType TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckDOutput_CC_Byte1 = \
  0b10111001; // Deck Post-Fader Level (R) Out Deck D Output Ch10 CC 031
static const UInt8 TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckDOutput_CC_Byte2 = \
  0b00011111; // Deck Post-Fader Level (R) Out Deck D Output Ch10 CC 031

// * Filter *
static const MIKMIDICommandType TraktorMIDIMessage_Out_FilterAdjustOutDeckDOutput_CC_Byte1 = \
  0b10111001; // Filter Adjust Out Deck D Output Ch10 CC 023
static const UInt8 TraktorMIDIMessage_Out_FilterAdjustOutDeckDOutput_CC_Byte2 = \
  0b00010111; // Filter Adjust Out Deck D Output Ch10 CC 023

// * Flux mode *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_On_Byte1 = \
  0b10011001; // Flux Mode On Out Deck D Output Ch10 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_On_Byte2 = \
  0b00001000; // Flux Mode On Out Deck D Output Ch10 Note G#-1
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_Off_Byte1 = \
  0b10001001; // Flux Mode On Out Deck D Output Ch10 Note G#-1
static const UInt8 TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_Off_Byte2 = \
  0b00001000; // Flux Mode On Out Deck D Output Ch10 Note G#-1

// * Loop active *
//  - On
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_On_Byte1 = \
  0b10011001; // Loop Active On Out Deck D Output Ch10 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_On_Byte2 = \
  0b01000000; // Loop Active On Out Deck D Output Ch10 Note E4
//  - Off
static const MIKMIDICommandType TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_Off_Byte1 = \
  0b10001001; // Loop Active On Out Deck D Output Ch10 Note E4
static const UInt8 TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_Off_Byte2 = \
  0b01000000; // Loop Active On Out Deck D Output Ch10 Note E4

#endif /* TraktorProMidiMessageConstants_h */
