//
//  KKCustomCellCategoryPage.m
//  KKCategoryPage_Example
//
//  Created by BYMac on 2022/2/4.
//  Copyright © 2022 kkwong90@163.com. All rights reserved.
//

#import "KKCustomCellCategoryPage.h"
#import "KKListTableViewController.h"
#import "KKCustomCell.h"
@interface KKCustomCellCategoryPage ()

@end

@implementation KKCustomCellCategoryPage
{
    NSArray * _datas;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.identifier = NSStringFromClass(KKCustomCell.class);
        _datas = @[
            @"Benz", @"BMW", @"Tesla", @"Moto"
        ];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView registerClass:KKCustomCell.class forCellReuseIdentifier:self.identifier];
}

- (void)categoryPage:(KKCategoryPage *)categoryPage didAddChildController:(UIViewController *)controller {
    NSLog(@"controller === %@",controller);
}

- (NSInteger)numberOfRowsInTableViewSection:(NSInteger)section categoryPage:(KKCategoryPage *)categoryPage {
    return _datas.count;
}

- (void)categoryPage:(KKCategoryPage *)categoryPage cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    KKCustomCell * customCell = (KKCustomCell *)cell;
    customCell.textLabel.text = [_datas objectAtIndex:indexPath.row];
}

- (__kindof UIViewController *)categoryPage:(KKCategoryPage *)categoryPage childOfRowAtIndexPath:(NSIndexPath *)indexPath {
    KKListTableViewController * vc = [[KKListTableViewController alloc] init];
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.title = [_datas objectAtIndex:indexPath.row];
    return vc;
}

@end
