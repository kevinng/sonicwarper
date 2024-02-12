//
//  TraktorProMidiDictionary.h
//  Sonicwarper
//
//  Created by Kevin Ng on 2/4/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIKMidiCommand.h"

@interface TraktorProMIDIDictionary : NSObject

+ (float)normalizedCcValue:(MIKMIDICommand *)command;
+ (BOOL)velocityNotZero:(MIKMIDICommand *)command;
+ (BOOL)velocityOf:(MIKMIDICommand *)command isValue:(UInt8)value;

#pragma mark Is methods

// ***** Master levels *****

// * Master levels left *
+ (BOOL)isTraktorMIDIMessage_Out_MasterOutLevelLOutGlobalOutput_CC:(MIKMIDICommand *)command; // Master Out Level (L) Out Global Output Ch15 CC 007
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_MasterOutLevelLOutGlobalOutput_CC:(UInt8)dataByte2; // Master Out Level (L) Out Global Output Ch15 CC 007

// * Master levels right *
+ (BOOL)isTraktorMIDIMessage_Out_MasterOutLevelROutGlobalOutput_CC:(MIKMIDICommand *)command; // Master Out Level (R) Out Global Output Ch15 CC 008
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_MasterOutLevelROutGlobalOutput_CC:(UInt8)dataByte2; // Master Out Level (R) Out Global Output Ch15 CC 008

// ***** Deck A *****

// * Seek position *
+ (BOOL)isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckAOutput_CC:(MIKMIDICommand *)command; // Seek Position (Deck Common) Out Deck A Output Ch07 CC 014
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckAOutput_CC:(UInt8)dataByte2; // Seek Position (Deck Common) Out Deck A Output Ch07 CC 014

// * FX 1 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_On:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck A Output Ch07 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_On:(UInt8)dataByte2; // FX Unit 1 On Out Deck A Output Ch07 Note D5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_Off:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck A Output Ch07 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckAOutput_Off:(UInt8)dataByte2; // FX Unit 1 On Out Deck A Output Ch07 Note D5


// * FX 2 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_On:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck A Output Ch07 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_On:(UInt8)dataByte2; // FX Unit 2 On Out Deck A Output Ch07 Note D#5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_Off:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck A Output Ch07 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckAOutput_Off:(UInt8)dataByte2; // FX Unit 2 On Out Deck A Output Ch07 Note D#5

// * FX 3 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_On:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck A Output Ch07 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_On:(UInt8)dataByte2; // FX Unit 3 On Out Deck A Output Ch07 Note E5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_Off:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck A Output Ch07 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckAOutput_Off:(UInt8)dataByte2; // FX Unit 3 On Out Deck A Output Ch07 Note E5

// * FX 4 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_On:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck A Output Ch07 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_On:(UInt8)dataByte2; // FX Unit 4 On Out Deck A Output Ch07 Note F5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_Off:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck A Output Ch07 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckAOutput_Off:(UInt8)dataByte2; // FX Unit 4 On Out Deck A Output Ch07 Note F5

// * Pre-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckAOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (L) Out Deck A Output Ch07 CC 033
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckAOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (L) Out Deck A Output Ch07 CC 033

// * Pre-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckAOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (R) Out Deck A Output Ch07 CC 034
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckAOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (R) Out Deck A Output Ch07 CC 034

// * Post-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckAOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (L) Out Deck A Output Ch07 CC 030
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckAOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (L) Out Deck A Output Ch07 CC 030

// * Post-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckAOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (R) Out Deck A Output Ch07 CC 031
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckAOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (R) Out Deck A Output Ch07 CC 031

// * Filter *
+ (BOOL)isTraktorMIDIMessage_Out_FilterAdjustOutDeckAOutput_CC:(MIKMIDICommand *)command; // Filter Adjust Out Deck A Output Ch07 CC 023
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FilterAdjustOutDeckAOutput_CC:(UInt8)dataByte2; // Filter Adjust Out Deck A Output Ch07 CC 023

// * Flux mode *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_On:(MIKMIDICommand *)command; // Flux Mode On Out Deck A Output Ch07 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_On:(UInt8)dataByte2; // Flux Mode On Out Deck A Output Ch07 Note G#-1
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_Off:(MIKMIDICommand *)command; // Flux Mode On Out Deck A Output Ch07 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckAOutput_Off:(UInt8)dataByte2; // Flux Mode On Out Deck A Output Ch07 Note G#-1

// * Loop active *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_On:(MIKMIDICommand *)command; // Loop Active On Out Deck A Output Ch07 Note E4
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_On:(UInt8)dataByte2; // Loop Active On Out Deck A Output Ch07 Note E4
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_Off:(MIKMIDICommand *)command; // Loop Active On Out Deck A Output Ch07 Note E4
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckAOutput_Off:(UInt8)dataByte2; // Loop Active On Out Deck A Output Ch07 Note E4

// ***** Deck B *****

// * Seek position *
+ (BOOL)isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckBOutput_CC:(MIKMIDICommand *)command; // Seek Position (Deck Common) Out Deck B Output Ch08 CC 014
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckBOutput_CC:(UInt8)dataByte2; // Seek Position (Deck Common) Out Deck B Output Ch08 CC 014

// * FX 1 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_On:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck B Output Ch08 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_On:(UInt8)dataByte2; // FX Unit 1 On Out Deck B Output Ch08 Note D5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_Off:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck B Output Ch08 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckBOutput_Off:(UInt8)dataByte2; // FX Unit 1 On Out Deck B Output Ch08 Note D5

// * FX 2 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_On:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck B Output Ch08 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_On:(UInt8)dataByte2; // FX Unit 2 On Out Deck B Output Ch08 Note D#5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_Off:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck B Output Ch08 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckBOutput_Off:(UInt8)dataByte2; // FX Unit 2 On Out Deck B Output Ch08 Note D#5

// * FX 3 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_On:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck B Output Ch08 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_On:(UInt8)dataByte2; // FX Unit 3 On Out Deck B Output Ch08 Note E5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_Off:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck B Output Ch08 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckBOutput_Off:(UInt8)dataByte2; // FX Unit 3 On Out Deck B Output Ch08 Note E5

// * FX 4 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_On:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck B Output Ch08 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_On:(UInt8)dataByte2; // FX Unit 4 On Out Deck B Output Ch08 Note F5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_Off:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck B Output Ch08 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckBOutput_Off:(UInt8)dataByte2; // FX Unit 4 On Out Deck B Output Ch08 Note F5

// * Pre-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckBOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (L) Out Deck B Output Ch08 CC 033
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckBOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (L) Out Deck B Output Ch08 CC 033

// * Pre-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckBOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (R) Out Deck B Output Ch08 CC 034
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckBOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (R) Out Deck B Output Ch08 CC 034

// * Post-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckBOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (L) Out Deck B Output Ch08 CC 030
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckBOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (L) Out Deck B Output Ch08 CC 030

// * Post-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckBOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (R) Out Deck B Output Ch08 CC 031
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckBOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (R) Out Deck B Output Ch08 CC 031

// * Filter *
+ (BOOL)isTraktorMIDIMessage_Out_FilterAdjustOutDeckBOutput_CC:(MIKMIDICommand *)command; // Filter Adjust Out Deck B Output Ch08 CC 023
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FilterAdjustOutDeckBOutput_CC:(UInt8)dataByte2; // Filter Adjust Out Deck B Output Ch08 CC 023

// * Flux mode *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_On:(MIKMIDICommand *)command; // Flux Mode On Out Deck B Output Ch08 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_On:(UInt8)dataByte2; // Flux Mode On Out Deck B Output Ch08 Note G#-1
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_Off:(MIKMIDICommand *)command; // Flux Mode On Out Deck B Output Ch08 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckBOutput_Off:(UInt8)dataByte2; // Flux Mode On Out Deck B Output Ch08 Note G#-1

// * Loop active *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_On:(MIKMIDICommand *)command; // Loop Active On Out Deck B Output Ch08 Note E4
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_On:(UInt8)dataByte2; // Loop Active On Out Deck B Output Ch08 Note E4
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_Off:(MIKMIDICommand *)command; // Loop Active On Out Deck B Output Ch08 Note E4
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckBOutput_Off:(UInt8)dataByte2; // Loop Active On Out Deck B Output Ch08 Note E4

// ***** Deck C *****

// * Seek position *
+ (BOOL)isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckCOutput_CC:(MIKMIDICommand *)command; // Seek Position (Deck Common) Out Deck C Output Ch09 CC 014
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckCOutput_CC:(UInt8)dataByte2; // Seek Position (Deck Common) Out Deck C Output Ch09 CC 014

// * FX 1 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_On:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck C Output Ch09 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_On:(UInt8)dataByte2; // FX Unit 1 On Out Deck C Output Ch09 Note D5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_Off:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck C Output Ch09 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckCOutput_Off:(UInt8)dataByte2; // FX Unit 1 On Out Deck C Output Ch09 Note D5

// * FX 2 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_On:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck C Output Ch09 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_On:(UInt8)dataByte2; // FX Unit 2 On Out Deck C Output Ch09 Note D#5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_Off:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck C Output Ch09 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckCOutput_Off:(UInt8)dataByte2; // FX Unit 2 On Out Deck C Output Ch09 Note D#5

// * FX 3 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_On:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck C Output Ch09 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_On:(UInt8)dataByte2; // FX Unit 3 On Out Deck C Output Ch09 Note E5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_Off:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck C Output Ch09 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckCOutput_Off:(UInt8)dataByte2; // FX Unit 3 On Out Deck C Output Ch09 Note E5

// * FX 4 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_On:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck C Output Ch09 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_On:(UInt8)dataByte2; // FX Unit 4 On Out Deck C Output Ch09 Note F5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_Off:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck C Output Ch09 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckCOutput_Off:(UInt8)dataByte2; // FX Unit 4 On Out Deck C Output Ch09 Note F5

// * Pre-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckCOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (L) Out Deck C Output Ch09 CC 033
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckCOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (L) Out Deck C Output Ch09 CC 033

// * Pre-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckCOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (R) Out Deck C Output Ch09 CC 034
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckCOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (R) Out Deck C Output Ch09 CC 034

// * Post-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckCOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (L) Out Deck C Output Ch09 CC 030
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckCOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (L) Out Deck C Output Ch09 CC 030

// * Post-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckCOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (R) Out Deck C Output Ch09 CC 031
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckCOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (R) Out Deck C Output Ch09 CC 031

// * Filter *
+ (BOOL)isTraktorMIDIMessage_Out_FilterAdjustOutDeckCOutput_CC:(MIKMIDICommand *)command; // Filter Adjust Out Deck C Output Ch09 CC 023
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FilterAdjustOutDeckCOutput_CC:(UInt8)dataByte2; // Filter Adjust Out Deck C Output Ch09 CC 023

// * Flux mode *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_On:(MIKMIDICommand *)command; // Flux Mode On Out Deck C Output Ch09 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_On:(UInt8)dataByte2; // Flux Mode On Out Deck C Output Ch09 Note G#-1
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_Off:(MIKMIDICommand *)command; // Flux Mode On Out Deck C Output Ch09 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckCOutput_Off:(UInt8)dataByte2; // Flux Mode On Out Deck C Output Ch09 Note G#-1

// * Loop active *
//  - On
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_On:(UInt8)dataByte2; // Loop Active On Out Deck C Output Ch09 Note E4
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_On:(MIKMIDICommand *)command; // Loop Active On Out Deck C Output Ch09 Note E4
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_Off:(MIKMIDICommand *)command; // Loop Active On Out Deck C Output Ch09 Note E4
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckCOutput_Off:(UInt8)dataByte2; // Loop Active On Out Deck C Output Ch09 Note E4

// ***** Deck D *****

// * Seek position *
+ (BOOL)isTraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckDOutput_CC:(MIKMIDICommand *)command; // Seek Position (Deck Common) Out Deck D Output Ch10 CC 014
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_SeekPositionDeckCommonOutDeckDOutput_CC:(UInt8)dataByte2; // Seek Position (Deck Common) Out Deck D Output Ch10 CC 014

// * FX 1 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_On:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck D Output Ch10 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_On:(UInt8)dataByte2; // FX Unit 1 On Out Deck D Output Ch10 Note D5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_Off:(MIKMIDICommand *)command; // FX Unit 1 On Out Deck D Output Ch10 Note D5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit1OnOutDeckDOutput_Off:(UInt8)dataByte2; // FX Unit 1 On Out Deck D Output Ch10 Note D5

// * FX 2 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_On:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck D Output Ch10 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_On:(UInt8)dataByte2; // FX Unit 2 On Out Deck D Output Ch10 Note D#5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_Off:(MIKMIDICommand *)command; // FX Unit 2 On Out Deck D Output Ch10 Note D#5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit2OnOutDeckDOutput_Off:(UInt8)dataByte2; // FX Unit 2 On Out Deck D Output Ch10 Note D#5

// * FX 3 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_On:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck D Output Ch10 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_On:(UInt8)dataByte2; // FX Unit 3 On Out Deck D Output Ch10 Note E5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_Off:(MIKMIDICommand *)command; // FX Unit 3 On Out Deck D Output Ch10 Note E5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit3OnOutDeckDOutput_Off:(UInt8)dataByte2; // FX Unit 3 On Out Deck D Output Ch10 Note E5

// * FX 4 *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_On:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck D Output Ch10 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_On:(UInt8)dataByte2; // FX Unit 4 On Out Deck D Output Ch10 Note F5
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_Off:(MIKMIDICommand *)command; // FX Unit 4 On Out Deck D Output Ch10 Note F5
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FxUnit4OnOutDeckDOutput_Off:(UInt8)dataByte2; // FX Unit 4 On Out Deck D Output Ch10 Note F5

// * Pre-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckDOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (L) Out Deck D Output Ch10 CC 033
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelLOutDeckDOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (L) Out Deck D Output Ch10 CC 033

// * Pre-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckDOutput_CC:(MIKMIDICommand *)command; // Deck Pre-Fader Level (R) Out Deck D Output Ch10 CC 034
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPreFaderLevelROutDeckDOutput_CC:(UInt8)dataByte2; // Deck Pre-Fader Level (R) Out Deck D Output Ch10 CC 034

// * Post-left levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckDOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (L) Out Deck D Output Ch10 CC 030
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelLOutDeckDOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (L) Out Deck D Output Ch10 CC 030

// * Post-right levels *
+ (BOOL)isTraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckDOutput_CC:(MIKMIDICommand *)command; // Deck Post-Fader Level (R) Out Deck D Output Ch10 CC 031
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_DeckPostFaderLevelROutDeckDOutput_CC:(UInt8)dataByte2; // Deck Post-Fader Level (R) Out Deck D Output Ch10 CC 031

// * Filter *
+ (BOOL)isTraktorMIDIMessage_Out_FilterAdjustOutDeckDOutput_CC:(MIKMIDICommand *)command; // Filter Adjust Out Deck D Output Ch10 CC 023
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FilterAdjustOutDeckDOutput_CC:(UInt8)dataByte2; // Filter Adjust Out Deck D Output Ch10 CC 023

// * Flux mode *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_On:(MIKMIDICommand *)command; // Flux Mode On Out Deck D Output Ch10 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_On:(UInt8)dataByte2; // Flux Mode On Out Deck D Output Ch10 Note G#-1
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_Off:(MIKMIDICommand *)command; // Flux Mode On Out Deck D Output Ch10 Note G#-1
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_FluxModeOnOutDeckDOutput_Off:(UInt8)dataByte2; // Flux Mode On Out Deck D Output Ch10 Note G#-1

// * Loop active *
//  - On
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_On:(MIKMIDICommand *)command; // Loop Active On Out Deck D Output Ch10 Note E4
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_On:(UInt8)dataByte2; // Loop Active On Out Deck D Output Ch10 Note E4
//  - Off
+ (BOOL)isTraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_Off:(MIKMIDICommand *)command; // Loop Active On Out Deck D Output Ch10 Note E4
+ (MIKMIDICommand *)TraktorMIDIMessage_Out_LoopActiveOnOutDeckDOutput_Off:(UInt8)dataByte2; // Loop Active On Out Deck D Output Ch10 Note E4

@end
