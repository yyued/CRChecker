//
//  ViewController.m
//  CRCheckerDemo
//
//  Created by 崔 明辉 on 14-12-25.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "SecondViewController.h"
#import "ModalViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) ModalViewController *firstStrongReference;

@end

@implementation SecondViewController

- (void)dealloc {
    NSLog(@"SecondViewController Dealloc");
    //SecondViewController will never release...Because circular reference.
    //You see, self refer self.firstStrongReference & self.firstStrongReference.strongReference refer self
    //The best way to solve this problem is make self.firstStrongReference.strongReference weak.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Second";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handlePresentModalViewControllerButtonTapped:(id)sender {
    self.firstStrongReference = [[ModalViewController alloc] initWithNibName:nil bundle:nil];
    self.firstStrongReference.strongReference = self;
    [self presentViewController:self.firstStrongReference animated:YES completion:^{
        
    }];
}

@end
