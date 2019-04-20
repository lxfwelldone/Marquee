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

@protocol XDTopDownMarqueeMVDelegate <NSObject>

- (void)toSubmitPrice:(Person *)person;

@end

@interface XDTopDownMarqueeMV : UIView

@property (nonatomic, weak) id<XDTopDownMarqueeMVDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)configModel:(Person *)model;

@end

NS_ASSUME_NONNULL_END
