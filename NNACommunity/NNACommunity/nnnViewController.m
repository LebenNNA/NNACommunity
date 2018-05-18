//
//  nnnViewController.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "nnnViewController.h"
#import "SJEmojiLabel.h"
#import "Masonry.h"

@interface nnnViewController ()

@end

@implementation nnnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:view];
    [view setBackgroundColor:[UIColor redColor]];
    
    SJEmojiLabel *label = [SJEmojiLabel new];
    label.numberOfLines = 0;
    label.text = @"111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
    [label setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.equalTo(self.view).with.offset(60);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
