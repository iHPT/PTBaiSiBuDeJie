//
//  PTContentVideoView.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/24.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTTopicModel;

@interface PTContentVideoView : UIView
@property (nonatomic, strong) PTTopicModel *topic;
+(instancetype)videoView;
- (void)reset;
@end
