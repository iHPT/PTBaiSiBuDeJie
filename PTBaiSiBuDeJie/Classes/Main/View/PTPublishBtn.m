//
//  PTShowWordBtn.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/20.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTPublishBtn.h"

@implementation PTPublishBtn



- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
    
}

@end
