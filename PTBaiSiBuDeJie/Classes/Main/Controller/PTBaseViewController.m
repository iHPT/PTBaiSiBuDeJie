//
//  PTBaseViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/8/8.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTBaseViewController.h"
#import "PTConcernViewController.h"
#import "PTRecommendViewController.h"
#import "PTVideoViewController.h"
#import "PTPictrueViewController.h"
#import "PTTalkViewController.h"
#import "PTVocieViewController.h"
#import "ReactiveCocoa.h"


@interface PTBaseViewController () <UIScrollViewDelegate>
/** 分类导航 */
@property (nonatomic,strong) UIView *titleView;
/** 选中标记 */
@property (nonatomic,strong) UIView *btnIndicator;
/** 选中按钮 */
@property (nonatomic,  weak) UIButton *seletedBtn;
/** 所有控制器的scrollView */
@property (nonatomic,strong) UIScrollView *scrollview;
@end

@implementation PTBaseViewController

#pragma mark - getter and setter
- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc]init];
        _scrollview.frame = self.view.bounds;
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES; // 分页
        
        _scrollview.contentSize = CGSizeMake(_scrollview.width * self.childViewControllers.count , 0);
        
        // 添加第一个控制器的view
        [self scrollViewDidEndScrollingAnimation:self.scrollview];
    }
    return _scrollview;
}

- (UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc]init];
        _titleView.frame = CGRectMake(0, 64, self.view.width, 35);
        _titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    }
    return _titleView;
}

- (UIView *)btnIndicator{
    if (_btnIndicator == nil) {
        _btnIndicator = [[UIView alloc]init];
        _btnIndicator.backgroundColor = [UIColor redColor];
        
        _btnIndicator.height = 2;
        _btnIndicator.y = CGRectGetMaxY(self.titleView.bounds) - _btnIndicator.height;
        [self.titleView addSubview:_btnIndicator];
    }
    return _btnIndicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BackgroundColor;
    [self setTitleView];
    [self setupChildViewControllers];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.titleView];
    [self setupTitleBtn];
    [self.titleView addSubview:self.btnIndicator];
    
}

/**
 *  设置子控制器
 */
-(void)setupChildViewControllers {
    /** 推荐 */
    PTRecommendViewController *allVc = [[PTRecommendViewController alloc]init];
    [self addChildViewController:allVc];
    
    /** 视频 */
    PTVideoViewController *videoVc = [[PTVideoViewController alloc]init];
    [self addChildViewController:videoVc];
    
    /** 图片 */
    PTPictrueViewController *picVc = [[PTPictrueViewController alloc]init];
    [self addChildViewController:picVc];
    
    /** 声音*/
    PTVocieViewController *voiceVc = [[PTVocieViewController alloc]init];
    [self addChildViewController:voiceVc];
    
    /** 段子 */
    PTTalkViewController *talkVc = [[PTTalkViewController alloc]init];
    [self addChildViewController:talkVc];
}

/**
 *  设置导航栏
 */
-(void)setTitleView {
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

/**
 *  设置titleView按钮
 */
-(void)setupTitleBtn {
    NSArray *titles = @[@"推荐",@"视频",@"图片",@"声音",@"段子"];
    NSInteger count = titles.count;
    CGFloat btnH = self.titleView.height - 2;
    CGFloat btnW = self.titleView.width / count;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        CGFloat btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.titleView addSubview:btn];
        
        //默认选中第一个按钮
        if (btn.tag == 0) {
            btn.enabled = NO;
            self.seletedBtn = btn;
            [btn.titleLabel sizeToFit];
            
            self.btnIndicator.width = btn.titleLabel.width;
            self.btnIndicator.centerX = btn.centerX;
        }
    }
}

/**
 *  titleView按钮点击事件
 */
-(void)btnClick:(UIButton *)btn {
    //按钮状态
    self.seletedBtn.enabled = YES;
    btn.enabled = NO;
    self.seletedBtn = btn;
    
    //指示器动画
    [UIView animateWithDuration:0.2 animations:^{
        //必须在这里才设置指示器的宽度，要不宽度会计算错误
        self.btnIndicator.width = btn.titleLabel.width;
        self.btnIndicator.centerX = btn.centerX;
    }];
    
    //控制器view的滚动
    CGPoint offset = self.scrollview.contentOffset;
    offset.x = btn.tag * self.scrollview.width;
    [self.scrollview setContentOffset:offset animated:YES];
}


#pragma  mark - UIScrollViewDelegate
/**
 *  结束滚动时动画
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //计算当前控制器View索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *viewVc = self.childViewControllers[index];
    viewVc.view.x = scrollView.contentOffset.x;
    viewVc.view.y = 0;
    viewVc.view.height = scrollView.height;
    //设置内边距
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    viewVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    viewVc.tableView.scrollIndicatorInsets = viewVc.tableView.contentInset;
    
    [scrollView addSubview:viewVc.view];
}

/**
 *  滚动减速时
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击titleView按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self btnClick:self.titleView.subviews[index]];
    
}

@end
