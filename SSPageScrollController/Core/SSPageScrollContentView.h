//
//  SSPageScrollContentView.h
//  SSPageScrollController
//  cell中加载的子视图
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSScrollContentControllerDeleagte.h"
@protocol SSPageScrollContentDelegate;

@interface SSPageScrollContentView : UIView


/**
 是否允许滚动 默认为YES
 */
@property(nonatomic, assign) BOOL canScroll;
//
@property(nonatomic, weak) id<SSPageScrollContentDelegate> delegate;
// 内部视图
@property(nonatomic, strong, readonly) NSArray<UIViewController<SSScrollContentControllerDeleagte> *> *contentControllers;

/**
 选中的视图的索引值  默认为0
 */
@property(nonatomic) NSInteger selectIndex;


/**
 实例化

 @param frame 大小
 @param controllers 一组内部控制器
 @param rootController 根控制器
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
           contentControllers:(NSArray<UIViewController<SSScrollContentControllerDeleagte> *> *)controllers
               rootController:(UIViewController *)rootController;


@end


@protocol SSPageScrollContentDelegate<NSObject>

@optional
// view 开始滑动的时候
- (void)scrollViewWillBeginDragging:(SSPageScrollContentView *)scrollView;
// view 停止滑动的时候
- (void)scrollViewDidEndDragging:(SSPageScrollContentView *)scrollView
                      scrollView:(UIScrollView *)scrollView;
// 滚动到某一页的时候
- (void)scrollView:(SSPageScrollContentView *)scrollView
           atIndex:(NSInteger)index;

// 内部子视图已经滑到顶部
- (void)scrollView:(SSPageScrollContentView *)scrollView subViewsScrollToTop:(BOOL)top;

@end








