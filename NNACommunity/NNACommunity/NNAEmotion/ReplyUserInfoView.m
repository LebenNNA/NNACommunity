//
//  ReplyUserInfoView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/13.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ReplyUserInfoView.h"

#define HeadIV_Margin_t 10
#define HeadIV_w 40

@interface ReplyUserInfoView ()

@property (nonatomic, strong) UIImageView *headIV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UIImageView *genderIV;
@property (nonatomic, strong) UILabel *masterL;
@property (nonatomic, strong) UILabel *floorL;
@property (nonatomic, strong) UILabel *dateL;

@end

@implementation ReplyUserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _headIV = [UIImageView new];
        [self addSubview:_headIV];
        
        _nameL = [UILabel new];
        [self addSubview:_nameL];
        
        _genderIV = [UIImageView new];
        [self addSubview:_genderIV];
        
        _masterL = [UILabel new];
        [_masterL setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:_masterL];
        
        _floorL = [UILabel new];
        [self addSubview:_floorL];
        
        _dateL = [UILabel new];
        [self addSubview:_dateL];
        
        _irrigationBtn = [UIButton new];
        [self addSubview:_irrigationBtn];
        
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
    
    [_genderIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(HeadIV_Margin_t);
        make.left.equalTo(_nameL.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];
    
    [_masterL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(HeadIV_Margin_t);
        make.left.equalTo(_genderIV.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameL.mas_bottom);
        make.left.equalTo(_headIV.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];
    
    [_dateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameL.mas_bottom);
        make.left.equalTo(_floorL.mas_right).with.offset(HeadIV_Margin_t);
        make.height.equalTo(_nameL);
    }];
    
}

- (void)setUserInfoWithModel:(UserInfoModel *)model {
    [_headIV setImage:[UIImage imageNamed:model.Head]];
    [_nameL setText:model.Name];
    if (model.isMale) {
        [_genderIV setImage:[UIImage imageNamed:@"Male"]];
    } else {
        [_genderIV setImage:[UIImage imageNamed:@"Female"]];
    }
    [_masterL setText:@"楼主"];
    [_dateL setText:model.Date];
}

- (void)setFloor:(NSInteger)floor {
    [_floorL setText:[NSString stringWithFormat:@"%ldF", (long)floor]];
}


@end
