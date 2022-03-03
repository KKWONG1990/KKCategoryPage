//
//  KKListTableViewController.h
//  KKCategoryPage_Example
//
//  Created by BYMac on 2022/2/4.
//  Copyright © 2022 kkwong90@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKListTableViewController : UITableViewController
@property (nonatomic, copy) void(^updateSelectRow)(NSIndexPath * indexPath);
@end

NS_ASSUME_NONNULL_END
