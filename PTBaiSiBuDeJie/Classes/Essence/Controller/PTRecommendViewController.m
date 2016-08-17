//
//  PTRecommendViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/21.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTRecommendViewController.h"
#import "PTCommentViewController.h"
#import "PTModuleDataTool.h"
#import "MJRefresh.h"

@implementation PTRecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 监听评论点击通知
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"commentClick" object:nil] subscribeNext:^(NSNotification *noti) {
//        PTTopicFrame *topicFrame = noti.userInfo[@"topicFrame"];
//        PTCommentViewController * commentVC = [[PTCommentViewController alloc]init];
//        commentVC.topicFrame = topicFrame;
//        [self.navigationController pushViewController:commentVC animated:YES];
//    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentBtnClick:) name:@"commentClick" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)commentBtnClick:(NSNotification *)note
{
    PTTopicFrame *topicFrame = note.userInfo[@"topicFrame"];
    PTCommentViewController * commentVC = [[PTCommentViewController alloc]init];
    commentVC.topicFrame = topicFrame;
    [self.navigationController pushViewController:commentVC animated:YES];
}

/**
 *  重写数据获取方法
 */
// 获取最新数据
-(void)getNewData {
    self.page = 0; // 清空
    [self.topicFrames removeAllObjects];
    @weakify(self)
    [[PTModuleDataTool tool] getDataWithArrayType:TopicTypeAll parameterA:self.parameterA block:^(NSArray *topicsArray, NSString *maxtime) {
        @strongify(self)
        for (PTTopicModel *topic in topicsArray) {
            PTTopicFrame *topicFrame = [[PTTopicFrame alloc]init];
            topicFrame.topic = topic;
//            // 默认不隐藏右上角按钮，默认值就为NO
//            topicFrame.hiddingReportBtn = NO;
            [self.topicFrames addObject:topicFrame];
        }
        self.maxtime = maxtime;
        [self.tableView reloadData];
        
        // 停止刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

// 获取更多数据
-(void)getMoreData {
    // 计算页码
    NSInteger page = self.page + 1;
    @weakify(self)
    [[PTModuleDataTool tool] getDataWithMaxtime:self.maxtime page:@(page) TopicType:TopicTypeAll parameterA:self.parameterA block:^(NSArray *moreTopicsArray,NSString *maxtime) {
        @strongify(self)
        NSMutableArray *newArray = [NSMutableArray array];
        for (PTTopicModel *topic in moreTopicsArray) {
            PTTopicFrame *topicFrame = [[PTTopicFrame alloc]init];
            topicFrame.topic = topic;
            [newArray addObject:topicFrame];
        }
        [self.topicFrames addObjectsFromArray:newArray];
        [self.tableView reloadData];
        self.page = page;
        self.maxtime = maxtime;
        
        // 停止刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

@end
