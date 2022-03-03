//
//  KKMultiSectionCategoryPage.m
//  KKCategoryPage_Example
//
//  Created by BYMac on 2022/3/3.
//  Copyright © 2022 kkwong90@163.com. All rights reserved.
//

#import "KKMultiSectionCategoryPage.h"
#import "KKListTableViewController.h"
@interface KKMultiSectionCategoryPage ()

@end

@implementation KKMultiSectionCategoryPage

{
    NSArray * _datas;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _datas = @[
            @{ @"汽车" : @[ @"Benz", @"BMW", @"Tesla"] },
            @{ @"摩托" : @[ @"Moto"] }
        ];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self
}

- (void)categoryPage:(KKCategoryPage *)categoryPage didAddChildController:(UIViewController *)controller {
    NSLog(@"controller === %@",controller);
}

- (NSInteger)numberOfTableViewSectionsInCategoryPage:(KKCategoryPage *)categoryPage {
    return _datas.count;
}

- (NSInteger)numberOfRowsInTableViewSection:(NSInteger)section categoryPage:(KKCategoryPage *)categoryPage {
    NSDictionary * dict = [_datas objectAtIndex:section];
    NSArray * arr = dict.allValues.firstObject;
    return arr.count;
}

- (NSString *)categoryPage:(KKCategoryPage *)categoryPage titleForHeaderSectionInTableView:(NSInteger)section {
    NSDictionary * dict = [_datas objectAtIndex:section];
    return dict.allKeys.firstObject;
}

- (void)categoryPage:(KKCategoryPage *)categoryPage cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSDictionary * dict = [_datas objectAtIndex:indexPath.section];
    NSArray * arr = dict.allValues.firstObject;
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
}

- (__kindof UIViewController *)categoryPage:(KKCategoryPage *)categoryPage childOfRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dict = [_datas objectAtIndex:indexPath.section];
    NSArray * arr = dict.allValues.firstObject;
    
    KKListTableViewController * vc = [[KKListTableViewController alloc] init];
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.title = [arr objectAtIndex:indexPath.row];
    return vc;
}

@end
