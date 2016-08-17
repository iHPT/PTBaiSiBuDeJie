//
//  AppDelegate.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/17.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "AppDelegate.h"
#import "PTTabBarViewController.h"
#import "PTGuideView.h"
#import "SDWebImageManager.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建窗口显示根控制tabBarController
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [[PTTabBarViewController alloc]init];
    
    [self.window makeKeyAndVisible];
    
    // 显示指示视图在最前面（根据版本是否有更新来决定显示隐藏）
    [self showGuideView];
    
    // 监听网络状态
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
//                PTLog(@"未知网络");
                [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络设置！"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                PTLog(@"WIFI网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                PTLog(@"手机自带网络");
                break;
        }
    }];
    [mgr startMonitoring];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//当收到Received memory warning会调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //取消下载
    [mgr cancelAll];
    //清空缓存
    [mgr.imageCache clearMemory];

}

//是否显示引导页
-(void)showGuideView {
    
    //获得当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //沙盒版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"CFBundleShortVersionString"];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        PTGuideView *guideView = [PTGuideView guideView];
        guideView.frame = self.window.bounds;
        [self.window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleShortVersionString"];
        //马上写入沙盒
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}



@end
