//
//  PTContentPictureView.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/23.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTTopicModel;
@interface PTContentPictureView : UIView
@property (nonatomic,strong) PTTopicModel *topic;
+ (instancetype)pictureView;

@end
