//
//  NSObject+CRChecker.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "NSObject+CRChecker.h"
#import "CRCounter.h"
#import "CRStatusBar.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static CRStatusBar *statusBar;

@implementation NSObject (CRChecker)

+ (void)load {
    statusBar = [[CRStatusBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 20.0)];
}

- (void)cr_dealloc {
    if ([UIApplication sharedApplication] != nil) {
        [CRCounter decreaseWithClass:[self class]];
    }
    [self cr_dealloc];
}

- (instancetype)cr_init {
    if ([UIApplication sharedApplication] != nil) {
        if ([statusBar superview] == nil) {
            [[[[UIApplication sharedApplication] delegate] window] performSelector:@selector(addSubview:) withObject:statusBar afterDelay:10.0];
        }
        else {
            [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar];
        }
        [CRCounter increaseWithClass:[self class]];
    }
    return [self cr_init];
}

@end
