//
//  CRCategories.m
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/30.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRCategories.h"
#import <objc/runtime.h>

@implementation NSObject (CRChecker)

- (instancetype)initWithCRChecker {
    if ([CRChecker isBundleClass:[self class]]) {
        self = [self initWithCRChecker];
        if (self) {
            [CRCounter increaseWithObject:self];
            [CRStorage addObject:self];
        }
        return self;
    }
    else {
        return [self initWithCRChecker];
    }
}

- (void)deallocWithCRChecker {
    [CRCounter decreaseWithClass:[self class]];
    [self deallocWithCRChecker];
}

@end

@implementation UIWindow (CRChecker)

+ (void)load {
    Method originalInitMethod =  class_getInstanceMethod([UIWindow class],
                                                         @selector(makeKeyAndVisible));
    Method swizzInitMethod = class_getInstanceMethod([UIWindow class],
                                                     @selector(makeKeyAndVisibleWithCRChecker));
    method_exchangeImplementations(originalInitMethod, swizzInitMethod);
}

- (void)makeKeyAndVisibleWithCRChecker {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalInitMethod =  class_getInstanceMethod([NSObject class],
                                                             @selector(init));
        Method swizzInitMethod = class_getInstanceMethod([NSObject class],
                                                         @selector(initWithCRChecker));
        method_exchangeImplementations(originalInitMethod, swizzInitMethod);
        
        Method originalDeallocMethod =  class_getInstanceMethod([NSObject class],
                                                                NSSelectorFromString(@"dealloc"));
        Method swizzDeallocMethod = class_getInstanceMethod([NSObject class],
                                                            @selector(deallocWithCRChecker));
        method_exchangeImplementations(originalDeallocMethod, swizzDeallocMethod);
    });
    return [self makeKeyAndVisibleWithCRChecker];
}

@end