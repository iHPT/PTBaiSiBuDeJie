//
//  PTRcommendDataTool.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/18.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTRcommendDataTool : NSObject

/**
 *  获取左边栏数据
 *
 *  @param block 回调
 */
-(void)getCategoryData:(void(^)(NSArray *categories))block;

/**
 *  获取右边栏数据，用于刷新数据，无需页码参数
 *
 *  @param Id    选中的ID
 *  @param block 回调
 */
-(void)getRecommendDataWithID:(NSNumber *)Id block:(void (^)(NSArray *recommends, NSInteger totalPages))block;

/**
 *  用于右边栏数据用于加载更多
 *
 *  @param Id          选中ID
 *  @param currentPage 当前页码
 *  @param block       回调
 */
-(void)getRecommendDataWithID:(NSNumber *)Id currentPage:(NSInteger)currentPage block:(void (^)(NSArray *recommends))block;

@end
