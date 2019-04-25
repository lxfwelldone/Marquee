//
//  TopDown2ScrollView.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "LzMarquee2.h"


@interface LzMarquee2()<LzMarqueeCell2Delegate>

@property (nonatomic, strong) LzMarqueeCell2 * cellOne;
@property (nonatomic, strong) LzMarqueeCell2 * cellTwo;
@property (nonatomic, assign) NSInteger dataIndex; //用来表示数据源取的位置
@property (strong, nonatomic) NSTimer *timer; //循环滚动
@property (nonatomic, strong) NSMutableArray *marrData;
@property (nonatomic, assign) Boolean showCellOne;
@end

@implementation LzMarquee2

//从xib加载,请自行实现
- (void)awakeFromNib{
    [super awakeFromNib];
//    [self initVaues];
}
//代码初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initVaues];
    }
    return self;
}

//初始化数据
- (void)initVaues{
    self.clipsToBounds = YES;
    _timerNumber = -1;
    _duration = -1;
    _dataIndex = 0;
    self.showCellOne = YES;
    self.marrData = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)setData:(NSMutableArray *)marrData{
    [self endTimer];
    [self.marrData removeAllObjects];
    [self.marrData addObjectsFromArray:marrData];
    if (self.marrData.count > 0) {
        [self addSubview:self.cellOne];
        [self showData];

        if (self.marrData.count > 2) {
            [self addSubview:self.cellTwo];
            [self startTimer];
        }
    }
}

//从下面向上滚动视图
- (void)scrollFromBottomToTop{
    UIView * viewToTop = nil;
    UIView * viewFromBottm = nil;

    if (self.showCellOne == YES) {
        viewFromBottm = self.cellTwo;
        viewToTop = self.cellOne;
    } else {
        viewToTop = self.cellTwo;
        viewFromBottm = self.cellOne;
    }

    self.showCellOne = !self.showCellOne;
    viewFromBottm.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:1 animations:^{
        viewFromBottm.frame = CGRectMake(0, 0, viewFromBottm.frame.size.width, viewFromBottm.frame.size.height);
        viewToTop.frame = CGRectMake(0, -viewToTop.frame.size.height, viewToTop.frame.size.width, viewToTop.frame.size.height);
    }];
    
    //  这里是处理数据源取出的逻辑。（重点）
    //    由于加2可能会大于count所以使用>=而不是==，防止count为奇数时崩溃
    if (_dataIndex >= self.marrData.count-2) {
        _dataIndex = 0;
    } else {
        _dataIndex +=2;
    }
    [self showData];
}

//设置显示数据
- (void)showData{
    Person * data1 = nil;
    Person * data2 = nil;

    data1 = [self.marrData objectAtIndex:_dataIndex];
    if (_dataIndex < self.marrData.count-1) {
        data2 = [self.marrData objectAtIndex:_dataIndex+1];
    }

    if (self.showCellOne == YES) {
        [self.cellOne model1:data1 model2:data2];
    } else {
        [self.cellTwo model1:data1 model2:data2];
    }

    [self layoutIfNeeded];
}

#pragma mark - 代理实现
- (void)returnFinalModel:(Person *)model{
    if (self.backModelBlock) {
        self.backModelBlock(model);
    }
}

#pragma mark -timer
- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(scrollFromBottomToTop) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)endTimer {
    if (_timer) {
        [_timer invalidate];
    }
    _timer = nil;
}


//计时器的间隔
- (NSTimeInterval)timerNumber{
    return _timerNumber>=0?_timerNumber:3;
}
//从下移动到显示位置的时间
- (NSTimeInterval)duration{
    return _duration>=0?_duration:1.0;
}



#pragma mark - 懒加载模块
- (LzMarqueeCell2 *)cellOne{
    if (!_cellOne) {
        _cellOne = [[LzMarqueeCell2 alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _cellOne.delegate = self;
    }
    return _cellOne;
}

- (LzMarqueeCell2 *)cellTwo{
    if (!_cellTwo) {
        _cellTwo = [[LzMarqueeCell2 alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        _cellTwo.delegate = self;
    }
    return _cellTwo;
}


@end
