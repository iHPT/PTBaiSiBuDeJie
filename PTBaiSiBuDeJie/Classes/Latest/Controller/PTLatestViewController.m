//
//  PTLatestViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTLatestViewController.h"

@interface PTLatestViewController ()
@property (nonatomic, strong) UIButton *naviLeftBtn;
@property (nonatomic, strong) UIButton *naviRightBtn;
@end

@implementation PTLatestViewController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.naviRightBtn];
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

- (UIButton *)naviRightBtn{
    if (_naviRightBtn == nil) {
        _naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_naviRightBtn setBackgroundImage:[UIImage imageNamed:@"navigationButtonRandom"] forState:UIControlStateNormal];
        [_naviRightBtn setBackgroundImage:[UIImage imageNamed:@"navigationButtonRandomClick"] forState:UIControlStateHighlighted];
        _naviRightBtn.size = _naviRightBtn.currentBackgroundImage.size;
        
        [[_naviRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            // 按钮点击事件处理
            PTLog(@"rightButtonClick");
        }];
    }
    return _naviRightBtn;
}

@end
