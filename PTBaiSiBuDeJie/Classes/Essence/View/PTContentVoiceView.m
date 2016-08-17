//
//  PTContentVoiceView.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/24.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTContentVoiceView.h"
#import "PTPictureController.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PTVociePlayerController.h"


@interface PTContentVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) PTVociePlayerController *voicePlayer;
@end
@implementation PTContentVoiceView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

+ (instancetype)voiceView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (void)showPicture {
    
    PTPictureController *showPicVc = [[PTPictureController alloc]init];
    showPicVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicVc animated:YES completion:nil];
}

- (void)setTopic:(PTTopicModel *)topic {
    
    _topic = topic;
    self.playCount.text = [NSString stringWithFormat:@"%ld次播放",(long)topic.playcount];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.middle_image]];
    self.playTime.text = [NSString stringWithFormat:@"%02ld:%02ld", topic.voicetime / 60, topic.voicetime % 60];
}

// 播放按钮
- (IBAction)playBtn:(UIButton *)sender {
    // 添加音频播放器
    self.playBtn.hidden = YES;
    self.voicePlayer = [[PTVociePlayerController alloc]initWithNibName:@"PTVociePlayerController" bundle:nil];
    self.voicePlayer.url = self.topic.voiceuri;
    self.voicePlayer.totalTime = self.topic.voicetime;
    self.voicePlayer.view.width = self.imageView.width;
    self.voicePlayer.view.y = self.imageView.height - self.voicePlayer.view.height;
    [self addSubview:self.voicePlayer.view];
}

// 重置
- (void)reset {
    [self.voicePlayer dismiss];
    [self.voicePlayer.view removeFromSuperview];
    self.voicePlayer = nil;
    self.playBtn.hidden = NO;
}

@end
