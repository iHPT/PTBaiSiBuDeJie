//
//  PTPictrueViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/21.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTPictrueViewController.h"
#import "PTModuleDataTool.h"
#import "MJRefresh.h"
#import "PTTopicFrame.h"

@interface PTPictrueViewController()

@end

@implementation PTPictrueViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

/**
 *  重写数据获取方法
 */
// 获取最新数据
-(void)getNewData {
    self.page = 0; // 清空
    [self.topicFrames removeAllObjects];
    @weakify(self)
    [[PTModuleDataTool tool] getDataWithArrayType:TopicTypePicture parameterA:self.parameterA block:^(NSArray *topicsArray, NSString *maxtime) {
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
    [[PTModuleDataTool tool] getDataWithMaxtime:self.maxtime page:@(page) TopicType:TopicTypePicture parameterA:self.parameterA block:^(NSArray *moreTopicsArray,NSString *maxtime) {
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
