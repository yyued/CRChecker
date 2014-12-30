//
//  CRCounter.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRCounter.h"
#import <UIKit/UIKit.h>

static NSSet *customClassPrefix;
static NSMutableDictionary *counterDictionary;
static dispatch_queue_t counterQueue = NULL;

@implementation CRCounter

+ (void)load {
    counterDictionary = [NSMutableDictionary dictionary];
    customClassPrefix = nil;
    counterQueue = dispatch_queue_create("CRCheckerCounterQueue", NULL);
}

+ (void)addCustomClassPrefix:(NSString *)argPrefix {
    dispatch_sync(counterQueue, ^{
        if (customClassPrefix == nil) {
            [counterDictionary removeAllObjects];
            customClassPrefix = [NSSet set];
        }
        NSMutableSet *mutableCustoClassPrefix = [customClassPrefix mutableCopy];
        [mutableCustoClassPrefix addObject:argPrefix];
        customClassPrefix = [mutableCustoClassPrefix copy];
    });
}

+ (NSDictionary *)counterDictionary {
    return [counterDictionary copy];
}

+ (void)increaseWithClass:(Class)argClass {
    if ([self isCustomClass:argClass]) {
        return;
    }
    dispatch_async(counterQueue, ^{
        if (![self isBundleClass:argClass]) {
            return;
        }
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
    if ([self isCustomClass:argClass]) {
        return;
    }
    dispatch_async(counterQueue, ^{
        if (![self isBundleClass:argClass]) {
            return;
        }
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

+ (BOOL)isCustomClass:(Class)argClass {
    if (customClassPrefix != nil) {
        for (NSString *classPrefix in customClassPrefix) {
            NSString *className = NSStringFromClass(argClass);
            if (![className hasPrefix:classPrefix]) {
                return YES;
            }
        }
    }
    return NO;
}

+ (BOOL)isBundleClass:(Class)argClass {
    if ([[[[UIApplication sharedApplication] delegate] window] rootViewController] == nil) {
        return NO;
    }
    else {
        NSBundle *classBundle = [NSBundle bundleForClass:argClass];
        return classBundle == [NSBundle mainBundle];
    }
}

@end
