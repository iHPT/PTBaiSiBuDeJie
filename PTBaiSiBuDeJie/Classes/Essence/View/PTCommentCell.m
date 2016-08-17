//
//  PTCommentCell.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/7/1.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTCommentCell.h"
#import "UIImageView+WebCache.h"
#import "PTUserModel.h"

@interface PTCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *avartar;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playBtnTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBottom;

@end

@implementation PTCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//使cell一定成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}

//支持的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

-(void)setComment:(PTCommentModel *)comment {
    _comment = comment;
    
    CGFloat cellHeight = 0.0;
    
    [self.avartar setHeader:comment.user.profile_image];
    self.sex.image = [comment.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    if (comment.voiceuri.length) {
        self.playBtn.hidden = NO;
        [self.playBtn setTitle:[NSString stringWithFormat:@"%ld''", comment.voicetime] forState:UIControlStateNormal];
        
        cellHeight = CGRectGetMaxY(self.playBtn.frame) + self.contentTop.constant;
    } else {
        // 隐藏按钮，content顶部上移（间距+playBtn的高度）
        self.playBtn.hidden = YES;
        self.contentTop.constant = -(self.playBtn.height + self.playBtnTop.constant);
        
        cellHeight = CGRectGetMaxY(self.name.frame) + self.playBtnTop.constant;
    }
    self.content.text = comment.content;
    self.name.text = comment.user.username;
    self.like.text = [NSString stringWithFormat:@"%ld", (long)comment.like_count];
    
    CGFloat commentH = [self.content.text boundingRectWithSize:CGSizeMake(204, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    // 计算cell高度保存于模型中
    comment.cellHeight = cellHeight + commentH +  + self.contentBottom.constant;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
