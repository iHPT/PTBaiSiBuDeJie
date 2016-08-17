//
//  UIImage+PTCircle.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/3/3.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "UIImage+PTCircle.h"

@implementation UIImage (PTCircle)
- (UIImage *)circleImage {
    
    // NO透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return image;

    
}
@end
