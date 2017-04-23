//
//  ViewController.m
//  FMDB
//
//  Created by mac on 2017/4/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import <FMDatabase.h>
#import "CarInfoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:(UIBarButtonItemStylePlain) target:self action:@selector(jumpAction:)];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark 按钮回调
-(void)jumpAction:(UIBarButtonItem *)sender{
    
    CarInfoViewController *vc = [[CarInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
