//
//  PTSquare.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/3/4.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTSquare : NSObject
/** id */
@property (nonatomic, copy) NSString *id;
/** 图片 */
@property (nonatomic, copy) NSString *icon;
/** 标题文字 */
@property (nonatomic, copy) NSString *name;
/** 链接 */
@property (nonatomic, copy) NSString *url;
/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
