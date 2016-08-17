//
//  PTNavigationController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/18.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTNavigationController.h"


@interface PTNavigationController()
@property (nonatomic,strong) UIButton *backBtn;
@end

@interface PTNavigationController ()

@end

@implementation PTNavigationController

//只初始化一次
+ (void)initialize
{
    UIImage *background = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
    //设置导航条
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:background forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//-(UIStatusBarStyle)preferredStatusBarStyle {
//    return  UIStatusBarStyleLightContent;
//}

//拦截push进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //如果在控制器有设置，就可以让后面设置的按钮可以覆盖它
    [super pushViewController:viewController animated:animated];
}

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [_backBtn sizeToFit];
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self popViewControllerAnimated:YES];
        }];
    }
    return _backBtn;
}



@end
