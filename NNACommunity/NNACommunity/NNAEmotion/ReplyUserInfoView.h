//
//  ReplyUserInfoView.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/13.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "NNAEmoUnit.h"
#import "UserInfoModel.h"

@interface ReplyUserInfoView : UIView

@property (nonatomic, strong) UIButton *irrigationBtn;

- (void)setUserInfoWithModel:(UserInfoModel *)model;
- (void)setFloor:(NSInteger)floor;

@end
