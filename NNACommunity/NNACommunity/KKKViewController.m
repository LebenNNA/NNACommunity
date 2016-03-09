    //
//  KKKViewController.m
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "KKKViewController.h"
#import "PostInfoView.h"
#import "NNAEmoInputBar.h"
#import "PostInfoTableViewCell.h"

@interface KKKViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_table;
    NNAEmoInputBar *_inputBar;
    PostInfoView *_postView;
}

@end

@implementation KKKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutTableView];
    [self layoutInputBar];
    [self layoutPostInfoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)layoutInputBar {
    _inputBar = [NNAEmoInputBar inputBar];
    [self.view addSubview:_inputBar];
    _inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2);
    
    __weak typeof(self) wself = self;
    [_inputBar setDidSendClicked:^(NSString *text) {
        [wself sendAction:text];
    }];
}

- (void)layoutTableView {
    _table = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), SCREEN_W, CGRectGetHeight(self.view.bounds)-44)];//44是inputview高度
    [self.view addSubview:_table];
//    [_table setBackgroundColor:[UIColor redColor]];
    _table.dataSource = self;
    _table.delegate = self;
}


- (void)layoutPostInfoView {
    _postView = [[PostInfoView alloc] init];
    CGFloat height = [_postView setText];
    [_postView setFrame:CGRectMake(0, 0, SCREEN_W, height)];
    _table.tableHeaderView = _postView;
//    [_table.tableHeaderView setBackgroundColor:[UIColor yellowColor]];
    
}

- (void)sendAction:(NSString *)text {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[PostInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell setBackgroundColor:[UIColor orangeColor]];
    return cell;
    
}

@end
