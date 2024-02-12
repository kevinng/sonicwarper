//
//  ColorCell.h
//  Sonicwarper
//
//  Created by Kevin Ng on 28/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BowswitchView.h"

@interface ColorCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic) BSButtonColor color;

@end
