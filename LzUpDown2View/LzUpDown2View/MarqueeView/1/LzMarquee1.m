//
//  LzMarquee1.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "LzMarquee1.h"

@interface LzMarquee1()<LzMarqueeMVDelegate>

@property (nonatomic, strong) LzMarqueeMV * cellOne;
@property (nonatomic, strong) LzMarqueeMV * cellTwo;
@property (nonatomic, assign) NSInteger dataIndex; //用来表示数据源取的位置
@property (strong, nonatomic) NSTimer *timer; //循环滚动
@property (nonatomic, strong) NSMutableArray *marrData;
@property (nonatomic, assign) Boolean showCellOne;

@end

@implementation LzMarquee1

//设置数据源并开启计时器
-(void)setData:(NSMutableArray *)marrData{
    [self endTimer];
    [self.marrData removeAllObjects];
    [self.marrData addObjectsFromArray:marrData];
//    如果有一个元数据就创建第一个cell
    if (self.marrData.count > 0) {
        [self addSubview:self.cellOne];
        [self.cellOne configModel:[self.marrData objectAtIndex:0]];
//        如果大于一个元数据，就创建第二cell
        if (self.marrData.count > 2) {
            [self addSubview:self.cellTwo];
            [self startTimer];
        }
    } else {
        self.frame = CGRectZero;
    }
}

//从下面向上滚动视图
- (void)scrollFromBottomToTop{
    LzMarqueeMV * viewToTop = nil;
    LzMarqueeMV * viewFromBottm = nil;
    
    if (_showCellOne == YES) {
        viewFromBottm = self.cellTwo;
        viewToTop = self.cellOne;
    } else {
        viewToTop = self.cellTwo;
        viewFromBottm = self.cellOne;
    }
    
    self.showCellOne = !self.showCellOne;
    viewFromBottm.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    //  这里是处理数据源取出的逻辑。（重点）
    if (_dataIndex >= self.marrData.count-1) {
        _dataIndex = 0;
    }
    else {
        _dataIndex +=1;
    }
    
    [viewFromBottm configModel:[self.marrData objectAtIndex:_dataIndex]];
    
    [UIView animateWithDuration:self.duration animations:^{
        viewFromBottm.frame = CGRectMake(0, 0, viewFromBottm.frame.size.width, viewFromBottm.frame.size.height);
        viewToTop.frame = CGRectMake(0, -viewToTop.frame.size.height, viewToTop.frame.size.width, viewToTop.frame.size.height);
    }];


}


////设置显示数据
//- (void)showData{
//    Person * data1 = nil;
//    Person * data2 = nil;
//
//    data1 = [self.marrData objectAtIndex:_dataIndex];
//    if (_dataIndex < self.marrData.count-1) {
//        data2 = [self.marrData objectAtIndex:_dataIndex+1];
//    }
//
//    NSLog(@"----index:%ld------", _dataIndex);
//    if (self.showCellOne == YES) {
//        [self.cellOne configModel:data1];
//    } else {
//        [self.cellTwo configModel:data2];
//    }
//
//    [self layoutIfNeeded];
//}

#pragma 代理方法
- (void)returnModel:(Person *)model{
    if (self.backModelBlock) {
        self.backModelBlock(model);
    }
}


#pragma mark -timer
- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.timerNumber target:self selector:@selector(scrollFromBottomToTop) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)endTimer {
    if (_timer) {
        [_timer invalidate];
    }
    _timer = nil;
}


//初始化数据
- (void)initVaues{
    self.clipsToBounds = YES;
    _dataIndex = 0;
    _timerNumber = -1;
    _duration = -1;
    _showCellOne = YES;
    _marrData = [[NSMutableArray alloc] initWithCapacity:0];
}


//代码初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initVaues];
    }
    return self;
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
- (LzMarqueeMV *)cellOne{
    if (!_cellOne) {
        _cellOne = [[LzMarqueeMV alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _cellOne.delegate = self;
    }
    return _cellOne;
}

- (LzMarqueeMV *)cellTwo{
    if (!_cellTwo) {
        _cellTwo = [[LzMarqueeMV alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        _cellTwo.delegate = self;
    }
    return _cellTwo;
}

@end
