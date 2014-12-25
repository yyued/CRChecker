//
//  CRCounter.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRCounter.h"

static NSMutableDictionary *counterDictionary;
static dispatch_queue_t counterQueue = NULL;

@implementation CRCounter

+ (void)load {
    counterDictionary = [NSMutableDictionary dictionary];
    counterQueue = dispatch_queue_create("CRCheckerCounterQueue", NULL);
}

+ (NSDictionary *)counterDictionary {
    return [counterDictionary copy];
}

+ (void)increaseWithClass:(Class)argClass {
    dispatch_sync(counterQueue, ^{
        NSString *className = NSStringFromClass(argClass);
        NSNumber *countNumber = [counterDictionary valueForKey:className];
        if (countNumber == nil) {
            countNumber = @(1);
        }
        else {
            countNumber = @([countNumber integerValue]+1);
        }
        [counterDictionary setObject:countNumber forKey:className];
    });
}

+ (void)decreaseWithClass:(Class)argClass {
    dispatch_sync(counterQueue, ^{
        NSString *className = NSStringFromClass(argClass);
        NSNumber *countNumber = [counterDictionary valueForKey:className];
        if (countNumber == nil) {
            countNumber = @(0);
        }
        else {
            countNumber = @([countNumber integerValue]-1);
        }
        [counterDictionary setObject:countNumber forKey:className];
    });
}

@end
