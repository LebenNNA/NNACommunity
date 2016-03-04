//
//  NKBViewController.m
//  NNACommunity
//
//  Created by NNA on 16/3/3.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "NKBViewController.h"
#import "NNAEmoInputBar.h"
#import "SJEmojiLabel.h"

@interface NKBViewController () <UITableViewDataSource, UITableViewDelegate> {
    NNAEmoInputBar *_inputBar;
    UITableView *table;
    NSMutableArray *arr;
}

@end

@implementation NKBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds];
    [table setBackgroundColor:[UIColor redColor]];
    table.dataSource = self;
    table.delegate = self;
    table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:table];
    
    arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    _inputBar = [NNAEmoInputBar inputBar];
    _inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2);
    [self.view addSubview:_inputBar];
    
    __weak typeof(self) wself = self;
    [_inputBar setDidSendClicked:^(NSString *text) {
        [wself sendAction:text];
    }];
    
}

- (void)sendAction:(NSString *)text {
    SJEmojiLabel *titleLabel = [[SJEmojiLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = text;
    [arr addObject:titleLabel];
    [table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell.contentView addSubview:[arr objectAtIndex:indexPath.row]];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
