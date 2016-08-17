//
//  PTGuideView.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/6/21.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTGuideView.h"

@implementation PTGuideView


+(instancetype)guideView {
    
    return [[[NSBundle mainBundle]loadNibNamed:@"PTGuideView" owner:self options:nil] lastObject];
    
}


- (IBAction)closeBtn:(UIButton *)sender {

    [self removeFromSuperview];

}

@end
