//
//  KKCategoryPage.h
//  KKCategoryView
//
//  Created by BYMac on 2022/1/17.
//

#import <UIKit/UIKit.h>
@class KKCategoryPage;
NS_ASSUME_NONNULL_BEGIN

@protocol KKCategoryPageDelegate <NSObject>
@optional

/// 即将添加子控制器
/// @param categoryPage KKCategoryPage
/// @param controller 目标控制器
- (void)categoryPage:(KKCategoryPage *)categoryPage willAddChildController:(UIViewController *)controller;

/// 子控制器添加完毕
/// @param categoryPage KKCategoryPage
/// @param controller 目标控制器
- (void)categoryPage:(KKCategoryPage *)categoryPage didAddChildController:(UIViewController *)controller;

/// 设置头部分区标题
/// @param categoryPage KKCategoryPage
/// @param section 分区
- (nullable NSString *)categoryPage:(KKCategoryPage *)categoryPage titleForHeaderSectionInTableView:(NSInteger)section;

/// 设置头部分区视图
/// @param categoryPage KKCategoryPage
/// @param section 分区
- (nullable UIView *)categoryPage:(KKCategoryPage *)categoryPage viewForHeaderSectionInTableView:(NSInteger)section;

@end

@protocol KKCategoryPageDatasource <NSObject>
@optional;

/// 设置TableView分区数量
/// @param categoryPage KKCategoryPage
- (NSInteger)numberOfTableViewSectionsInCategoryPage:(KKCategoryPage *)categoryPage;

/// 设置TableView分区的行数
/// @param section 分区
/// @param categoryPage KKCategoryPage
- (NSInteger)numberOfRowsInTableViewSection:(NSInteger)section categoryPage:(KKCategoryPage *)categoryPage;

/// 设置cell数据
/// @param categoryPage KKCategoryPage
/// @param cell UITableViewCell
/// @param indexPath NSIndexPath
- (void)categoryPage:(KKCategoryPage *)categoryPage cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

/// 设置内容显示控制器
/// @param categoryPage KKCategoryPage
/// @param indexPath NSIndexPath
- (__kindof UIViewController *)categoryPage:(KKCategoryPage *)categoryPage childOfRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface KKCategoryPage : UIViewController<KKCategoryPageDelegate, KKCategoryPageDatasource>

///  初始化
/// @param style UITableViewStyle 默认UITableViewStylePlain
- (instancetype)initWithStyle:(UITableViewStyle)style;

/// 初始化并指定一个UITableViewCell标识符
/// @param style UITableViewStyle 默认UITableViewStylePlain
/// @param identifier 标识符
- (instancetype)initWithStyle:(UITableViewStyle)style identifier:(nullable NSString *)identifier;

/// 表格视图
@property (nonatomic, strong, readonly) UITableView * tableView;

/// UITableViewCell标识符 - 在初始化方法设置
@property (nonatomic, copy) NSString * identifier;

/// 代理
@property (nonatomic, weak) id<KKCategoryPageDelegate>delegate;

/// 数据源
@property (nonatomic, weak) id<KKCategoryPageDatasource>datasource;

/// tableview的宽度
@property (nonatomic) CGFloat tableViewWidth;

/// 选中行
@property (nonatomic, strong) NSIndexPath * selectedIndexPath;

/// 当前显示的控制器
@property (nonatomic, strong, readonly) UIViewController * displayController;

/// 是否只有一个子控制器
@property (nonatomic, assign, getter=isOnlyOneChild) BOOL onlyOneChild;
@end

NS_ASSUME_NONNULL_END
