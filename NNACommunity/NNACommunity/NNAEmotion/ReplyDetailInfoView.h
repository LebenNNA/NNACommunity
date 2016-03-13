//
//  ReplyDetailInfoView.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/13.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyUserInfoView.h"

@interface ReplyDetailInfoView : UIView

@property (nonatomic, strong) ReplyUserInfoView *userV;

- (void)setReplyText:(NSString *)text;

@end
