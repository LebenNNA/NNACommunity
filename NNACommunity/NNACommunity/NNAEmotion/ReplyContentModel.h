//
//  ReplyContentModel.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/12.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface ReplyContentModel : NSObject

@property (nonatomic, strong) UserInfoModel *User;
@property (nonatomic, strong) NSString *Content;

@end
