//
//  SSScrollContentControllerDeleagte.h
//  SSPageScrollController
//  中间内部子视图必须实现的方法
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SSScrollContentControllerDeleagte <NSObject>


/**
 子controller设定页面的偏移量 用于上层处理偏移变化
 */
//@property(nonatomic) CGPoint scrollContentOffset;
@property(nonatomic, strong) UIScrollView *contentScrollView;

@property(nonatomic) BOOL canScroll;

@end
