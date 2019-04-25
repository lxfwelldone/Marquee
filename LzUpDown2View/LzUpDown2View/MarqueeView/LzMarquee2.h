//
//  TopDown2ScrollView.h
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "LzMarqueeCell2.h"

NS_ASSUME_NONNULL_BEGIN

@interface LzMarquee2 : UIView
/**
 * timer的间隔时间
 */
@property (nonatomic, assign) NSTimeInterval timerNumber;
/**
 * 滚动时间
 */
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, copy) void(^backModelBlock)(Person * model);
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setData:(NSMutableArray *)marrData;
- (void)startTimer;
- (void)endTimer;

@end

NS_ASSUME_NONNULL_END
