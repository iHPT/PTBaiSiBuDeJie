//
//  PTMeCell.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/3/3.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTMeCell.h"

@interface PTMeCell ()
@end
@implementation PTMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;

}

@end
