//
//  ViewController.m
//  NNACommunity
//
//  Created by NNA on 16/3/3.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ViewController.h"

#import "KKKViewController.h"
#import "nnnViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 30)];
    [btn1 setTitle:@"push1" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor blueColor]];
    [btn1 setTag:100];
    [btn1 addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 250, 100, 30)];
    [btn2 setTitle:@"push2" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor blueColor]];
    [btn2 addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)pushAction:(UIButton *)sender {
    if (sender.tag==100) {
        nnnViewController *kkkVC = [[nnnViewController alloc] init];
        [self.navigationController pushViewController:kkkVC animated:YES];
    } else {
        KKKViewController *kkkVC = [[KKKViewController alloc] init];
        [self.navigationController pushViewController:kkkVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
