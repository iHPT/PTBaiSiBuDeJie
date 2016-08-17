//
//  PTConcernViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTConcernViewController.h"
#import "PTFriendsRecommendViewController.h"
#import "PTLoginViewController.h"

@interface PTConcernViewController ()
@property (nonatomic,strong) UIButton *recommendBtn;
@end

@implementation PTConcernViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundColor;
    [self setupNavBar];
}

- (IBAction)loginBtn:(UIButton *)sender {
    PTLoginViewController *loginVc = [[PTLoginViewController alloc]init];
    loginVc.forLogging = YES;
    [self presentViewController:loginVc animated:YES completion:nil];
    
}

- (IBAction)registerBtn:(UIButton *)sender {
    PTLoginViewController *loginVc = [[PTLoginViewController alloc]init];
    loginVc.forLogging = NO;
    [self presentViewController:loginVc animated:YES completion:nil];
}

//设置导航条
- (void)setupNavBar
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.recommendBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)recommendBtn {
    if (_recommendBtn == nil) {
        _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recommendBtn setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
        [_recommendBtn setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
        _recommendBtn.size = _recommendBtn.currentBackgroundImage.size;
        [[_recommendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            PTFriendsRecommendViewController *recommendVc = [[PTFriendsRecommendViewController alloc]init];
            [self.navigationController pushViewController:recommendVc animated:YES];
        }];
        
    }
    return _recommendBtn;
}

@end
