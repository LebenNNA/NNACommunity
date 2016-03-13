//
//  PostReplyTableView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/12.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostReplyTableView.h"
#import "PostReplyTableViewCell.h"
#import "ReplyDetailInfoView.h"
#import "ReplyContentModel.h"

#define UserV_h 60

@interface PostReplyTableView () {
    ReplyDetailInfoView *_replyDetailView;
}

@property (nonatomic, strong) PostReplyModel *prModel;
@property (nonatomic, copy) void(^rowClickedHandler)(NSInteger row);

@end

@implementation PostReplyTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _replyArr = [[NSMutableArray alloc] initWithCapacity:0];
        [self layoutReplyDetailInfoView];
        self.dataSource = self;
        self.delegate = self;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.estimatedRowHeight = 44.0f;
        self.rowHeight = UITableViewAutomaticDimension;
    }
    return self;
}

- (void)layoutReplyDetailInfoView {
    _replyDetailView = [[ReplyDetailInfoView alloc] init];
}

- (void)loadWithModel:(PostReplyModel *)model {
    _prModel = model;
    _replyArr = [ReplyContentModel objectArrayWithKeyValuesArray:_prModel.ReplyArr];
    [_replyDetailView setReplyText:_prModel.Reply];
    [_replyDetailView.userV setUserInfoWithModel:_prModel.User];
    [_replyDetailView.userV setFloor:_prModel.Floor];
    self.tableHeaderView = _replyDetailView;
    [self reloadData];
    [self layoutIfNeeded];
}

- (void)setRowClicked:(void (^)(NSInteger row))handler {
    _rowClickedHandler = handler;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _replyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PRCell"];
    if (cell == nil) {
        cell = [[PostReplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PRCell"];
    }
    ReplyContentModel *model = _replyArr[indexPath.row];
    [cell setContentWithModel:model];
    
    return cell;
}

#warning 待完成
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_rowClickedHandler){
        _rowClickedHandler(indexPath.row);
    }
//    ReplyViewController *rVC = [[ReplyViewController alloc] init];
//    rVC.prM = _prMArr[indexPath.row];
//    [self.navigationController pushViewController:rVC animated:YES];
}

@end
