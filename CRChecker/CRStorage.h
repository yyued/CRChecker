//
//  CRStorage.h
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/30.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDefines.h"

@interface CRStorage : NSObject

+ (void)addObject:(id)argObject;

+ (NSArray *)objectsForClass:(Class)argClass;

@end

@interface CRStorageItem : NSObject

@property (nonatomic, assign) Class theClass;

@property (nonatomic, weak) id theObject;

@end
