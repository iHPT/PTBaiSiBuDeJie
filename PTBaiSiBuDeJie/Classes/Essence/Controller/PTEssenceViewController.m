//
//  PTEssenceViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTEssenceViewController.h"

@interface PTEssenceViewController ()
/** 左上角导航按钮 */
@property (nonatomic, strong) UIButton *naviLeftBtn;

@end

@implementation PTEssenceViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBarButtonItem];
}

/**
 *  设置导航栏按钮
 */
-(void)setBarButtonItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.naviLeftBtn];
}

- (UIButton *)naviLeftBtn{
    if (_naviLeftBtn == nil) {
        _naviLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_naviLeftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
        [_naviLeftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
        _naviLeftBtn.size = _naviLeftBtn.currentBackgroundImage.size;
        
        [[_naviLeftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            // 按钮点击事件处理
            PTLog(@"leftButtonClick");
        }];
    }
    return _naviLeftBtn;
}

@end

