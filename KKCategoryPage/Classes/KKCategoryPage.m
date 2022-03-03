//
//  KKCategoryPage.m
//  KKCategoryView
//
//  Created by BYMac on 2022/1/17.
//

#import "KKCategoryPage.h"

@interface KKCategoryPage()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIViewController * displayController;
/// 容器控制器
@property (nonatomic, strong) UIViewController * containerVC;
/// 已添加到容器的控制器数据
@property (nonatomic, strong) NSMutableDictionary * addedChilds;
@end

@implementation KKCategoryPage
{
    UITableViewStyle _style;
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain identifier:nil];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self initWithStyle:style identifier:nil];
}

- (instancetype)initWithStyle:(UITableViewStyle)style identifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        _style = style;
        _identifier = identifier;
        [self initSetup];
    }
    return self;
}

- (void)initSetup {
    self.delegate = self;
    self.datasource = self;
    _tableViewWidth = 100;
    _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setDisplayPage];
}

#pragma mark - 设置UI
- (void)setUI {
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:_style];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.view addSubview:self.tableView];
    
    self.containerVC = [[UIViewController alloc] init];
    self.containerVC.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.containerVC.view];
}

#pragma mark - 设置要显示的页面
- (void)setDisplayPage {
    UIViewController * child = [self fetchWillDisplayChild];
    if (child == nil || [self.displayController isEqual:child]) return;
    [self hideCurrentDisplayController];
    [self showChild:child];
}

#pragma mark - 隐藏当前显示的控制器
- (void)hideCurrentDisplayController {
    if (self.displayController) {
        [self.displayController willMoveToParentViewController:nil];
        [self.displayController removeFromParentViewController];
        [self.displayController.view removeFromSuperview];
    }
}

#pragma mark - 显示控制器
- (void)showChild:(UIViewController *)child {
    [self willAddChildController:child];
    [child beginAppearanceTransition:YES animated:YES];
    child.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerVC.view.frame), CGRectGetHeight(self.containerVC.view.frame));
    [self.containerVC addChildViewController:child];
    [self.containerVC.view addSubview:child.view];
    [child endAppearanceTransition];
    [self didAddChildController:child];
    [child didMoveToParentViewController:self.containerVC];
    self.displayController = child;
}

#pragma mark - 从加载过的数据源中取出当前要显示的控制器
- (UIViewController *)fetchWillDisplayChild {
    //如果有存在的控制器并且有且仅有一个的时候
    if (self.addedChilds.count && self.isOnlyOneChild) {
        return self.addedChilds.allValues.firstObject;
    }
    
    NSString * key = [self keyOfChild];
    if ([self.addedChilds.allKeys containsObject:key]) {
        return [self.addedChilds objectForKey:key];
    } else {
        UIViewController * child = [self fetchNewChild];
        if (child) {
            [self.addedChilds setObject:child forKey:key];
        }
        return child;
    }
}

#pragma mark - 子控制器的key
- (NSString *)keyOfChild {
    return [NSString stringWithFormat:@"%ld-%ld",(long)self.selectedIndexPath.section, (long)self.selectedIndexPath.row];
}

#pragma mark - 获取并保存子控制器
- (UIViewController *)fetchNewChild{
    if (self.datasource && [self.datasource respondsToSelector:@selector(categoryPage:childOfRowAtIndexPath:)]) {
        return [self.datasource categoryPage:self childOfRowAtIndexPath:self.selectedIndexPath];
    }
    return nil;
}

- (void)willAddChildController:(UIViewController *)controller {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryPage:willAddChildController:)]) {
        [self.delegate categoryPage:self willAddChildController:controller];
    }
}

- (void)didAddChildController:(UIViewController *)controller {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryPage:didAddChildController:)]) {
        [self.delegate categoryPage:self didAddChildController:controller];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat originY = [self originY];
    CGFloat height = CGRectGetHeight(self.view.frame) - [self originY] - [self bottomToView];
    self.tableView.frame = CGRectMake(0, originY, self.tableViewWidth, height);
    self.containerVC.view.frame = CGRectMake(self.tableViewWidth, originY, CGRectGetWidth(self.view.frame) - self.tableViewWidth, height);
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.datasource && [self.datasource respondsToSelector:@selector(numberOfTableViewSectionsInCategoryPage:)]) {
        return [self.datasource numberOfTableViewSectionsInCategoryPage:self];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.datasource && [self.datasource respondsToSelector:@selector(numberOfRowsInTableViewSection:categoryPage:)]) {
        return [self.datasource numberOfRowsInTableViewSection:section categoryPage:self];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identifier]; };
    if (self.datasource && [self.datasource respondsToSelector:@selector(categoryPage:cell:indexPath:)]) {
        [self.datasource categoryPage:self cell:cell indexPath:indexPath];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndexPath == indexPath) return;
    _selectedIndexPath = indexPath;
    [self setDisplayPage];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryPage:titleForHeaderSectionInTableView:)]) {
        return [self.delegate categoryPage:self titleForHeaderSectionInTableView:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryPage:viewForHeaderSectionInTableView:)]) {
        return [self.delegate categoryPage:self viewForHeaderSectionInTableView:section];
    }
    return nil;
}

- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath {
    _selectedIndexPath = selectedIndexPath;
    if (self.viewLoaded) {
        [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (CGFloat)originY {
    CGFloat statusBarHegith = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    return statusBarHegith + navigationBarHeight;
}

- (CGFloat)bottomToView {
    if (@available(iOS 11.0, *)) {
        return self.view.safeAreaInsets.bottom;
    }
    return 0;
}

- (NSMutableDictionary *)addedChilds {
    if (!_addedChilds) {
        _addedChilds = [NSMutableDictionary dictionary];
    }
    return _addedChilds;
}


@end
