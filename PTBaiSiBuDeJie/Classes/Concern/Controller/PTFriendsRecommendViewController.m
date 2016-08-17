//
//  PTFriendsRecommendViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/18.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTFriendsRecommendViewController.h"
#import "PTRcommendDataTool.h"
#import "PTCategoryModel.h"
#import "PTCategoryCell.h"
#import "PTRecommendCell.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

static NSString *const categoryID = @"category";
static NSString *const recommendID = @"recommend";

@interface PTFriendsRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *categoryTable;
@property (nonatomic, weak) IBOutlet UITableView *recommendTable;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableArray *recommends;
@property (nonatomic, strong) PTRcommendDataTool *tool;

// 当前推荐关注页数
@property (nonatomic, assign) NSInteger currentPage;
// 推荐关注总页数
@property (nonatomic, assign) NSInteger totalPages;

@end

@implementation PTFriendsRecommendViewController

#pragma mark - getter and setter
- (NSArray *)categories
{
    if (_categories == nil) {
        self.categories = [[NSArray alloc] init];
    }
    return _categories;
}
- (NSMutableArray *)recommends
{
    if (_recommends == nil) {
        self.recommends = [[NSMutableArray alloc] init];
    }
    return _recommends;
}

- (PTRcommendDataTool *)tool
{
    if (_tool == nil) {
        _tool = [[PTRcommendDataTool alloc]init];
    }
    return _tool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = BackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupTableView];
    
    [self setupRefreshView];

    // 获得左侧分类数据
    [self.tool getCategoryData:^(NSArray *categories) {
        self.categories = categories;
        [self.categoryTable reloadData];
    }];
}

// 设置tableView
-(void)setupTableView {
    self.categoryTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categoryTable.backgroundColor = BackgroundColor;
    
    self.recommendTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.recommendTable.rowHeight = 70;
//    // 去掉不要的cell
//    self.categoryTable.tableFooterView = [[UIView alloc]init];
    
    // 注册tableView
    [self.categoryTable registerNib:[UINib nibWithNibName:@"PTCategoryCell" bundle:nil] forCellReuseIdentifier:categoryID];
    [self.recommendTable registerNib:[UINib nibWithNibName:@"PTRecommendCell" bundle:nil] forCellReuseIdentifier:recommendID];
}

-(void)setupRefreshView {
    self.recommendTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    [self.recommendTable.mj_header beginRefreshing];
    self.recommendTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

// 加载最新数据
-(void)loadNew {
    self.currentPage = 1;
    if (self.recommends.count) {
        [self.recommends removeAllObjects]; // 第一次recommends为nil，会报错
    }
    // 获取对应分类的推荐关注数据
    PTCategoryModel *category = self.categories[self.categoryTable.indexPathForSelectedRow.row];
    [self.tool getRecommendDataWithID:@(category.id) block:^(NSArray *recommends, NSInteger totalPages) {
        [self.recommends addObjectsFromArray:recommends];
        self.totalPages = totalPages;
//        [category.users addObjectsFromArray:recommends];
        // 刷新数据
        [self.recommendTable reloadData];
        [self.recommendTable.mj_header endRefreshing];
    }];
}

// 加载更多数据
-(void)loadMore {
    if (self.currentPage >= self.totalPages) return;
    
    if (self.currentPage < self.totalPages) {
        self.currentPage += 1;
        
        PTCategoryModel *model = self.categories[self.categoryTable. indexPathForSelectedRow.row];
        [self.tool getRecommendDataWithID:@(model.id) currentPage:self.currentPage block:^(NSArray *recommends) {
            [self.recommends addObjectsFromArray:recommends];
            [self.recommendTable reloadData];
            [self.recommendTable.mj_footer endRefreshing];
        }];
    }
}

#pragma mark  - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 控制器只设置为categoryTable的代理
    // 刷新获取右边recommends数据
    [self.recommendTable.mj_header beginRefreshing];
    
    PTCategoryModel *model = self.categories[indexPath.row];
    [self.tool getRecommendDataWithID:@(model.id) currentPage:1 block:^(NSArray *recommends) {
        [self.recommends addObjectsFromArray:recommends];
        [self.recommendTable reloadData];
        [self.recommendTable.mj_header endRefreshing];
    }];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    PTLog(@"%ld---%ld", (long)self.totalPages, (long)self.currentPage);
    // 设置是否需隐藏下拉刷新
    self.recommendTable.mj_footer.hidden = (self.totalPages == self.currentPage);
    
    if (tableView == self.categoryTable) {
        return self.categories.count;
    }
    
    return self.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTable) {
        PTCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.model = self.categories[indexPath.row];
        [self.categoryTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        return cell;
    } else {
        PTRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendID];
        cell.model = self.recommends[indexPath.row];
        return cell;
    }
}

@end
