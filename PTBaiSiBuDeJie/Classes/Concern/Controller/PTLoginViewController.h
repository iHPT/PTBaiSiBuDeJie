//
//  PTLoginViewController.h
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//  登录控制器中间部分分两块不同的view，设置frame动画切换显示

#import <UIKit/UIKit.h>

@interface PTLoginViewController : UIViewController
/** 通过该属性确认是登录还是注册 */
@property (nonatomic, assign, getter=isForLogging) BOOL forLogging;
@end
