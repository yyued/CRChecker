//
//  CRChecker.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRChecker.h"
#import "CRCounter.h"
#import "CRDashBoardViewController.h"
#import "NSObject+CRChecker.h"
#import <objc/runtime.h>
#import "UIWindow+CRWindow.h"

@implementation CRChecker

+ (void)addCustomClassPrefix:(NSString *)argPrefix {
    [CRCounter addCustomClassPrefix:argPrefix];
}

+ (void)load {
    Method originalInitMethod =  class_getInstanceMethod([UIWindow class], @selector(makeKeyAndVisible));
    Method swizzInitMethod = class_getInstanceMethod([UIWindow class], @selector(cr_makeKeyAndVisible));
    method_exchangeImplementations(originalInitMethod, swizzInitMethod);
}

+ (void)presentDashBoardViewController {
    CRDashBoardViewController *dashBoardViewController = [[CRDashBoardViewController alloc] init];
    UINavigationController *dashBoardNavigationController = [[UINavigationController alloc]
                                                             initWithRootViewController:dashBoardViewController];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController]
     presentModalViewController:dashBoardNavigationController animated:YES];
}

@end
