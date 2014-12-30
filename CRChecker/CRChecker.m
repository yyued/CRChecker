//
//  CRChecker.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRChecker.h"
#import <objc/runtime.h>

static NSSet *customClassPrefix;

@implementation CRChecker

+ (void)load {
    customClassPrefix = nil;
}

+ (void)addCustomClassPrefix:(NSString *)argPrefix {
    if (customClassPrefix == nil) {
        customClassPrefix = [NSSet set];
    }
    NSMutableSet *mutableSet = [customClassPrefix mutableCopy];
    [mutableSet addObject:argPrefix];
    customClassPrefix = [mutableSet copy];
}

+ (BOOL)isBundleClass:(Class)argClass {
    return [NSBundle bundleForClass:argClass] == [NSBundle mainBundle];
}

+ (BOOL)isCustomPrefixClass:(Class)argClass {
    if (customClassPrefix == nil) {
        return YES;
    }
    NSString *className = NSStringFromClass(argClass);
    for (NSString *customClassPrefixItem in customClassPrefix) {
        if ([className hasPrefix:customClassPrefixItem]) {
            return YES;
        }
    }
    return NO;
}

+ (void)presentDashBoardViewController {
    CRDashBoardViewController *dashBoardViewController = [[CRDashBoardViewController alloc] init];
    UINavigationController *dashBoardNavigationController = [[UINavigationController alloc]
                                                             initWithRootViewController:dashBoardViewController];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController]
     presentModalViewController:dashBoardNavigationController animated:YES];
}

@end
