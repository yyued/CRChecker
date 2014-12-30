//
//  CRCategories.h
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/30.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDefines.h"

@interface NSObject (CRChecker)

- (instancetype)initWithCRChecker;

- (void)deallocWithCRChecker;

@end

@interface UIWindow (CRWindow)

- (void)makeKeyAndVisibleWithCRChecker;

@end