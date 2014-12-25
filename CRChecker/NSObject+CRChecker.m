//
//  NSObject+CRChecker.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "NSObject+CRChecker.h"
#import "CRCounter.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSObject (CRChecker)

- (void)cr_dealloc {
    if ([UIApplication sharedApplication] != nil) {
        [CRCounter decreaseWithClass:[self class]];
    }
    [self cr_dealloc];
}

- (instancetype)cr_init {
    if ([UIApplication sharedApplication] != nil) {
        [CRCounter increaseWithClass:[self class]];
    }
    return [self cr_init];
}

@end
