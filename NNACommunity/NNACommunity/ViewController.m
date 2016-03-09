//
//  ViewController.m
//  NNACommunity
//
//  Created by NNA on 16/3/3.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ViewController.h"
#import "KBViewController.h"
#import "NKBViewController.h"
#import "KKKViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 150, 100, 30)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTag:1001];
    [btn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 100, 30)];
    [btn1 setTitle:@"push1" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor blueColor]];
    [btn1 setTag:1002];
    [btn1 addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 250, 100, 30)];
    [btn2 setTitle:@"push2" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor blueColor]];
    [btn2 setTag:1003];
    [btn2 addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)pushAction:(UIButton *)sender {
    if (sender.tag == 1001) {
        KBViewController *kbVC = [[KBViewController alloc] init];
        [self.navigationController pushViewController:kbVC animated:YES];
    } else if (sender.tag == 1002) {
        NKBViewController *nkbVC = [[NKBViewController alloc] init];
        [self.navigationController pushViewController:nkbVC animated:YES];
    } else if (sender.tag == 1003) {
        KKKViewController *kkkVC = [[KKKViewController alloc] init];
        [self.navigationController pushViewController:kkkVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
