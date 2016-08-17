//
//  PTTabBarViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTTabBarViewController.h"
#import "PTConcernViewController.h"
#import "PTEssenceViewController.h"
#import "PTLatestViewController.h"
#import "PTMeViewController.h"
#import "PTTabBar.h"
#import "PTNavigationController.h"

@interface PTTabBarViewController ()

@end

@implementation PTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialControllers];
    
    // 替换系统tabbar
    [self setValue:[[PTTabBar alloc] init] forKeyPath:@"tabBar"];
}

// 初始化子控制器
-(void)initialControllers {
    [self setupController:[[PTEssenceViewController alloc]init] image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    [self setupController:[[PTLatestViewController alloc]init] image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];
    [self setupController:[[PTConcernViewController alloc]init] image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
    [self setupController:[[PTMeViewController alloc]init] image:@"tabBar_me_icon"  selectedImage:@"tabBar_me_click_icon" title:@"我"];
}

// 设置控制器
-(void)setupController:(UIViewController *)childVc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    UIViewController *viewVc = childVc;
    viewVc.tabBarItem.image = [UIImage imageNamed:image];
    viewVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    viewVc.tabBarItem.title = title;
    PTNavigationController *navi = [[PTNavigationController alloc]initWithRootViewController:viewVc];
    [self addChildViewController:navi];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
