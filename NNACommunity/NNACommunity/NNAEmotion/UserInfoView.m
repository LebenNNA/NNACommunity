//
//  UserInfoView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/8.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "UserInfoView.h"

#define HeadIV_Margin_t 10
#define HeadIV_w 40

@interface UserInfoView ()

@end

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _headIV = [UIImageView new];
        [self addSubview:_headIV];
        
        _nameL = [UILabel new];
        [self addSubview:_nameL];
        
        _lvL = [UILabel new];
        [_lvL setTextColor:[UIColor whiteColor]];
        [self addSubview:_lvL];
        
        _masterL = [UILabel new];
        [_masterL setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:_masterL];
        
        _dateL = [UILabel new];
        [self addSubview:_dateL];
        
        _cityL = [UILabel new];
        [self addSubview:_cityL];
        
        _floorL = [UILabel new];
        [self addSubview:_floorL];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    [_headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(HeadIV_Margin_t);
        make.left.equalTo(self).with.offset(HeadIV_Margin_t);
        make.width.mas_equalTo(HeadIV_w);
        make.height.mas_equalTo(HeadIV_w);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(HeadIV_Margin_t);
        make.left.equalTo(_headIV.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_headIV).multipliedBy(0.5);
    }];
    
    [_lvL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(HeadIV_Margin_t);
        make.left.equalTo(_nameL.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];
    
    [_masterL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(HeadIV_Margin_t);
        make.left.equalTo(_lvL.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];
    
    [_dateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameL.mas_bottom);
        make.left.equalTo(_headIV.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];
    
    [_cityL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameL.mas_bottom);
        make.left.equalTo(_dateL.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];

}

- (void)setUserInfoWithModel:(UserInfoModel *)model {
    [_headIV setImage:[UIImage imageNamed:model.Head]];
    [_nameL setText:model.Name];
    if (model.isMall) {
        [_lvL setBackgroundColor:[UIColor blueColor]];
    } else {
        [_lvL setBackgroundColor:[UIColor purpleColor]];
    }
    [_lvL setText:model.Level];
    if (model.isMaster) {
        [_masterL setText:@"楼主"];
    } else {
        [_masterL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    [_dateL setText:model.Date];
    [_cityL setText:model.Place];
}

@end
