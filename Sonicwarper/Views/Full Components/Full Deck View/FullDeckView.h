//
//  FullDeckView.h
//  Sonicwarper
//
//  Created by Kevin Ng on 16/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullDeckView : UIView

@property (nonatomic, strong) NSString *label; // Must be 1-letter long
@property (nonatomic) float trackProgress; // Between 0.0 and 1.0
@property (nonatomic) BOOL trackEnding; // Set track color red
@property (nonatomic) BOOL fx1IsOn;
@property (nonatomic) BOOL fx2IsOn;
@property (nonatomic) BOOL fx3IsOn;
@property (nonatomic) BOOL fx4IsOn;
@property (nonatomic) float preLeftLevel; // Between 0.0 and 1.0
@property (nonatomic) float preRightLevel; // Between 0.0 and 1.0
@property (nonatomic) float postLeftLevel; // Between 0.0 and 1.0
@property (nonatomic) float postRightLevel; // Between 0.0 and 1.0
@property (nonatomic) float filterLevel; // Between 0.0 and 1.0
@property (nonatomic) BOOL fluxModeIsOn;
@property (nonatomic) BOOL loopActiveIsOn;

@end
