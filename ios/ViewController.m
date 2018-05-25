//
//  ViewController.m
//  ios
//
//  Created by SunSet on 2018/5/25.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ViewController.h"
#import "SSPageScrollViewController.h"
#import "TestScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickTest:(id)sender
{
//    SSPageScrollViewController *controller = [[SSPageScrollViewController alloc]init];
    TestScrollViewController *controller = [[TestScrollViewController alloc]init];
    [self presentViewController:controller animated:YES completion:nil];
}




@end
