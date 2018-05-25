//
//  SSRecognizeGesTableView.m
//  SSPageScrollController
//
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "SSRecognizeGesTableView.h"

@implementation SSRecognizeGesTableView


/**
 同时识别多个手势

 @param gestureRecognizer 手势
 @param otherGestureRecognizer 其他手势
 @return yes
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
