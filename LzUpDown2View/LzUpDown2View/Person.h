//
//  Person.h
//  LzUpDown2View
//
//  Created by mc on 2019/4/19.
//  Copyright © 2019年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;


- (instancetype)initWithName:(NSString *)name address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
