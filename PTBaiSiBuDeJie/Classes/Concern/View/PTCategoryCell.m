//
//  PTCategoryCell.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/19.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTCategoryCell.h"

@interface PTCategoryCell ()

@end
@implementation PTCategoryCell

- (void)awakeFromNib {
    // Initialization code
   
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor grayColor];
    self.textLabel.highlightedTextColor = GLOBALCOLOR(219, 21, 26,1);
    
    // 设置选中背景
    UIView *selectedView = [[UIView alloc]initWithFrame:self.frame];
    selectedView.backgroundColor = GLOBALCOLOR(245, 245, 245, 1);
    UIView *selectedIndicator = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.height)];
    selectedIndicator.backgroundColor = GLOBALCOLOR(219, 21, 26,1);
    [selectedView addSubview:selectedIndicator];
    
    self.selectedBackgroundView = selectedView;
}

-(void)setModel:(PTCategoryModel *)model {
    
    _model = model;
    self.textLabel.text = model.name;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
