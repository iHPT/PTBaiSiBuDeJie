//
//  PTRcommendDataTool.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/18.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTRcommendDataTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "PTCategoryModel.h"
#import "PTRecommendModel.h"
#import "SVProgressHUD.h"

static NSString *const categoryUrl = @"http://api.budejie.com/api/api_open.php";
@implementation PTRcommendDataTool

-(void)getCategoryData:(void(^)(NSArray *categories))block {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [HttpTool get:categoryUrl parameters:parameters success:^(id json) {
        
//        PTLog(@"getCategoryData===%@", json);
        NSArray *categories = [PTCategoryModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        block(categories);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
}

-(void)getRecommendDataWithID:(NSNumber *)Id block:(void (^)(NSArray *recommends, NSInteger totalPages))block {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = Id;
    
    [HttpTool get:categoryUrl parameters:parameters success:^(id json) {
        
        NSArray *recommends = [PTRecommendModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        NSInteger totalPages = [json[@"total_page"] integerValue];
        block(recommends, totalPages);
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
}


-(void)getRecommendDataWithID:(NSNumber *)Id currentPage:(NSInteger)currentPage block:(void (^)(NSArray *recommends))block {
     
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = Id;
    parameters[@"page"] = @(currentPage);
    [HttpTool get:categoryUrl parameters:parameters success:^(id json) {
//        PTLog(@"getRecommendDataWithID===%@", json);
        NSArray *recommends = [PTRecommendModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        block(recommends);

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
}

@end
