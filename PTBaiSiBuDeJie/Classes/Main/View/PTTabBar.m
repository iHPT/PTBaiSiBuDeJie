//
//  PTTabBar.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTTabBar.h"
#import "PTPublishView.h"

@interface PTTabBar ()
@property (nonatomic,strong) UIButton *publish;
@end
@implementation PTTabBar

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //设置tabbar的全局属性
        UITabBarItem *appearance = [UITabBarItem appearance];
        [appearance setTitleTextAttributes:@{
                                             NSForegroundColorAttributeName : [UIColor darkGrayColor]}
                                  forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    }
    return self;
}

- (UIButton *)publish
{
    if (_publish == nil) {
        _publish = [[UIButton alloc] init];
        [_publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        _publish.size = _publish.currentBackgroundImage.size;
        [[_publish rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            PTPublishView *publishView = [PTPublishView publishView];
            publishView.frame = SCREEN_FRAME;
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            [keyWindow addSubview:publishView];
        }];
        [self addSubview:self.publish];
    }
    return _publish;
}

// 重新设置按钮的位置
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    NSInteger index = 0;
    CGFloat btnW = width / 5;
    CGFloat btnH = height;
    CGFloat btnY = 0;
    
    // 发布按钮位置
    self.publish.center = CGPointMake(width/2, height/2);
    // 遍历取出按钮
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:[UIControl class]] || view == self.publish) continue;
        
        CGFloat btnX = (index > 1 ? (index +1) : index) *btnW;
        
        view.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        index++;
    }
}

@end
