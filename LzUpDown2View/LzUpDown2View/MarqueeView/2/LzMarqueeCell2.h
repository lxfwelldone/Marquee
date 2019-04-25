//
//  XDTopDownTwoCell.h
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "LzMarqueeMV.h"

@protocol LzMarqueeCell2Delegate <NSObject>

- (void)returnFinalModel:(Person *)model;

@end

/**
 * 这是marquee中显示的cell，包括了2个数据模型。
 */
@interface LzMarqueeCell2 : UIView

@property (nonatomic, weak) id <LzMarqueeCell2Delegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)model1:(Person *)model1 model2:(Person *)model2;

@end
