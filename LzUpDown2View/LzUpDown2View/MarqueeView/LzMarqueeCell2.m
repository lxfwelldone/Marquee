//
//  XDTopDownTwoCell.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "LzMarqueeCell2.h"

@interface LzMarqueeCell2()<LzMarqueeMVDelegate>

@property (nonatomic, strong) LzMarqueeMV *cellOne;
@property (nonatomic, strong) LzMarqueeMV *cellTwo;
@property (nonatomic, strong) UIView * viewLine;
@end

@implementation LzMarqueeCell2

//使用xib布局 请自行实现
- (void)awakeFromNib{
    [super awakeFromNib];
//    这里实现xib写法
}

//使用frame
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cellOne = [[LzMarqueeMV alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        _cellOne.delegate = self;
        _cellTwo = [[LzMarqueeMV alloc] initWithFrame:CGRectMake(0, frame.size.height/2.0, frame.size.width, frame.size.height/2)];
        _cellTwo.delegate = self;
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height/2.0, frame.size.width, 1)];
        _viewLine.backgroundColor = UIColor.lightGrayColor;
        
        [self addSubview:_cellOne];
        [self addSubview:_cellTwo];
        [self addSubview:_viewLine];

    }
    return self;
}

//给MV传值
- (void)model1:(Person *)model1 model2:(Person *)model2{
    [_cellOne configModel:model1];
    [_cellTwo configModel:model2];
}

//实现代理方法
- (void)returnModel:(Person *)model{
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnFinalModel:)]) {
        [self.delegate returnFinalModel:model];
    }
}



@end
