//
//  ButtonLook.h
//  Sonicwarper
//
//  Created by Kevin Ng on 15/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BowswitchView.h"

@interface ButtonLook : NSObject

@property (nonatomic) BSButtonColor color;
@property (nonatomic, strong) NSString *mainLabel;
@property (nonatomic, strong) NSString *smallLabel;

- (instancetype)initWithColor:(BSButtonColor)color
                    mainLabel:(NSString *)mainLabel
                   smallLabel:(NSString *)smallLabel;

@end
