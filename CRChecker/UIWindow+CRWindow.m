//
//  UIWindow+CRWindow.m
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/30.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "UIWindow+CRWindow.h"
#import <objc/runtime.h>
#import "NSObject+CRChecker.h"

@implementation UIWindow (CRWindow)

- (void)cr_makeKeyAndVisible {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIWindow swizzlingMethod];
    });
    return [self cr_makeKeyAndVisible];
}

+ (void)swizzlingMethod {
    Method originalInitMethod =  class_getInstanceMethod([NSObject class], @selector(init));
    Method swizzInitMethod = class_getInstanceMethod([NSObject class], @selector(initWithCRChecker));
    method_exchangeImplementations(originalInitMethod, swizzInitMethod);
    
    Method originalDeallocMethod =  class_getInstanceMethod([NSObject class], NSSelectorFromString(@"dealloc"));
    Method swizzDeallocMethod = class_getInstanceMethod([NSObject class], @selector(cr_dealloc));
    method_exchangeImplementations(originalDeallocMethod, swizzDeallocMethod);
}

@end
