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
    NSMutableArray *_replyArr;
}

@end

@implementation KKKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _replyArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self layoutTableView];
    [self layoutInputBar];
    [self layoutPostInfoView];
    [self loadDate];
    
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
    _table = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), 64, SCREEN_W, CGRectGetHeight(self.view.bounds)-108)];//44是inputview高度
    [self.view addSubview:_table];
//    [_table setBackgroundColor:[UIColor redColor]];
    _table.dataSource = self;
    _table.delegate = self;
    _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _table.estimatedRowHeight = 44.0f;
    _table.rowHeight = UITableViewAutomaticDimension;

}


- (void)layoutPostInfoView {
    _postView = [[PostInfoView alloc] init];
    CGFloat height = [_postView setText];
    [_postView setFrame:CGRectMake(0, 0, SCREEN_W, height)];
    _table.tableHeaderView = _postView;
//    [_table.tableHeaderView setBackgroundColor:[UIColor yellowColor]];
    
}

- (void)loadDate {
    NSInteger i = 0;
    while (i<5) {
        [_replyArr addObject:@"我是谁：对酒当歌[大兵],人生几何[微笑]。"];
        i++;
    }
    [_table reloadData];
}

- (void)sendAction:(NSString *)text {
    [_replyArr addObject:[NSString stringWithFormat:@"我的回复：%@", text]];
    [_table reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _replyArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    [sectionV setBackgroundColor:[UIColor grayColor]];
    UILabel *sectionL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 30)];
    [sectionL setBackgroundColor:[UIColor clearColor]];
    [sectionL setText:[NSString stringWithFormat:@"回帖（%u）", (10+_replyArr.count)]];
    [sectionV addSubview:sectionL];
    return sectionV;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[PostInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    BOOL isMaster = NO;
    if (indexPath.row%2==0) {
        isMaster = YES;
    } else {
        isMaster = NO;
    }
    UserInfoModel *model = [[UserInfoModel alloc]initWithIsMaster:isMaster];
    [cell.userV setUserInfoWithModel:model];
    [cell.userV.cityL setHidden:YES];
    [cell setFloorNumber:indexPath.row+1];
    [cell setReplyText: _replyArr[indexPath.row]];
    
//    [cell setBackgroundColor:[UIColor orangeColor]];
    return cell;
    
}

@end
