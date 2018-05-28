//
//  SSPageScrollViewController.m
//  SSPageScrollController
//
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "SSPageScrollViewController.h"
#import "SSRecognizeGesTableView.h"
#import "SSPageScrollContentView.h"

@interface SSPageScrollViewController ()<UITableViewDataSource, UITableViewDelegate, SSPageScrollContentDelegate>
// 是否允许滑动
@property(nonatomic) BOOL viewCanScroll;
// 滑动视图
@property(nonatomic, weak) SSPageScrollContentView *scrolContentView;
// 承载主视图的table
@property(nonatomic, weak) UITableView *scrollMainTableView;
@end

@implementation SSPageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 视图初始化
    [self setupViews];
    // 配置加载
    [self setupPreferences];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 改变尺寸
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _scrollMainTableView.frame = self.view.bounds;
}


#pragma mark -
// 初始化视图
- (void)setupViews
{
    SSRecognizeGesTableView *tableView = [[SSRecognizeGesTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _scrollMainTableView = tableView;
    
    // headerView
    tableView.tableHeaderView = [self tableHeaderView];
    // footerView
    tableView.tableFooterView = [UIView new];
}

// 初始化配置
- (void)setupPreferences
{
    // 允许滑动
    _viewCanScroll = YES;
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellider = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 内部视图加载
        CGFloat headersection = [self tableView:tableView heightForHeaderInSection:0];
        CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, self.view.frame.size.height-headersection);
        SSPageScrollContentView *contentView = [[SSPageScrollContentView alloc]initWithFrame:frame contentControllers:[self contentScrollers] rootController:self];
        contentView.delegate = self;
        [cell.contentView addSubview:contentView];
        _scrolContentView = contentView;
    }
    
    return cell;
}

#pragma mark -
// row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self tableView:tableView heightForHeaderInSection:indexPath.section];
    return self.view.frame.size.height-height+1;
}


#pragma mark - 子类覆盖
// section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self tableViewForHeaderInSection:section].frame.size.height;
}

// section header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //
    return [self tableViewForHeaderInSection:section];
}


//#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomCellOffset = [_scrollMainTableView rectForSection:0].origin.y;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (_viewCanScroll) {
            _viewCanScroll = NO;
            _scrolContentView.canScroll = YES;
        }
    }else{
        if (!_viewCanScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
}



#pragma mark - SSPageScrollContentDelegate
// 开始滑动的时候
- (void)scrollViewWillBeginDragging:(SSPageScrollContentView *)scrollView
{
//    NSLog(@" scrollViewWillBeginDragging ");
}

// view 停止滑动的时候
- (void)scrollViewDidEndDragging:(SSPageScrollContentView *)scrollView scrollView:(UIScrollView *)scrollView
{
//    NSLog(@" scrollViewDidEndDragging ");
}

// 滚动到某一页的时候
- (void)scrollView:(SSPageScrollContentView *)scrollView atIndex:(NSInteger)index
{
//    NSLog(@" scrollView:atIndex: ");
}

// 内部子视图已经滑到顶部
- (void)scrollView:(SSPageScrollContentView *)scrollView subViewsScrollToTop:(BOOL)top
{
    _viewCanScroll = YES;
    _scrolContentView.canScroll = NO;
}


#pragma mark - Override
// 子类化实现
- (NSArray<UIViewController<SSScrollContentControllerDeleagte> *> *)contentScrollers
{
    // override
    return nil;
}

- (UIView *)tableHeaderView
{
    // override
    return nil;
}

- (UIView *)tableViewForHeaderInSection:(NSInteger)section
{
    // override
    return nil;
}


@end













