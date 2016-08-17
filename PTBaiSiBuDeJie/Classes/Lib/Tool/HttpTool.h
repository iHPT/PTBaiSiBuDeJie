//
//  HttpTool.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/2/18.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
                                                                 failure:(void (^)(NSError *error))failure;

@end
