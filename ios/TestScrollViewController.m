//
//  TestScrollViewController.m
//  ios
//
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "TestScrollViewController.h"
#import "TableController.h"

@interface TestScrollViewController ()

@end

@implementation TestScrollViewController


#pragma mark - Override
// 子类化实现
- (NSArray<UIViewController<SSScrollContentControllerDeleagte> *> *)contentScrollers
{
    //
        NSMutableArray *arry = [[NSMutableArray alloc]init];
        for (int i =0; i<2; i++) {
            TableController *tabVc = [[TableController alloc]init];
            [arry addObject:tabVc];
        }
        return arry;
    return nil;
}

- (UIView *)tableHeaderView
{
    UIView *tableviewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    tableviewHeader.backgroundColor = [UIColor redColor];
    return tableviewHeader;
    return nil;
}


- (UIView *)tableViewForHeaderInSection:(NSInteger)section
{
    UIView *tableviewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    tableviewHeader.backgroundColor = [UIColor blueColor];
    return tableviewHeader;
}




@end
