//
//  PTSquareTool.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/3/4.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTSquareTool : NSObject

/**
 *  回去广场方块数据
 *
 *  @param block 回调
 */
-(void)getSquareData:(void(^)(id json))block;

@end
