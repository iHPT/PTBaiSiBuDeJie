//
//  PTLoginViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//  登录控制器中间部分分两块不同的view，设置frame动画切换显示

#import "PTLoginViewController.h"
#import <objc/runtime.h>

@interface PTLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIButton *QQBtn;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *tencentBtn;

@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UILabel *quickBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

/** 快速登录按钮左边线长 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftlineWidth;
/** 快速登录按钮右边线长 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightlineWidth;
/** 登录框至顶部距离 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
/** 登录框至左边距离 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLeft;

@end

@implementation PTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 判断是显示登录框还是注册框
    if (self.isForLogging) {
        self.textLeft.constant = 0;
    } else {
        self.textLeft.constant = -SCREEN_WIDTH;
        // 按钮设置为选中状态，显示“已有账号”
        self.registerBtn.selected = YES;
    }
    
    // 初始化隐藏按钮，动画方式显示，不是一开始就显示，后续仍执行动画
    self.QQBtn.hidden = YES;
    self.sinaBtn.hidden = YES;
    self.tencentBtn.hidden = YES;
    self.registerBtn.hidden = YES;
    self.forgetBtn.hidden = YES;
    self.quickBtn.hidden = YES;
    
    // 设置初始约束，以便后续修改执行动画
    self.topConstraint.constant = -250;
    self.leftlineWidth.constant = 0;
    self.rightlineWidth.constant = 0;

//    self.forgetBtn.layer.mask = [[CALayer alloc]init];
//    self.quickBtn.layer.mask = [[CALayer alloc]init];
//    self.registerBtn.layer.mask = [[CALayer alloc]init];
}

// 注册按钮
- (IBAction)registerBtn:(UIButton *)sender {
    if (self.textLeft.constant == 0) { // 显示注册界面
        // 登录框整个向左移出频幕，注册框移进频幕
        self.textLeft.constant = - self.view.width;
        sender.selected = YES;
    } else { // 显示登录界面
        // 登录框整个向右移进频幕，注册框移出频幕
        self.textLeft.constant = 0;
        sender.selected = NO;
    }
    // 动画执行登录框移动
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

// 需要的动画
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        // 关闭按钮旋转动画
        self.closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    self.topConstraint.constant = 70;
    self.leftlineWidth.constant = 103;
    self.rightlineWidth.constant = 103;
    
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        // 弹簧效果执行topConstraint，leftlineWidth，rightlineWidth变化
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 按键显示
        [UIView animateWithDuration:0.25 animations:^{
            self.registerBtn.hidden = NO;
            self.forgetBtn.hidden = NO;
        }];
        
        // 忘记密码动画
        [self setupAnimationWithStartRect:CGRectMake(0, 0, 0, CGRectGetHeight(self.forgetBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.forgetBtn.frame), CGRectGetHeight(self.forgetBtn.frame)) object:self.forgetBtn duration:0.25];
        // 注册按钮动画
        [self setupAnimationWithStartRect:CGRectMake(-(CGRectGetWidth(self.registerBtn.frame)), 0, 0, CGRectGetHeight(self.registerBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.registerBtn.frame), CGRectGetHeight(self.registerBtn.frame)) object:self.registerBtn duration:0.25];
    }];
    
    // 快速登录动画
    [UIView animateWithDuration:0.25 animations:^{
        self.quickBtn.hidden = NO;
    }];
    [self setupAnimationWithStartRect:CGRectMake(self.quickBtn.width/2, 0, 0, CGRectGetHeight(self.quickBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.quickBtn.frame), CGRectGetHeight(self.quickBtn.frame)) object:self.quickBtn duration:0.25];
    
    // 三个登录按钮的动画
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.QQBtn.transform = CGAffineTransformMakeScale(0.02, 0.02);
        self.sinaBtn.transform = CGAffineTransformMakeScale(0.02, 0.02);
        self.tencentBtn.transform = CGAffineTransformMakeScale(0.02, 0.02);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.QQBtn.hidden = NO;
                    self.sinaBtn.hidden = NO;
                    self.tencentBtn.hidden = NO;
                    self.QQBtn.transform = CGAffineTransformIdentity;
                    self.sinaBtn.transform = CGAffineTransformIdentity;
                    self.tencentBtn.transform = CGAffineTransformIdentity;
                } completion:nil];
        }];
}

// 按钮逐渐显示的动画
-(void)setupAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect object:(UIView *)view duration:(NSTimeInterval)duration {
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:startRect];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:endRect];
    
    CAShapeLayer *quickMask = [[CAShapeLayer alloc]init];
    quickMask.path = endPath.CGPath;
//    quickMask.strokeColor = [UIColor blueColor].CGColor;
    view.layer.mask = quickMask;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = duration;
    animation.beginTime = CACurrentMediaTime();
    animation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    [quickMask addAnimation:animation forKey:@"path"];
}

// 关闭控制器
- (IBAction)close:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
