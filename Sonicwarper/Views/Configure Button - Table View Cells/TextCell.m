//
//  TextCell.m
//  Sonicwarper
//
//  Created by Kevin Ng on 28/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "TextCell.h"

@interface TextCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;

@end

@implementation TextCell

- (void)setTitle:(NSString *)title {
  _title = title;
  self.titleLbl.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
  _subTitle = subTitle;
  self.subTitleLbl.text = subTitle;
}

@end
