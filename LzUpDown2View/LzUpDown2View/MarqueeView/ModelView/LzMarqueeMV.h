//
//  XDTopDownScrollCell.h
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
NS_ASSUME_NONNULL_BEGIN

//协议实现返回点击model
@protocol LzMarqueeMVDelegate <NSObject>
- (void)returnModel:(Person *)model;
@end

@interface LzMarqueeMV : UIView

//使用协议
@property (nonatomic, weak) id<LzMarqueeMVDelegate> delegate;
//使用block实现点击返回model
@property (nonatomic, copy) void (^clickOnModelBlock)(Person *model);

//我这里只使用了此初始化方法来创建，需要其他方法请自行实现。
- (instancetype)initWithFrame:(CGRect)frame;
//设置model
- (void)configModel:(Person *)model;

@end

NS_ASSUME_NONNULL_END
