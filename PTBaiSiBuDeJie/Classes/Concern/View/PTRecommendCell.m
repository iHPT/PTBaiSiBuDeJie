//
//  PTRecommendCell.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/19.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTRecommendCell.h"
#import "UIImageView+WebCache.h"

@interface PTRecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *concernCount;
@property (weak, nonatomic) IBOutlet UIView *separator;

@end
@implementation PTRecommendCell

- (void)awakeFromNib {
    // Initialization code
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(PTRecommendModel *)model {
    
    _model = model;
    if (model.isVip) {
        self.name.textColor = [UIColor redColor];
    }
    self.avatar.layer.cornerRadius = 21;
    self.avatar.clipsToBounds = YES;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name.text = model.screen_name;
    self.concernCount.text = [NSString stringWithFormat:@"%zd人关注",model.fans_count];
    
}
@end
