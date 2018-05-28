//
//  TableController.m
//  Test多层嵌套Scrollview
//
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "TableController.h"

@interface TableController ()

@end

@implementation TableController

@synthesize canScroll;
@synthesize contentScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.contentScrollView = self.tableView;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//- (UIScrollView *)contentScrollView
//{
//    return self.tableView;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)viewDidLayoutSubviews
//{
//    self.tableView.frame = self.view.bounds;
//}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

///
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellider = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
    }
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"当前表格%li，第几行：%li", tableView.tag, indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
//    return arc4random()%2==0?50:120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@" %@ 滑动位置:%@ ",NSStringFromClass([self class]), NSStringFromCGPoint(scrollView.contentOffset));
//    self.scrollContentOffset = scrollView.contentOffset;
    
//    if (!self.canScroll) {
//        scrollView.contentOffset = CGPointZero;
////        self.scrollContentOffset = CGPointZero;
//    }
//
//    if (scrollView.contentOffset.y <= 0) {
//
//        self.canScroll = NO;
//        scrollView.contentOffset = CGPointZero;
//
//        // 到达顶部之后
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];
//
//    }
//}





@end
