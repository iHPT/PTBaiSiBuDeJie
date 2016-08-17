//
//  PTSquareFooterView.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/7/4.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTSquareFooterView.h"
#import "PTSquareTool.h"
#import "PTSquareButton.h"
#import "PTWebviewController.h"

@interface PTSquareFooterView ()
@property (nonatomic, strong) PTWebviewController *webVc;
@end

@implementation PTSquareFooterView

- (PTWebviewController *)webVc
{
    if (_webVc == nil) {
        self.webVc = [[PTWebviewController alloc] init];
    }
    return _webVc;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createItems];
    }
    return self;
}

// 创建按钮
-(void)createItems {
    PTSquareTool *tool = [[PTSquareTool alloc]init];
    [tool getSquareData:^(NSArray *squareItems) {
        for (NSInteger i = 0; i < squareItems.count; i++) {
            PTSquareButton *button = [[PTSquareButton alloc]init];
            button.square = squareItems[i];
            [self addSubview:button];
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 一共4列
    NSInteger maxCols = 4;
    NSInteger count = self.subviews.count;
    CGFloat btnW = SCREEN_WIDTH / 4;
    CGFloat btnH = btnW;
    for (int i = 0; i < count; i++) {
        PTSquareButton *button = self.subviews[i];
        NSInteger col = i % maxCols; // 第几列
        NSInteger row = i / maxCols; // 第几行
        CGFloat btnX = col * btnW;
        CGFloat btnY = row * btnH;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(PTSquareButton *button) {
            self.webVc.url = button.square.url;
            self.webVc.title = button.square.name;
            // 由当前导航控制器push网页控制器
            UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
            [nav pushViewController:self.webVc animated:YES];
        }];
    }
    //算出footer的高度
    self.height = (count + maxCols - 1) / maxCols *  btnH;
}

@end
