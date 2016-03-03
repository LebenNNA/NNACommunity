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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 150, 100, 100)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTag:1001];
    [btn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 100, 100)];
    [btn1 setTitle:@"push1" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor blueColor]];
    [btn1 setTag:1002];
    [btn1 addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)pushAction:(UIButton *)sender {
    if (sender.tag == 1001) {
        KBViewController *kbVC = [[KBViewController alloc] init];
        [self.navigationController pushViewController:kbVC animated:YES];
    } else if (sender.tag == 1002) {
        NKBViewController *nkbVC = [[NKBViewController alloc] init];
        [self.navigationController pushViewController:nkbVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
