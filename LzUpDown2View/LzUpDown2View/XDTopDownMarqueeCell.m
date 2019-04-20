//
//  XDTopDownTwoCell.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "XDTopDownMarqueeCell.h"

@interface XDTopDownMarqueeCell()<XDTopDownMarqueeMVDelegate>

@property (nonatomic, strong) XDTopDownMarqueeMV *cellOne;
@property (nonatomic, strong) XDTopDownMarqueeMV *cellTwo;
@property (nonatomic, strong) UIView * viewLine;
@end

@implementation XDTopDownMarqueeCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cellOne = [[XDTopDownMarqueeMV alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        _cellOne.delegate = self;
        _cellTwo = [[XDTopDownMarqueeMV alloc] initWithFrame:CGRectMake(0, frame.size.height/2.0, frame.size.width, frame.size.height/2)];
        _cellTwo.delegate = self;
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height/2.0, frame.size.width, 1)];
        _viewLine.backgroundColor = UIColor.lightGrayColor;
        
        [self addSubview:_cellOne];
        [self addSubview:_cellTwo];
        [self addSubview:_viewLine];

    }
    return self;
}


- (void)model1:(Person *)model1 model2:(Person *)model2{
    [_cellOne configModel:model1];
    [_cellTwo configModel:model2];
}


- (void)toSubmitPrice:(Person *)person{
    if (self.delegate && [self.delegate respondsToSelector:@selector(toSubmitFinalPrice:)]) {
        [self.delegate toSubmitFinalPrice:person];
    }
}



@end
