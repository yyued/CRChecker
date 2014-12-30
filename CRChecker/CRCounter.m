//
//  CRCounter.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRCounter.h"

static NSMutableDictionary *counterDictionary;
static NSMutableSet *counterSet;
static dispatch_queue_t counterQueue = NULL;

@implementation CRCounter

+ (void)load {
    counterDictionary = [NSMutableDictionary dictionary];
    counterSet = [NSMutableSet set];
    counterQueue = dispatch_queue_create("CRCheckerCounterQueue", NULL);
}

+ (NSDictionary *)counterDictionary {
    return [counterDictionary copy];
}

+ (void)increaseWithObject:(id)argObject {
    if (![CRChecker isCustomPrefixClass:[argObject class]]) {
        return;
    }
    dispatch_async(counterQueue, ^{
        if (![CRChecker isBundleClass:[argObject class]]) {
            return;
        }
        NSString *className = NSStringFromClass([argObject class]);
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
    if (![CRChecker isCustomPrefixClass:argClass]) {
        return;
    }
    dispatch_async(counterQueue, ^{
        if (![CRChecker isBundleClass:argClass]) {
            return;
        }
        NSString *className = NSStringFromClass(argClass);
        NSNumber *countNumber = [counterDictionary valueForKey:className];
        if (countNumber != nil) {
            countNumber = @([countNumber integerValue]-1);
            [counterDictionary setObject:countNumber forKey:className];
        }
    });
}

@end
