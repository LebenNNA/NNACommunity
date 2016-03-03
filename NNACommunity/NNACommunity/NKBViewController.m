//
//  NKBViewController.m
//  NNACommunity
//
//  Created by NNA on 16/3/3.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "NKBViewController.h"
#import "NNAEmoInputBar.h"

@interface NKBViewController () {
    NNAEmoInputBar *_inputBar;
}

@end

@implementation NKBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _inputBar = [NNAEmoInputBar inputBar];
    _inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2);
    [self.view addSubview:_inputBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
