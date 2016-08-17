//
//  NSString+PTTime.m
//  PTBaiSiBuDeJie
//
//  Created by Fay on 16/3/15.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "NSString+PTTime.h"

@implementation NSString (PTTime)
+ (NSString *)stringWithTime:(NSTimeInterval)time {
    
    NSInteger min = time / 60;
    NSInteger second = (NSInteger)time % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", min, second];
}
@end
