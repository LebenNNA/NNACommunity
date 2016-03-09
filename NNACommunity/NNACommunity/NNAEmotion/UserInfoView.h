//
//  UserInfoView.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/8.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "NNAEmoUnit.h"
#import "UserInfoModel.h"

@interface UserInfoView : UIView

@property (nonatomic, strong) UIImageView *headIV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *lvL;
@property (nonatomic, strong) UILabel *masterL;
@property (nonatomic, strong) UILabel *dateL;
@property (nonatomic, strong) UILabel *cityL;
@property (nonatomic, strong) UILabel *floorL;

- (void)setUserInfoWithModel:(UserInfoModel *)model;

@end
