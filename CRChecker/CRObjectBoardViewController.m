//
//  CRObjectBoardViewController.m
//  CRChecker
//
//  Created by 崔 明辉 on 14-12-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "CRObjectBoardViewController.h"
#import "NSObject+CRObjectStorager.h"

@interface CRObjectBoardViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *objects;

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
    self.objects = [NSObject objectsForClass:NSClassFromString(self.className)];
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
        CRObjectStorageItem *storageItem = self.objects[indexPath.section];
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
            CRObjectStorageItem *storageItem = self.objects[indexPath.section];
            id theObject = storageItem.theObject;
            NSLog(@"Set a breakpoint here! CRObjectBoardViewController.m:117");
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
