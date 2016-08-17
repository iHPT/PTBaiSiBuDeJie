//
//  PTVociePlayerController.h
//  PTBaiSiBuDeJie
//
//  Created by Fay on 16/7/15.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface PTVociePlayerController : UIViewController
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) NSInteger totalTime;
-(void)dismiss;
@end
