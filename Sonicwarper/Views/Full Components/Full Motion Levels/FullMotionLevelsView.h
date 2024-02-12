//
//  FullMotionLevelsView.h
//  Sonicwarper
//
//  Created by Kevin Ng on 16/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullMotionLevelsView : UIView

@property (nonatomic) float diveRaiseValue; // Between -1.f to 1.f
@property (nonatomic) float rotateValue; // Between -1.f to 1.f
//@property (nonatomic) float steerValue; // Between -1.f to 1.f

@property (nonatomic) BOOL diveRaisePctIsDisabled;
@property (nonatomic) BOOL rotatePctIsDisabled;
//@property (nonatomic) BOOL steerPctIsDisabled;

@end
