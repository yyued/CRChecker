//
//  CRChecker.h
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRChecker : NSObject

/**
 *  If you add custom class prefix, CRChecker will check these class only.
 */
+ (void)addCustomClassPrefix:(NSString *)argPrefix;

/**
 *  Present Dash Board
 */
+ (void)presentDashBoardViewController;

@end
