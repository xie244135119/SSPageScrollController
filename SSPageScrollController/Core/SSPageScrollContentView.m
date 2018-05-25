//
//  SSPageScrollContentView.m
//  SSPageScrollController
//
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "SSPageScrollContentView.h"

NSString *const kkCollectionCellider = @"kkContentCollectionCellider";

@interface SSPageScrollContentView()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    // 收集控制器
    __weak UICollectionView *_collectionView;
}
@end

@implementation SSPageScrollContentView

- (void)dealloc
{
    for (UIViewController<SSScrollContentControllerDeleagte> *controller in _contentControllers) {
        [controller removeObserver:self forKeyPath:@"contentScrollView.contentOffset"];
    }
}


- (instancetype)initWithFrame:(CGRect)frame
           contentControllers:(NSArray<UIViewController<SSScrollContentControllerDeleagte> *> *)controllers
               rootController:(UIViewController *)rootController
{
    if (self = [super initWithFrame:frame]) {
        _contentControllers = controllers;
        // 视图加载
        [self setupViews];
        // 配置
        [self setupPreference];
        //
        for (UIViewController<SSScrollContentControllerDeleagte> *controller in _contentControllers) {
            // 加载到父控制器
            [rootController addChildViewController:controller];
        }
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}


#pragma mark - 内部视图
// 视图初始化
- (void)setupViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:collectionView];
    _collectionView = collectionView;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kkCollectionCellider];
    
}

// 配置
- (void)setupPreference
{
    //
    _canScroll = YES;
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
//
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _contentControllers.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kkCollectionCellider forIndexPath:indexPath];

    // 添加子视图
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *controller = _contentControllers[indexPath.row];
    controller.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:controller.view];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    for (UIViewController<SSScrollContentControllerDeleagte> *controller in _contentControllers) {
        //            // 添加对子控制器的偏移量监听
        [controller addObserver:self forKeyPath:@"contentScrollView.contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(controller)];
    }
    
}

// collectionView begin drag
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //
    if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegate scrollViewWillBeginDragging:self];
    }
}

// collectionView end drage
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 停止滑动的时候
    if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegate scrollViewWillBeginDragging:self];
    }
}

// 滚动的时候
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentindex = scrollView.contentOffset.x/scrollView.frame.size.width;
    // 页数切换的时候
    if (_selectIndex != currentindex) {
        _selectIndex = currentindex;
        //
        if ([_delegate respondsToSelector:@selector(scrollView:atIndex:)]) {
            [_delegate scrollView:self atIndex:currentindex];
        }
    }
}



#pragma mark - SET
//
- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
        
        // 滚动到指定item
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

// 设置
- (void)setCanScroll:(BOOL)canScroll
{
    _canScroll = canScroll;
    
    // 设置是否允许滑动
    for (UIViewController<SSScrollContentControllerDeleagte> *controller in _contentControllers) {
        controller.canScroll = canScroll;
        
        if (!canScroll) {
            controller.contentScrollView.contentOffset = CGPointZero;
        }
    }
}



#pragma mark - KVO
//
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    // 偏移量
    if ([keyPath isEqualToString:@"contentScrollView.contentOffset"]) {
        NSValue *new = change[NSKeyValueChangeNewKey];
        CGPoint point; [new getValue:&point];
        CGPoint oldpoint = CGPointZero;
        NSValue *old = change[NSKeyValueChangeOldKey];
        if (![old isKindOfClass:[NSNull class]]) {
            [old getValue:&oldpoint];
        }

        // 两次一样，不执行
        if (CGPointEqualToPoint(point, oldpoint)) {
            return;
        }
        
        UIViewController<SSScrollContentControllerDeleagte> *controller = (__bridge UIViewController<SSScrollContentControllerDeleagte> *)(context);
        // 禁止滑动的时候，保持子视图一直在顶部状态
        if (!controller.canScroll) {
            controller.contentScrollView.contentOffset = CGPointZero;
        }
        
        if (point.y <= 0) {
            controller.canScroll = NO;
            controller.contentScrollView.contentOffset = CGPointZero;
            
            // 通知上层 子视图已经到顶
            if ([_delegate respondsToSelector:@selector(scrollView:subViewsScrollToTop:)]) {
                [_delegate scrollView:self subViewsScrollToTop:YES];
            }
            
        }
    }
    
    
}




@end















