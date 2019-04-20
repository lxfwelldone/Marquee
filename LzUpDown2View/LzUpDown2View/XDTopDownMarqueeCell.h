//
//  XDTopDownTwoCell.h
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "XDTopDownMarqueeMV.h"
NS_ASSUME_NONNULL_BEGIN


@protocol XDTopDownMarqueeCellDelegate <NSObject>

- (void)toSubmitFinalPrice:(Person *)person;

@end

@interface XDTopDownMarqueeCell : UIView

@property (nonatomic, weak) id <XDTopDownMarqueeCellDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)model1:(Person *)model1 model2:(Person *)model2;

@end

NS_ASSUME_NONNULL_END
