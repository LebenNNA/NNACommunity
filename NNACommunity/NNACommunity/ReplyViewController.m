//
//  ReplyViewController.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/10.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ReplyViewController.h"
#import "PostReplyTableView.h"
#import "ReplyContentModel.h"
#import "NNAEmoInputBar.h"
#import "NNAEmoUnit.h"
#import "Masonry.h"

@interface ReplyViewController () {
    NNAEmoInputBar *_inputBar;
    UserInfoModel *_replyToUser;
}

@property (nonatomic, strong) PostReplyTableView *table;

@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self. view setBackgroundColor:[UIColor whiteColor]];
    _replyToUser = nil;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self layoutTableView];
    [self layoutInputBar];

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
    _table = [[PostReplyTableView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), 64, SCREEN_W, CGRectGetHeight(self.view.bounds)-108)];//44是inputview高度
    [self.view addSubview:_table];
    [_table loadWithModel:_prM];

    __block ReplyContentModel *model = [[ReplyContentModel alloc] init];
    __weak typeof (self) wself = self;
    [_table setRowClicked:^(NSInteger row) {
        model = [ReplyContentModel objectArrayWithKeyValuesArray:_prM.ReplyArr][row];
        _replyToUser = model.User;
        [wself replyAction];
        
    }];
}

- (void)replyAction {
    [_inputBar.textView becomeFirstResponder];
    _inputBar.placeHolder = [NSString stringWithFormat:@"回复：%@", _replyToUser];
    
}

- (void)sendAction:(NSString *)text {
    ReplyContentModel *model = [[ReplyContentModel alloc] init];
    model.User = [[UserInfoModel alloc] initWithIsMaster:NO];
    if (_replyToUser!=nil) {
        model.Content = [NSString stringWithFormat:@"回复@%@:%@", _replyToUser.Name, text];
        _replyToUser = nil;
    } else {
        model.Content = [NSString stringWithFormat:@"%@", text];
    }
    [_table.replyArr addObject:model];
    [_table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
