//
//  ViewController.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblCode1;
@property (weak, nonatomic) IBOutlet UILabel *lblCode2;

@property (weak, nonatomic) IBOutlet UILabel *lblXib1;
@property (weak, nonatomic) IBOutlet UILabel *lblXib2;


@property (nonatomic, strong) LzMarquee1 * marquee1;
@property (nonatomic, strong) LzMarquee2 * marquee2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCodeMarquee1];
    [self addCodeMarquee2];
    [self addLzMarquee];

}

- (void)addLzMarquee{
    LzMarquee * marquee = [[LzMarquee alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lblXib1.frame), self.view.frame.size.width, 0) datas:[self getPersonsCount:12] scrollCellCount:3];
    marquee.timerNumber = 2;
    [self.view addSubview:marquee];
    [marquee startTimer];
}

- (void)addCodeMarquee1{
    _marquee1 = [[LzMarquee1 alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lblCode1.frame), self.view.frame.size.width, 60)];
    _marquee1.duration = 1;
    _marquee1.timerNumber = 1;
    typeof(self) weakSelf = self;
    _marquee1.backModelBlock = ^(NSObject * _Nonnull model) {
        Person *p = (Person *)model;
        NSString *message = [NSString stringWithFormat:@"姓名：%@, 地址：%@", p.name, p.address];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"点击结果" message:message preferredStyle:UIAlertControllerStyleAlert];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    [_marquee1 setData:[self getPersonsCount:10]];
    [self.view addSubview:_marquee1];
    
}


- (void)addCodeMarquee2{
    _marquee2 = [[LzMarquee2 alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lblCode2.frame), self.view.frame.size.width, 120)];
    typeof(self) weakSelf = self;
    _marquee2.backModelBlock = ^(NSObject * _Nonnull model) {
        Person *p = (Person *)model;
        NSString *message = [NSString stringWithFormat:@"姓名：%@, 地址：%@", p.name, p.address];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"点击结果" message:message preferredStyle:UIAlertControllerStyleAlert];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    [_marquee2 setData:[self getPersonsCount:8]];
    [self.view addSubview:_marquee2];
}



- (NSMutableArray *)getPersonsCount:(NSInteger)doubleCount{
    NSMutableArray * marr = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i< doubleCount; i++) {
        Person * p = [[Person alloc] initWithName:[NSString stringWithFormat:@"name--%d", i] address:[NSString stringWithFormat:@"address--%d", i]];
        [marr addObject:p];
    }
    return marr;
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
