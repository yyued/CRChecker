//
//  CRReporter.m
//  CRChecker
//
//  Created by 崔 明辉 on 14/12/30.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRReporter.h"

@implementation CRReporter

@end

#pragma mark - CRStatusBar

@implementation CRStatusBar

+ (void)load {
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(addStatusBar)
                                   userInfo:nil
                                    repeats:YES];
}

+ (void)addStatusBar {
    static CRStatusBar *statusBar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statusBar = [[CRStatusBar alloc] initWithFrame:CGRectZero];
    });
    if ([[[UIApplication sharedApplication] delegate] window] != nil) {
        [[[[UIApplication sharedApplication] delegate] window] addSubview:statusBar];
        [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self addSubview:self.tipsButton];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UIButton *)tipsButton {
    if (_tipsButton == nil) {
        _tipsButton = [[UIButton alloc] initWithFrame:self.bounds];
        _tipsButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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

- (void)didMoveToSuperview {
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.superview.frame), 20.0);
}

@end

#pragma mark - CRDashBoardViewController

@interface CRDashBoardViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *counterDictionary;

@end

@implementation CRDashBoardViewController

- (void)loadView {
    UIView *aView = [[UIView alloc] initWithFrame:self.parentViewController.view.bounds];
    aView.backgroundColor = [UIColor whiteColor];
    self.view = aView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Circular Reference Checker";
    [self.view addSubview:self.tableView];
    self.counterDictionary = [CRCounter counterDictionary];
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(dismissModalViewControllerAnimated:)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [[[self counterDictionary] allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSString *keyString = [[self counterDictionary] allKeys][indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", keyString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Alive:%@", [self counterDictionary][keyString]];
    if ([self isSuspicious:keyString]) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    else {
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *keyString = [[self counterDictionary] allKeys][indexPath.row];
    CRObjectBoardViewController *objectBoardViewController = [[CRObjectBoardViewController alloc] initWithNibName:nil bundle:nil];
    objectBoardViewController.className = keyString;
    [self.navigationController pushViewController:objectBoardViewController animated:YES];
}

#pragma mark - Circular Objects Detector

- (BOOL)isSuspicious:(NSString *)argClassName {
    NSArray *classObjects = [CRStorage objectsForClass:NSClassFromString(argClassName)];
    for (CRStorageItem *storageItem in classObjects) {
        __strong id strongObject = storageItem.theObject;
        if (strongObject != nil &&
            [strongObject isKindOfClass:[UIViewController class]] &&
            [strongObject parentViewController] == nil) {
            return YES;
        }
        else if (strongObject != nil &&
                 [strongObject isKindOfClass:[UIView class]] &&
                 [strongObject superview] == nil) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation CRObjectBoardViewController

- (void)loadView {
    UIView *aView = [[UIView alloc] initWithFrame:self.parentViewController.view.bounds];
    aView.backgroundColor = [UIColor whiteColor];
    self.view = aView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.className;
    [self.view addSubview:self.tableView];
    self.objects = [CRStorage objectsForClass:NSClassFromString(self.className)];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section < [self.objects count]) {
        CRStorageItem *storageItem = self.objects[indexPath.section];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Description";
            if (storageItem.theObject == nil) {
                cell.detailTextLabel.text = @"Object released.";
            }
            else {
                cell.detailTextLabel.text = [storageItem.theObject description];
            }
        }
        else if (indexPath.row == 1) {
            if ([storageItem.theObject isKindOfClass:[UIView class]]) {
                cell.textLabel.text = @"SuperView Class";
                NSString *svcString = NSStringFromClass([[(UIView *)storageItem.theObject superview] class]);
                if (svcString == nil) {
                    cell.detailTextLabel.text = @"None of SuperView";
                }
                else {
                    cell.detailTextLabel.text = svcString;
                }
            }
            else if ([storageItem.theObject isKindOfClass:[UIViewController class]]) {
                cell.textLabel.text = @"ParentViewController Class";
                NSString *pvcString = NSStringFromClass([[(UIViewController *)storageItem.theObject parentViewController] class]);
                if (pvcString == nil) {
                    cell.detailTextLabel.text = @"None of ParentViewController";
                }
                else {
                    cell.detailTextLabel.text = pvcString;
                }
            }
            else {
                cell.textLabel.text = @"None information provided.";
                cell.detailTextLabel.text = @"";
            }
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"Debug";
            cell.detailTextLabel.text = @"Set breakpoint, then Tap!";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        if (indexPath.section < [self.objects count]) {
            CRStorageItem *storageItem = self.objects[indexPath.section];
            id theObject = storageItem.theObject;
            NSLog(@"Set a breakpoint here! CRReporter.m:276");
        }
    }
}

@end