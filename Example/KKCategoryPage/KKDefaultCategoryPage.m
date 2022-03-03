//
//  KKDefaultCategoryPage.m
//  KKCategoryPage_Example
//
//  Created by BYMac on 2022/2/4.
//  Copyright © 2022 kkwong90@163.com. All rights reserved.
//

#import "KKDefaultCategoryPage.h"
#import "KKListTableViewController.h"
@interface KKDefaultCategoryPage ()

@end

@implementation KKDefaultCategoryPage
{
    NSArray * _datas;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _datas = @[
            @"Benz", @"BMW", @"Tesla", @"Moto"
        ];
        self.onlyOneChild = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfRowsInTableViewSection:(NSInteger)section categoryPage:(KKCategoryPage *)categoryPage {
    return _datas.count;
}

- (void)categoryPage:(KKCategoryPage *)categoryPage cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [_datas objectAtIndex:indexPath.row];
}

- (__kindof UIViewController *)categoryPage:(KKCategoryPage *)categoryPage childOfRowAtIndexPath:(NSIndexPath *)indexPath {
    KKListTableViewController * vc = [[KKListTableViewController alloc] init];
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.title = [_datas objectAtIndex:indexPath.row];
    vc.updateSelectRow = ^(NSIndexPath * _Nonnull indexPath) {
        categoryPage.selectedIndexPath = indexPath;
    };
    return vc;
}

@end
