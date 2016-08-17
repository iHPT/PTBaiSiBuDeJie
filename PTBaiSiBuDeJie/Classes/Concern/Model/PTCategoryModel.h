//
//  PTCategoryModel.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/18.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTCategoryModel : NSObject
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger count;


/** 用于缓存下载下来的对应类别数据 */
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger currentPage;
@end
