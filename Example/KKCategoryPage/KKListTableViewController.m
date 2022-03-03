//
//  KKListTableViewController.m
//  KKCategoryPage_Example
//
//  Created by BYMac on 2022/2/4.
//  Copyright © 2022 kkwong90@163.com. All rights reserved.
//

#import "KKListTableViewController.h"

@interface KKListTableViewController ()

@end

@implementation KKListTableViewController
{
    NSArray *_datas;
    CGPoint _currentOffset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"reuseIdentifier"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    cell.textLabel.text = self.title;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.title]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@ _ %ld",self.title, section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView.isDecelerating || tableView.isDragging) {
        if (tableView.contentOffset.y < _currentOffset.y) {
            if (self.updateSelectRow) {
                self.updateSelectRow([NSIndexPath indexPathForRow:section inSection:0]);
            }
        }
        _currentOffset = tableView.contentOffset;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView.isDecelerating || tableView.isDragging) {
        if (tableView.contentOffset.y > _currentOffset.y) {
            if (self.updateSelectRow) {
                self.updateSelectRow([NSIndexPath indexPathForRow:section inSection:0]);
            }
        }
        _currentOffset = tableView.contentOffset;
    }
}

@end
