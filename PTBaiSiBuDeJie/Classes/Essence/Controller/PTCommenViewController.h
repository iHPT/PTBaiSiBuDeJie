//
//  PTCommenViewController.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/7/10.
//  Copyright © 2016年 hpt. All rights reserved.
//  推荐、视频...控制器的重构

#import <UIKit/UIKit.h>

@interface PTCommenViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *topicFrames;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要的参数 */
@property (nonatomic, copy) NSString *maxtime;

- (NSString *)parameterA;

@end
