//
//  CRCounter.h
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDefines.h"

@interface CRCounter : NSObject

+ (void)increaseWithObject:(id)argObject;

+ (void)decreaseWithClass:(Class)argClass;

@end

@interface CRCounter (Private)

+ (NSDictionary *)counterDictionary;

@end