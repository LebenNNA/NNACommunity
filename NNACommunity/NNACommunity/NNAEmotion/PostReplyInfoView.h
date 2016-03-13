//
//  PostReplyInfoView.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/12.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"

@interface PostReplyInfoView : UIView

@property (nonatomic, strong) UserInfoView *userV;

- (void)setFloorNumber:(NSInteger)row;
- (void)setReplyText:(NSString *)text replyArr:(NSArray *)array;

@end
