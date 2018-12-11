//
//  SSPageScrollViewController.h
//  SSPageScrollController
//  主页
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSScrollContentControllerDeleagte.h"
#import "SSPageScrollContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSPageScrollViewController : UIViewController

// 滑动内部视图
@property(nonatomic, strong, readonly) SSPageScrollContentView *scrollContentView;



#pragma mark - Override(子类化实现下面的方法)
/**
 子类化的时候实现

 @return 一组子控制器
 */
- (NSArray<UIViewController<SSScrollContentControllerDeleagte> *> *)contentScrollers;

/**
 表单视图

 @return 表单头部视图
 */
- (UIView *)tableHeaderView;

/**
 配置tableView每组 Section的header图

 @param section section
 @return 视图
 */
- (UIView *)tableViewForHeaderInSection:(NSInteger)section;


@end


NS_ASSUME_NONNULL_END



/*
 *
 *
 */













