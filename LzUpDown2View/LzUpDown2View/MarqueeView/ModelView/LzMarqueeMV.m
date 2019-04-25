//
//  XDTopDownScrollCell.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "LzMarqueeMV.h"


@interface LzMarqueeMV()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *imgLogo;
@property (strong, nonatomic) UIImageView *imgAddress;
@property (strong, nonatomic) UILabel *lblName;
@property (strong, nonatomic) UILabel *lblAddress;
@property (strong, nonatomic) UIButton *btnPrice;
@property (strong, nonatomic) Person *model;
//给view自己添加一个点击手势。
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@end


@implementation LzMarqueeMV

//使用xib方式请自行实现
- (void)awakeFromNib{
    [super awakeFromNib];

}

//使用frame构造方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        [self initViews];
        [self layout:frame];
    }
    return self;
}

- (void)initViews{
    [self addSubview:self.imgLogo];
    [self addSubview:self.imgAddress];
    [self addSubview:self.lblName];
    [self addSubview:self.lblAddress];
    [self addSubview:self.btnPrice];
}

- (void)layout:(CGRect)frame{
    self.imgLogo.frame = CGRectMake(20, 10, 40, 40);
    self.lblName.frame = CGRectMake(70, 10, frame.size.width - 100, 20);
    self.imgAddress.frame = CGRectMake(70, 35, 20, 20);
    self.lblAddress.frame = CGRectMake(100, 35, frame.size.width - 130, 20);
    self.btnPrice.frame = CGRectMake(frame.size.width-70, (frame.size.height-30)/2, 60, 30);
}

- (void)configModel:(Person *)model{
    if (model) {
        self.model = model;
        self.hidden = NO;
        [self displayData];
        [self addGestureRecognizer:self.tap];
    }
    else{
        self.hidden = YES;
        [self removeGestureRecognizer:_tap];
    }
}

//显示数据
- (void)displayData{
    self.lblName.text = self.model.name;
    self.lblAddress.text = self.model.address;
}


//点击自身
- (void)clickOnMV{
//    方式一：使用delegate 反向传递点击的model
    if (self.model && self.delegate && [self.delegate respondsToSelector:@selector(returnModel:)]) {
        [self.delegate returnModel:self.model];
    }
//    方式二：使用block 反向传递点击的model
    if (self.clickOnModelBlock) {
        self.clickOnModelBlock(self.model);
    }
}


//UIGestureRecognizerDelegate 间父视图的手势传递到子视图，如果有button，需要设置enable=NO
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}


//给self添加单击事件
- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnMV)];
    }
    return _tap;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] init];
    }
    return _imgLogo;
}

- (UILabel *)lblName{
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.textColor = UIColor.blackColor;
        _lblName.font = [UIFont systemFontOfSize:14];
    }
    return _lblName;
}

- (UIImageView *)imgAddress{
    if (!_imgAddress) {
        _imgAddress = [[UIImageView alloc] init];
    }
    return _imgAddress;
}

- (UILabel *)lblAddress{
    if (!_lblAddress) {
        _lblAddress = [[UILabel alloc] init];
        _lblAddress.textColor = UIColor.lightGrayColor;
        _lblAddress.font = [UIFont systemFontOfSize:13];
    }
    return _lblAddress;
}

- (UIButton *)btnPrice{
    if (!_btnPrice) {
        _btnPrice = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPrice setTitle:@"去报价" forState:UIControlStateNormal];
        [_btnPrice setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_btnPrice setBackgroundColor:UIColor.orangeColor];
//        [_btnPrice addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        _btnPrice.layer.cornerRadius = 5;
        _btnPrice.layer.masksToBounds = YES;
        _btnPrice.enabled = NO;
        _btnPrice.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _btnPrice;
}


@end
