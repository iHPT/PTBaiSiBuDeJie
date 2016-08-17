//
//  PTCommenViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/7/10.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTCommenViewController.h"
#import "PTTopicCell.h"
#import "MJRefresh.h"
#import "PTCommentViewController.h"
#import "PTLatestViewController.h"

static NSString *const CellID = @"topic";

@interface PTCommenViewController ()
@end


@implementation PTCommenViewController

#pragma mark - getter and setter

- (NSMutableArray *)topicFrames{
    if (_topicFrames == nil) {
        _topicFrames = [NSMutableArray array];
        
    }
    return _topicFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
    
    [self setRefresh];
    
    // 刷新加载数据
    //    [self.tableView.mj_header beginRefreshing];
}

//设置tableView
-(void)setTableView{
    self.view.backgroundColor = BackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /** 注册cell */
    [self.tableView registerNib:[UINib nibWithNibName:@"PTTopicCell" bundle:nil] forCellReuseIdentifier:CellID];
}

// 设置刷新控件
-(void)setRefresh {
    /** 下拉刷新 */
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 首次进入界面即刷新加载数据
    [self.tableView.mj_header beginRefreshing];
    
    /** 上拉刷新 */
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}

#pragma mark - a参数
// 精华和新帖中请求参数不同，显示不同数据
- (NSString *)parameterA
{
    return [self.parentViewController isKindOfClass:[PTLatestViewController class]] ? @"newlist" : @"list";
}

// 获取最新数据
-(void)getNewData {
//    self.page = 0; // 清空
//    [self.topicFrames removeAllObjects];
//    @weakify(self)
//    [self.tool getDataWithArrayType:TopicTypeAll parameterA:self.parameterA block:^(NSArray *topicsArray, NSString *maxtime) {
//        @strongify(self)
//        for (PTTopicModel *topic in topicsArray) {
//            PTTopicFrame *topicFrame = [[PTTopicFrame alloc]init];
//            topicFrame.topic = topic;
////            // 默认不隐藏右上角按钮，默认值就为NO
////            topicFrame.hiddingReportBtn = NO;
//            [self.topicFrames addObject:topicFrame];
//        }
//        self.maxtime = maxtime;
//        [self.tableView reloadData];
//        
//        // 停止刷新
//        [self.tableView.mj_header endRefreshing];
//    }];
    return;
}

// 获取更多数据
-(void)getMoreData {
//    // 计算页码
//    NSInteger page = self.page + 1;
//    @weakify(self)
//    [self.tool getDataWithMaxtime:self.maxtime page:@(page) TopicType:TopicTypeAll parameterA:self.parameterA block:^(NSArray *moreTopicsArray,NSString *maxtime) {
//        @strongify(self)
//        NSMutableArray *newArray = [NSMutableArray array];
//        for (PTTopicModel *topic in moreTopicsArray) {
//            PTTopicFrame *topicFrame = [[PTTopicFrame alloc]init];
//            topicFrame.topic = topic;
//            [newArray addObject:topicFrame];
//        }
//        [self.topicFrames addObjectsFromArray:newArray];
//        [self.tableView reloadData];
//        self.page = page;
//        self.maxtime = maxtime;
//        
//        // 停止刷新
//        [self.tableView.mj_footer endRefreshing];
//    }];
    return;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.topicFrame = self.topicFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //计算文字高度
    PTTopicFrame *topicFrame = self.topicFrames[indexPath.row];
    return topicFrame.cellHeight;
}

#pragma mark - UITableViewDelegate
/**
 *  点击cell，跳转到评论控制器
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTTopicFrame *topicFrame = self.topicFrames[indexPath.row];
    PTCommentViewController * commentVC = [[PTCommentViewController alloc]init];
    // 隐藏右上角按钮
    topicFrame.hiddingReportBtn = YES;
    commentVC.topicFrame = topicFrame;
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

@end
