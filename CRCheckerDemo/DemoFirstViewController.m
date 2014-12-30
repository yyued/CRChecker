//
//  FirstViewController.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-26.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "DemoFirstViewController.h"
#import "DemoSecondViewController.h"
#import "DemoNormalViewController.h"
#import "CRChecker.h"

@interface DemoFirstViewController ()

@end

@implementation DemoFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"First";
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

- (IBAction)handleSecondViewControllerButtonTapped:(id)sender {
    DemoSecondViewController *nextViewController = [[DemoSecondViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

- (IBAction)handleNormalViewControllerButtonTapped:(id)sender {
    DemoNormalViewController *normalViewController = [[DemoNormalViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:normalViewController animated:YES];
}

- (IBAction)handleDashboardButtonTapped:(id)sender {
    [CRChecker presentDashBoardViewController];
//    NSLog(@"%@", [CRCounter counterDictionary][@"SecondViewController"]);
}

@end
