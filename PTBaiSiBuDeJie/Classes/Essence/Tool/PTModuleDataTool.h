//
//  PTModuleDataTool.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/22.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PTModuleDataTool : NSObject
/**
 *  返回工具对象方法
 */
+ (PTModuleDataTool *)tool;

/**
 *  首次刷新（不需要传页码）
 *
 *  @param block 回调
 */
-(void)getDataWithArrayType:(TopicType)type parameterA:(NSString *)parameterA block:(void (^)(NSArray *topicsArray,id param))block;
/**
 *  加载更多数据（需要传页码）
 *
 *  @param maxtime 参数
 *  @param page    页码
 *  @param block   回调
 */
-(void)getDataWithMaxtime:(NSString *)maxtime page:(NSNumber *)page TopicType:(TopicType)type parameterA:(NSString *)parameterA block:(void (^)(NSArray *moreTopicsArray,id param))block;

/**
 *  加载最新的评论（最热和最新评论）
 *
 *  @param ID    ID
 *  @param block 回调
 */
-(void)getCommentsWithID:(NSString *)ID block:(void (^)(id json1,id json2))block;

/**
 *  加载更多最新评论
 *
 *  @param ID      ID
 *  @param page    页码
 *  @param lastcid 上次id
 *  @param block   回调
 */
-(void)getCommentsWithID:(NSString *)ID page:(NSInteger)page lastcid:(NSString *)lastcid block:(void (^)(id json,NSInteger total))block;

@end
