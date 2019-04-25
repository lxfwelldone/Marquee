//
//  LzMarquee.h
//  LzUpDown2View
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzMarqueeCell.h"
#import "Person.h"
NS_ASSUME_NONNULL_BEGIN

@interface LzMarquee : UIView<UITableViewDelegate, UITableViewDataSource>

/**
 * table数据源
 */
@property (nonatomic, strong) NSMutableArray * datas;
/**
 * timer的间隔时间
 */
@property (nonatomic, assign) NSTimeInterval timerNumber;
/**
 * 滚动时间
 */
@property (nonatomic, assign) NSTimeInterval duration;
/**
 * 滚动多少cell
 */
@property (nonatomic, assign) NSInteger scrollCellCount;

- (instancetype)initWithFrame:(CGRect)frame datas:(NSMutableArray *)datas scrollCellCount:(NSInteger)scrollCellCount;
- (void)startTimer;
- (void)endTimer;
@end

NS_ASSUME_NONNULL_END
