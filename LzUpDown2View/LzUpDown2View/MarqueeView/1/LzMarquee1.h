//
//  LzMarquee1.h
//  LzUpDown2View
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzMarqueeMV.h"
#import "Person.h"
@interface LzMarquee1 : UIView

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

