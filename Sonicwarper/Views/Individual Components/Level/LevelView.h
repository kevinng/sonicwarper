//
//  LevelView.h
//  Sonicwarper
//
//  Created by Kevin Ng on 29/1/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelView : UIView

// Initializer for level views used in master levels
- (instancetype)initAsMasterLevel;

// Initializer for level views used in tracks
- (instancetype)initAsTrackLevel;

// Level percentage
@property (nonatomic) float level; // between 0.0 and 1.0

// Level fill colors
- (void)addFillColor:(UIColor *)color
        startingAtLevel:(float)level; // between 0.0 and 1.0
- (void)removeFillColors;
- (void)setFillColorsToSpectrum;
- (void)setFillColorToBlue;

@end
