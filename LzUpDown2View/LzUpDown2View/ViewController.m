//
//  ViewController.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "ViewController.h"
#import "MyController.h"
@interface ViewController ()


@property (nonatomic, strong) UIButton * btnChange;
@property (nonatomic, strong) LzMarquee2 * marquee;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _marquee = [[LzMarquee2 alloc] initWithFrame:CGRectMake(0, 100, 414, 120)];
    self.btnChange.frame = CGRectMake(20, 250, 80, 40);
    
    typeof(self) weakSelf = self;

    _marquee.backModelBlock = ^(NSObject * _Nonnull model) {
        Person *p = (Person *)model;
        NSLog(@"点击了---姓名：%@，地址：%@", p.name, p.address);
        
        MyController * vc = [[MyController alloc] initWithNibName:@"MyController" bundle:nil];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [_marquee setData:[self getPersonsCount:3]];
    [self.view addSubview:_marquee];
    [self.view addSubview:_btnChange];
}


- (void)changeModels{
    [_marquee setData:[self getPersonsCount:4]];
}


- (UIButton *)btnChange {
    if (!_btnChange) {
        _btnChange = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnChange setTitle:@"切换数据源" forState:UIControlStateNormal];
        [_btnChange setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_btnChange addTarget:self action:@selector(changeModels) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnChange;
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
