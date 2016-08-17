//
//  PTTopicFrame.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/24.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTTopicModel.h"

@interface PTTopicFrame : NSObject
@property (nonatomic,strong)PTTopicModel *topic;
@property (assign, nonatomic) CGFloat cellHeight;
// 图片或视频或声音内容尺寸
@property (assign, nonatomic) CGRect  contentViewFrame;
/** 是否需要显示右上角按钮 */
@property (nonatomic, assign, getter=isHiddingReportBtn) BOOL hiddingReportBtn;
@end
