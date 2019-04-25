//
//  LzMarquee.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "LzMarquee.h"
@interface LzMarquee()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) NSInteger dataIndex; //用来表示数据源取的位置
@property (strong, nonatomic) NSTimer *timer; //循环滚动
@property (nonatomic, assign) CGFloat cellH; //cell的高度
@end

@implementation LzMarquee

//计时器执行事件
- (void)scrollFromBottomToTop{
    typeof(self) weakSelf = self;

    _dataIndex += _scrollCellCount;
    CGRect rect = CGRectMake(0, _dataIndex/ _scrollCellCount*self.tableView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height);
    [UIView animateWithDuration:_duration animations:^{
        [weakSelf.tableView scrollRectToVisible:rect animated:YES];
    }];
    
    if (_dataIndex > self.datas.count-_scrollCellCount) {
        [UIView animateWithDuration:_duration animations:^{
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
        _dataIndex = 0;
    }
    
#pragma mark - 待解决问题
    /**
     * 1 无法控制滚动时间
     * 2 无法控制滚动动画效果
     * 3 最后滚动到开头的动画效果不好
     */
    
//    NSInteger page = self.tableView.contentOffset.y/(_cellH * _scrollCellCount);
//    if (page >= self.datas.count -_scrollCellCount) {
//        [UIView animateWithDuration:_duration animations:^{
//            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathWithIndex:weakSelf.datas.count - weakSelf.scrollCellCount] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//        }];
//        if (page == self.datas.count - _scrollCellCount -1) {
//            self.tableView.contentOffset = CGPointZero;
//            [UIView animateWithDuration:_duration animations:^{
//                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathWithIndex:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            }];
//        }
//    } else {
//        [UIView animateWithDuration:_duration animations:^{
//            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathWithIndex:weakSelf.datas.count - weakSelf.scrollCellCount] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//        }];
//    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count*100000*_scrollCellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LzMarqueeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LzMarqueeCellId" forIndexPath:indexPath];
    Person * model = [self.datas objectAtIndex:indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"----姓名：%@，地址：%@-----", model.name, model.address];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellH;
}

- (instancetype)initWithFrame:(CGRect)frame datas:(nonnull NSMutableArray *)datas scrollCellCount:(NSInteger)scrollCellCount{
    if (self = [super initWithFrame:frame]) {
        _timerNumber = 3;
        _duration = 1;
        _cellH = 60;
        _scrollCellCount = scrollCellCount;
        _dataIndex = 0;
        self.datas = [[NSMutableArray alloc] initWithCapacity:0];
        [self.datas addObjectsFromArray:datas];
        
        self.tableView.frame = CGRectMake(0, 0, frame.size.width, _cellH * _scrollCellCount);
        CGRect rect = frame;
        rect.size.height = self.tableView.frame.size.height;
        [self setFrame:rect];
        [self addSubview:self.tableView];
    }
    return self;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = _cellH;
        _tableView.rowHeight = UITableViewAutomaticDimension;

        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"LzMarqueeCell" bundle:nil] forCellReuseIdentifier:@"LzMarqueeCellId"];
    }
    return _tableView;
}


#pragma mark -timer
- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:_timerNumber target:self selector:@selector(scrollFromBottomToTop) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)endTimer {
    if (_timer) {
        [_timer invalidate];
    }
    _timer = nil;
}


@end
