//
//  OnOffView.h
//  Sonicwarper
//
//  Created by Kevin Ng on 10/3/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnOffView : UIView

@property (nonatomic) BOOL isOn;

// Designated initializer
- (instancetype)initAsSmall:(BOOL)isSmall;

@end
