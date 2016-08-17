//
//  PTSquareTool.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/3/4.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTSquareTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "PTSquare.h"

@implementation PTSquareTool

-(void)getSquareData:(void (^)(id))block {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [HttpTool get:BaseURL parameters:params success:^(id json) {
//        PTLog(@"json==%@", json);
        NSArray *squares = [PTSquare mj_objectArrayWithKeyValuesArray:json[@"square_list"]];
        NSMutableArray *effectiveSquares = [NSMutableArray array];
//        PTLog(@"%lu  %@", (unsigned long)squares.count, squares);
        for (PTSquare *square in squares) {
            if ([square.url hasPrefix:@"http://"]) {
                [effectiveSquares addObject:square];
            }
        }
        block(effectiveSquares);
        
    } failure:^(NSError *error) {
        nil;
    }];
    
}

@end
