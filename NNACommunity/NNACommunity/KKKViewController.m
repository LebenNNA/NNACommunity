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
#import "ReplyViewController.h"
#import "PostReplyModel.h"
#import "ReplyContentModel.h"
#import "PostInfoModel.h"
#import "MJExtension.h"

@interface KKKViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_table;
    NNAEmoInputBar *_inputBar;
    PostInfoView *_postView;
    PostReplyModel *prM;
    PostInfoModel *postM;
    NSArray *_prMArr;
}

@end

@implementation KKKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _prMArr = [[NSArray alloc] init];
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
    _table.dataSource = self;
    _table.delegate = self;
    _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _table.estimatedRowHeight = 44.0f;
    _table.rowHeight = UITableViewAutomaticDimension;

}


- (void)layoutPostInfoView {
    _postView = [[PostInfoView alloc] init];
}

- (void)loadDate {
    NSArray *postArr =  [NSMutableArray objectArrayWithFilename:@"Post.plist"];
    postArr = [PostInfoModel objectArrayWithKeyValuesArray:postArr];
    postM = postArr[0];
    CGFloat height = [_postView setContentWithModel:postM];
    NSArray *imgArr = [[NSArray alloc] initWithObjects:@"hzw1@2x.jpg", @"hzw2@2x.jpg", @"hzw3@2x.jpg", nil];
    height = [_postView setImagesWithArray:imgArr];
    [_postView setFrame:CGRectMake(0, 0, SCREEN_W, height)];
    _table.tableHeaderView = _postView;
    
    _prMArr = [PostReplyModel objectArrayWithKeyValuesArray:postM.PostReplyArr];

    [_table reloadData];
    
}

- (void)sendAction:(NSString *)text {
    PostReplyModel *pM = [[PostReplyModel alloc] init];
    pM.User = [[UserInfoModel alloc]initWithIsMaster:YES];
    pM.Reply = [NSString stringWithFormat:@"我的回复：%@", text];
    pM.ReplyArr = @[];
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
    return _prMArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    [sectionV setBackgroundColor:[UIColor grayColor]];
    UILabel *sectionL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 30)];
    [sectionL setBackgroundColor:[UIColor clearColor]];
    [sectionL setText:[NSString stringWithFormat:@"回帖（%lu）", (_prMArr.count)]];
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
    PostReplyModel *model = _prMArr[indexPath.row];
    [cell.priV.userV setUserInfoWithModel:model.User];
    [cell.priV.userV.cityL setHidden:YES];
    [cell.priV setFloorNumber:indexPath.row+1];
    NSArray *replyContentArr = [ReplyContentModel objectArrayWithKeyValuesArray:model.ReplyArr];
    [cell.priV setReplyText:model.Reply replyArr:replyContentArr];
    
//    [cell setBackgroundColor:[UIColor orangeColor]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReplyViewController *rVC = [[ReplyViewController alloc] init];
    rVC.prM = _prMArr[indexPath.row];
    rVC.prM.Floor = indexPath.row+1;
    [self.navigationController pushViewController:rVC animated:YES];
}

@end
