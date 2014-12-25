//
//  CRChecker.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRChecker.h"
#import "NSObject+CRChecker.h"
#import <objc/runtime.h>

@implementation CRChecker

+ (void)load {
    Method originalInitMethod =  class_getInstanceMethod([NSObject class], @selector(init));
    Method swizzInitMethod = class_getInstanceMethod([NSObject class], @selector(cr_init));
    method_exchangeImplementations(originalInitMethod, swizzInitMethod);
    
    Method originalDeallocMethod =  class_getInstanceMethod([NSObject class], NSSelectorFromString(@"dealloc"));
    Method swizzDeallocMethod = class_getInstanceMethod([NSObject class], @selector(cr_dealloc));
    method_exchangeImplementations(originalDeallocMethod, swizzDeallocMethod);
}

@end
