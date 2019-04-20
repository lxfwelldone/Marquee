//
//  Person.m
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name address:(NSString *)address{
    if (self = [super init]) {
        self.name = name;
        self.address = address;
    }
    return self;
}

@end
