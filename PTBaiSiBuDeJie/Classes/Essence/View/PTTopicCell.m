//
//  PTTalkCell.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/22.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTTopicCell.h"
#import "UIImageView+WebCache.h"
#import "PTContentPictureView.h"
#import "PTContentVideoView.h"
#import "PTContentVoiceView.h"
#import "PTUserModel.h"
#import "PTCommentViewController.h"

@interface PTTopicCell ()

@property (weak,nonatomic) IBOutlet UIImageView *avatar;
@property (weak,nonatomic) IBOutlet UILabel *name;
@property (weak,nonatomic) IBOutlet UILabel *creat_time;
@property (weak,nonatomic) IBOutlet UIButton *dingBtn;
@property (weak,nonatomic) IBOutlet UIButton *caiBtn;
@property (weak,nonatomic) IBOutlet UIButton *shareBtn;
@property (weak,nonatomic) IBOutlet UIButton *commenBtn;
@property (weak,nonatomic) IBOutlet UILabel *text;
@property (weak,nonatomic) IBOutlet UILabel *topCmtContentText;
@property (weak,nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (strong,nonatomic) PTContentPictureView *pictureView;
@property (strong,nonatomic) PTContentVideoView *videoView;
@property (strong,nonatomic) PTContentVoiceView *voiceView;
@end

@implementation PTTopicCell

// 从队列里面复用时调用
- (void)prepareForReuse {
    
    [super prepareForReuse];
    [_videoView reset];
    [_voiceView reset];
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PTTopicCell" owner:nil options:nil] firstObject];
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return [[self class] cell];
}

-(void)setTopicFrame:(PTTopicFrame *)topicFrame {
    _topicFrame = topicFrame;

    //  取出数据模型设置cell
    PTTopicModel *topic = topicFrame.topic;

    [self.avatar setHeader:topic.profile_image];
    self.name.text = topic.name;
    self.creat_time.text = topic.created_at;
    self.text.text = topic.text;
    
    // 右上角moreBtn是否隐藏
    if (topicFrame.isHiddingReportBtn) {
        self.moreBtn.hidden = YES;
    }

    [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",topic.ding] forState:UIControlStateNormal];
    [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",topic.cai] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",topic.repost] forState:UIControlStateNormal];
    [self.commenBtn setTitle:[NSString stringWithFormat:@"%ld",topic.comment] forState:UIControlStateNormal];

    // 处理最热评论
    if (topic.top_cmt) {
    self.topCmtView.hidden = NO;
    self.topCmtContentText.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
    self.topCmtView.hidden = YES;
    }

    // 声音，视频，图片选择其中一种
    if (topic.type == TopicTypePicture) {
    self.pictureView.topic = topic;
    self.pictureView.frame  = topicFrame.contentViewFrame;
    self.pictureView.hidden = NO;
    self.voiceView.hidden = YES;
    self.videoView.hidden = YES;
    } else if (topic.type == TopicTypeVideo) {
    self.videoView.topic = topic;
    self.videoView.frame  = topicFrame.contentViewFrame;
    self.videoView.hidden = NO;
    self.pictureView.hidden = YES;
    self.voiceView.hidden = YES;
    } else if (topic.type == TopicTypeVoice) {
    self.voiceView.topic = topic;
    self.voiceView.frame  = topicFrame.contentViewFrame;
    self.voiceView.hidden = NO;
    self.pictureView.hidden = YES;
    self.videoView.hidden = YES;
    } else {
    self.pictureView.hidden = YES;
    self.videoView.hidden = YES;
    self.voiceView.hidden = YES;
    }
}


// 重新设置尺寸
-(void)setFrame:(CGRect)frame {
    CGFloat inset = 10;
    frame.size.height -= inset;
    frame.origin.y += inset;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
}

// 更多按钮
- (IBAction)moreBtn:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:save];
    [alertController addAction:report];
    [alertController addAction:cancel];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

// 评论按钮
- (IBAction)commentBtn:(UIButton *)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topicFrame forKey:@"topicFrame"];
    
    // 发出评论点击通知，带有topicFrame参数
    [[NSNotificationCenter defaultCenter] postNotificationName:@"commentClick" object:nil userInfo:dic];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - getter and setter
- (PTContentPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [PTContentPictureView pictureView];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

-(PTContentVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [PTContentVideoView videoView];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (PTContentVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [PTContentVoiceView voiceView];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

@end
