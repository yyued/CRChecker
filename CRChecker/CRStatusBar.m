//
//  CRStatusBar.m
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/26.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRStatusBar.h"
#import "CRChecker.h"

@interface CRStatusBar ()

@property (nonatomic, strong) UIButton *tipsButton;

@end

@implementation CRStatusBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tipsButton];
    }
    return self;
}

- (UIButton *)tipsButton {
    if (_tipsButton == nil) {
        _tipsButton = [[UIButton alloc] initWithFrame:self.bounds];
        _tipsButton.backgroundColor = [UIColor blackColor];
        [_tipsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_tipsButton setTitle:@"Tap To Present CRChecker DashBoard" forState:UIControlStateNormal];
        [_tipsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
        [_tipsButton addTarget:self
                        action:@selector(handleTipsButtonTapped)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipsButton;
}

- (void)handleTipsButtonTapped {
    [CRChecker presentDashBoardViewController];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
