//
//  PTSquareCell.m
//  PTBaiSiBuDeJie
//
//  Created by hpt on 16/3/4.
//  Copyright © 2016年 hpt. All rights reserved.
//

#import "PTSquareCell.h"
#import "PTSquareTool.h"

#import "PTSquare.h"
#import "PTSquareButton.h"

@interface PTSquareCell ()
@property(nonatomic,strong) UIView *horizenTopLine;
@property(nonatomic,strong) UIView *horizenBottomLine;
@property(nonatomic,strong) PTSquare *square;
@end

@implementation PTSquareCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createItems];
    }
    return self;
}

//创建items
-(void)createItems {
 
    //一共4列
    NSInteger maxCols = 4;
    CGFloat btnW = (SCREEN_WIDTH - 3) / 4;
    CGFloat btnH = btnW;
    PTSquareTool *tool = [[PTSquareTool alloc]init];
    PTLog(@"1");
    [tool getSquareData:^(NSArray *squareItems) {
        for (NSInteger i = 0; i < squareItems.count; i++) {
            PTSquareCell
            
            PTSquareButton *button = [[PTSquareButton alloc]init];
            button.square = squareItems[i];
            NSInteger col = i % maxCols;//第几列
            NSInteger row = i / maxCols;//第几行
            CGFloat btnX = col * btnW;
            CGFloat btnY = row * btnH;
            button.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [self.contentView addSubview:button];
        }
        //算出cell的高度
        self.height = (squareItems.count + maxCols - 1)/maxCols *  btnH;
        [self setNeedsDisplay];
        PTLog(@"2");
    }];
    PTLog(@"3");
    
}

@end
