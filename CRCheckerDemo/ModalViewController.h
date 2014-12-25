//
//  ModalViewController.h
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-26.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalViewController : UIViewController

/**
 *  We make strong reference for ViewController, we create a circular reference example.
 */
@property (nonatomic, strong) UIViewController *strongReference;

@end
