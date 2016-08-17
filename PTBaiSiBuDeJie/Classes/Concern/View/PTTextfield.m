//
//  PTTextfield.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/20.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTTextfield.h"

@implementation PTTextfield

//成为第一响应者就会调用
-(BOOL)becomeFirstResponder {
    
    [super becomeFirstResponder];
    
    // 修改占位文字颜色
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    return YES;
}

//放弃第一响应者就会调用
-(BOOL)resignFirstResponder {
    
    [super resignFirstResponder];
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

    return YES;
}

@end
