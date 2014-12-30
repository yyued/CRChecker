//
//  NSObject+CRObjectStorager.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "NSObject+CRObjectStorager.h"
#import <UIKit/UIKit.h>

static NSMutableArray *storager;
static dispatch_queue_t storagerQueue;

@implementation CRObjectStorageItem

@end

@implementation NSObject (CRObjectStorager)

+ (void)load {
    storager = [NSMutableArray array];
    storagerQueue = dispatch_queue_create("CRCheckerStoragerQueue", NULL);
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

+ (NSArray *)objectsForClass:(Class)argClass {
    NSArray *storagerCopy = [storager copy];
    NSMutableArray *objects = [NSMutableArray array];
    for (CRObjectStorageItem *item in storagerCopy) {
        if (item.theClass == argClass) {
            [objects addObject:item];
        }
    }
    return [objects copy];
}

- (void)cr_storagerAddObject {
    __strong typeof(self) strongSelf = self;
    if (strongSelf != nil &&
        [[[[UIApplication sharedApplication] delegate] window] rootViewController] != nil &&
        [NSObject isBundleClass:[self class]] &&
        [strongSelf class] != [CRObjectStorageItem class]) {
        dispatch_async(storagerQueue, ^{
            CRObjectStorageItem *item = [[CRObjectStorageItem alloc] init];
            item.theClass = [self class];
            item.theObject = strongSelf;
            [storager addObject:item];
        });
    }
}

@end
