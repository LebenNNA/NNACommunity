//
//  PostReplyModel.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/12.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

/** 帖子回复modle */

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface PostReplyModel : NSObject

@property (nonatomic, strong) UserInfoModel *User;
@property (nonatomic, strong) NSString *Reply;
@property (nonatomic, assign) NSInteger Floor;
@property (nonatomic, strong) NSArray *ReplyArr; //里面应该存储的是replycontentModel

@end
