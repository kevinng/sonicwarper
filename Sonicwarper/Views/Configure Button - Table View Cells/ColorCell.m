//
//  ColorCell.m
//  Sonicwarper
//
//  Created by Kevin Ng on 28/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "ColorCell.h"
#import "UIColor+Sonicwarper.h"

@interface ColorCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;

@property (strong, nonatomic) NSArray *colors;

@end

@implementation ColorCell

- (void)awakeFromNib {
  [super awakeFromNib];
  
  self.colors = @[[UIColor SWEmpty],
                  [UIColor SWBlue],
                  [UIColor SWPurple],
                  [UIColor SWLilac],
                  [UIColor SWGreen],
                  [UIColor SWRed],
                  [UIColor SWYellow]];
}

- (void)setTitle:(NSString *)title {
  _title = title;
  self.titleLbl.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
  _subTitle = subTitle;
  self.subTitleLbl.text = subTitle;
}

- (void)setColor:(BSButtonColor)color {
  _color = color;
  self.subTitleLbl.textColor = self.colors[color];
}

@end
