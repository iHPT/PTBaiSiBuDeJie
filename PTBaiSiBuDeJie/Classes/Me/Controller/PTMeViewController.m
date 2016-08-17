//
//  PTMeViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTMeViewController.h"
#import "PTMeCell.h"
#import "PTSquare.h"
#import "PTSquareTool.h"
#import "PTSquareFooterView.h"

static NSString *const meCellID = @"me";
static NSString *const squareCellID = @"square";
@interface PTMeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UIButton *coinBtn;
@property (nonatomic,strong) UIButton *moonBtn;
@property (nonatomic,strong) UIButton *settingBtn;

//@property (nonatomic,strong) PTSquareTool *tool;
@property (nonatomic,strong) UIButton *btnRight;
@property (nonatomic,strong) UIButton *btnLeft;
@property (nonatomic,strong) UIView *verticalLine;

@property (nonatomic,strong) UITableView *tableView;
@end

@implementation PTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setNaviItems];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//设置tableView
-(void)setupTableView {
    [self.tableView registerClass:[PTMeCell class] forCellReuseIdentifier:meCellID];
//    [self.tableView registerClass:[PTSquareCell class] forCellReuseIdentifier:squareCellID];
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(-24, 0, 10, 0);
    // 设置footer
    PTSquareFooterView *footer = [[PTSquareFooterView alloc]init];
    self.tableView.tableFooterView = footer;
//    self.tableView.tableFooterView.height = footer.height;
    
    //frame 刚开始是0
    [[RACObserve(self.tableView.tableFooterView, frame) distinctUntilChanged] subscribeNext:^(id x) {
        self.tableView.tableFooterView = self.tableView.tableFooterView;
    }];
//    PTLog(@"%@===", NSStringFromCGRect(self.tableView.tableFooterView.frame));
}

//设置导航按钮
-(void)setNaviItems {
    self.title = @"我的";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.coinBtn];
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc]initWithCustomView:self.settingBtn],
                                                [[UIBarButtonItem alloc]initWithCustomView:self.moonBtn]
                                                ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的身份";
        } else {
            cell.textLabel.text = @"本地视频";
        }
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 2) {
        [cell addSubview:self.btnLeft];
        [cell addSubview:self.btnRight];
        [cell addSubview:self.verticalLine];
    }
    return cell;
}

#pragma mark - getter and setter
- (UIButton *)coinBtn{
    if (_coinBtn == nil) {
        _coinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_coinBtn setBackgroundImage:[UIImage imageNamed:@"nav_coin_icon"] forState:UIControlStateNormal];
        [_coinBtn setBackgroundImage:[UIImage imageNamed:@"nav_coin_icon_click"] forState:UIControlStateHighlighted];
        _coinBtn.size = _coinBtn.currentBackgroundImage.size;
    }
    return _coinBtn;
}

- (UIButton *)moonBtn{
    if (_moonBtn == nil) {
        _moonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moonBtn setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
        [_moonBtn setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
        _moonBtn.size = _moonBtn.currentBackgroundImage.size;
    }
    return _moonBtn;
}

- (UIButton *)settingBtn{
    if (_settingBtn == nil) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
        _settingBtn.size = _settingBtn.currentBackgroundImage.size;
        
    }
    return _settingBtn;
}

- (UIButton *)btnLeft{
    if (_btnLeft == nil) {
        _btnLeft = [[UIButton alloc]init];
        _btnLeft.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
        [_btnLeft setTitle:@"#百思红人#" forState:UIControlStateNormal];
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnLeft setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [[_btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            PTLog(@"#百思红人#");
        }];
    }
    return _btnLeft;
}

- (UIButton *)btnRight{
    if (_btnRight == nil) {
        _btnRight = [[UIButton alloc]init];
        _btnRight.frame = CGRectMake(SCREEN_WIDTH/2, 0,SCREEN_WIDTH/2, 44);
        [_btnRight setTitle:@"#自拍#" forState:UIControlStateNormal];
        _btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnRight setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [[_btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            PTLog(@"#自拍#");
        }];
    }
    return _btnRight;
}

- (UIView *)verticalLine{
    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc]init];
        _verticalLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        _verticalLine.frame = CGRectMake(SCREEN_WIDTH/2, 2, 0.5, 40);
        
    }
    return _verticalLine;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        // 设置背景色
        _tableView.backgroundColor = BackgroundColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

//- (PTSquareTool *)tool{
//    if (_tool == nil) {
//        _tool = [[PTSquareTool alloc]init];
//    }
//    return _tool;
//}

@end
