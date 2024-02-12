//
//  TrackView.h
//  Sonicwarper
//
//  Created by Kevin Ng on 10/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackView : UIView

@property (nonatomic, strong) NSString *label; // Must be 1-letter long
@property (nonatomic) float trackProgress; // Between 0.0 and 1.0
@property (nonatomic) BOOL trackEnding; // Set track color red

@end
