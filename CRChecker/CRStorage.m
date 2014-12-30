//
//  CRStorage.m
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/30.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRStorage.h"

static NSMutableArray *storageArray;

@implementation CRStorage

+ (void)load {
    storageArray = [NSMutableArray array];
}

+ (void)addObject:(id)argObject {
    CRStorageItem *item = [[CRStorageItem alloc] initWithCRChecker];
    item.theClass = [argObject class];
    item.theObject = argObject;
    [storageArray addObject:item];
}

+ (NSArray *)objectsForClass:(Class)argClass {
    NSMutableArray *objects = [NSMutableArray array];
    for (CRStorageItem *item in [storageArray copy]) {
        if (item.theClass == argClass) {
            [objects addObject:item];
        }
    }
    return [objects copy];
}

@end

@implementation CRStorageItem

@end