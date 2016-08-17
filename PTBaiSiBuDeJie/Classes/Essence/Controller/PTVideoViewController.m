//
//  PTVideoViewController.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/21.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTVideoViewController.h"
#import "PTTopicFrame.h"
#import "KRVideoPlayerController.h"
#import "PTModuleDataTool.h"
#import "MJRefresh.h"

@interface PTVideoViewController()
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end


@implementation PTVideoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 监听播放按钮通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"playVideo" object:nil] subscribeNext:^(NSNotification *noti) {
        PTTopicModel *topic = noti.userInfo[@"Video"];
        [self playVideoWithURL:[NSURL URLWithString:topic.videouri]];
    }];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

/**
 *  重写数据获取方法
 */
// 获取最新数据
-(void)getNewData {
    self.page = 0; // 清空
    [self.topicFrames removeAllObjects];
    @weakify(self)
    [[PTModuleDataTool tool] getDataWithArrayType:TopicTypeVideo parameterA:self.parameterA block:^(NSArray *topicsArray, NSString *maxtime) {
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
    [[PTModuleDataTool tool] getDataWithMaxtime:self.maxtime page:@(page) TopicType:TopicTypeVideo parameterA:self.parameterA block:^(NSArray *moreTopicsArray,NSString *maxtime) {
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
