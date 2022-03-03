//
//  KKViewController.m
//  KKCategoryPage
//
//  Created by kkwong90@163.com on 02/04/2022.
//  Copyright (c) 2022 kkwong90@163.com. All rights reserved.
//

#import "KKViewController.h"
#import "KKDefaultCategoryPage.h"
#import "KKCustomCellCategoryPage.h"
#import "KKMultiSectionCategoryPage.h"
@interface KKViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * datasource;

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.datasource = @[@{@"系统TableViewCell":KKDefaultCategoryPage.class}, @{@"自定义TableViewCell":KKCustomCellCategoryPage.class},@{@"多分区":KKMultiSectionCategoryPage.class}];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dict = [self.datasource objectAtIndex:indexPath.row];
    NSString * text = dict.allKeys.firstObject;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    cell.textLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary * dict = [self.datasource objectAtIndex:indexPath.row];
    Class cls = dict.allValues.firstObject;
    UIViewController * vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
