//
//  PostReplyTableView.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/12.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostReplyModel.h"

@interface PostReplyTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *replyArr; //临时存数据演示用

- (void)setRowClicked:(void(^)(NSInteger row))handler;
- (void)loadWithModel:(PostReplyModel *)model;

@end
