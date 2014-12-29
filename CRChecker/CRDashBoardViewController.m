//
//  CRDashBoardViewController.m
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/26.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRDashBoardViewController.h"
#import "CRCounter.h"

static NSSet *systemLibraries;

@interface CRDashBoardViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) NSDictionary *finalCounterDictionary;

@property (nonatomic, assign) BOOL showSystemLibraries;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *optionButton;

@end

@implementation CRDashBoardViewController

+ (void)load {
    systemLibraries = [NSSet setWithObjects:
                       @"_",//Private
                       @"UI",//UIKit
                       @"CA",//Core Animation
                       @"OS",//Operator System
                       @"CR",//Unknowed
                       @"SBS",//Unknowed
                       @"CUI",//Unknowed
                       @"BKS",//Unknowed
                       @"CP",//Unknowed
                       @"AC",
                       @"AB",
                       @"AS",
                       @"AL",
                       @"AU",
                       @"Audio",
                       @"AV",
                       @"CF",
                       @"CG",
                       @"CI",
                       @"CL",
                       @"CM",
                       @"CT",
                       @"CV",
                       @"EK",
                       @"EA",
                       @"NS",
                       @"GC",
                       @"GK",
                       @"GLK",
                       @"gss",
                       @"HK",
                       @"HM",
                       @"AD",
                       @"JS",
                       @"LA",
                       @"MK",
                       @"MA",
                       @"MP",
                       @"MT",
                       @"MF",
                       @"MTL",
                       @"UT",
                       @"MC",
                       @"NE",
                       @"NK",
                       @"AL",
                       @"GL",
                       @"PK",
                       @"PH",
                       @"PK",
                       @"CA",
                       @"QL",
                       @"SS",
                       @"SCN",
                       @"CSSM",
                       @"Sec",
                       @"SL",
                       @"SK",
                       @"SC",
                       @"TW",
                       @"UI",
                       @"WK",
                       @"TI",
                       nil];
}

- (void)loadView {
    UIView *aView = [[UIView alloc] initWithFrame:self.parentViewController.view.bounds];
    aView.backgroundColor = [UIColor whiteColor];
    self.view = aView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Circular Reference Checker";
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = self.optionButton;
    [self refreshCounterArrayData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CRCounter

- (void)refreshCounterArrayData {
    NSDictionary *counterDictionary = [CRCounter counterDictionary];
    NSMutableArray *finalKeys = [[counterDictionary allKeys] mutableCopy];
    for (NSString *keyString in [counterDictionary allKeys]) {
        BOOL shouldIgnore = NO;
        if (!self.showSystemLibraries) {
            for (NSString *systemLibraryPrefix in systemLibraries) {
                if ([keyString hasPrefix:systemLibraryPrefix]) {
                    shouldIgnore = YES;
                    break;
                }
            }
        }
        if ([counterDictionary[keyString] integerValue] <= 0) {
            shouldIgnore = YES;
        }
        if (shouldIgnore) {
            [finalKeys removeObject:keyString];
            continue;
        }
    }
    NSMutableDictionary *tmpCounterDictionary = [NSMutableDictionary dictionary];
    for (NSString *keyString in [finalKeys copy]) {
        [tmpCounterDictionary setObject:counterDictionary[keyString] forKey:keyString];
    }
    self.finalCounterDictionary = [tmpCounterDictionary copy];
    [[self tableView] reloadData];
}

#pragma mark - UITableView

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self finalCounterDictionary] allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSString *keyString = [[self finalCounterDictionary] allKeys][indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", keyString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Alive:%@", [self finalCounterDictionary][keyString]];
    return cell;
}

#pragma mark - self.optionButton

- (UIBarButtonItem *)optionButton {
    if (_optionButton == nil) {
        _optionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                      target:self
                                                                      action:@selector(handleOptionButtonTapped)];
    }
    return _optionButton;
}

- (void)handleOptionButtonTapped {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Refresh Data", @"Close DashBoard",
                                  nil];
    [actionSheet showInView:[[[UIApplication sharedApplication] delegate] window]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Refresh Data"]) {
        [self refreshCounterArrayData];
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Close DashBoard"]) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
