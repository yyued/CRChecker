//
//  ModalViewController.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-26.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "DemoModalViewController.h"

@interface DemoModalViewController ()

@end

@implementation DemoModalViewController

- (void)dealloc {
    NSLog(@"ModalViewController Dealloc");
    //ModalViewController will never release...Because circular reference.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)handleDismissButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
