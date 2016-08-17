//
//  PTTopicModel.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/22.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTTopicModel.h"
#import "MJExtension.h"
#import "PTCommentModel.h"

@implementation PTTopicModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

@end
