//
//  CRReporter.h
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/30.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRDefines.h"

@class CRStatusBar, CRDashBoardViewController, CRObjectBoardViewController;

@interface CRReporter : NSObject

@end

@interface CRStatusBar : UIView

@property (nonatomic, strong) UIButton *tipsButton;

@end

@interface CRDashBoardViewController : UIViewController

@end

@interface CRObjectBoardViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *className;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *objects;

@end