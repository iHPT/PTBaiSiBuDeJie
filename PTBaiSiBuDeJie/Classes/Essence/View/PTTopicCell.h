//
//  PTTalkCell.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/22.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTTopicFrame.h"

@interface PTTopicCell : UITableViewCell
@property (nonatomic, strong) PTTopicFrame *topicFrame;
+ (instancetype)cell;
@end
