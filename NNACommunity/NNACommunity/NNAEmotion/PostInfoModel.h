//
//  PostInfoModel.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/13.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

/** 帖子信息modle */

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface PostInfoModel : NSObject

@property (nonatomic, strong) UserInfoModel *User;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Content;
@property (nonatomic, strong) NSArray *PostReplyArr; //里面应该存储的是postReplyModel

@end
