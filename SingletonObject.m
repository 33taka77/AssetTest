//
//  SingletonObject.m
//  AssetLibTest
//
//  Created by 相澤 隆志 on 2014/03/04.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import "SingletonObject.h"

@implementation SingletonObject

static SingletonObject* gInstance = nil;
+ (SingletonObject*)initObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gInstance = [[SingletonObject alloc] init];
    });
    return gInstance;
}


@end
