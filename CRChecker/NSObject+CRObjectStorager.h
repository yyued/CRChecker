//
//  NSObject+CRObjectStorager.h
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CRObjectStorager)

+ (NSArray *)objectsForClass:(Class)argClass;

- (void)cr_storagerAddObject;

@end

@interface CRObjectStorageItem : NSObject

@property (nonatomic, assign) Class theClass;

@property (nonatomic, weak) id theObject;

@end