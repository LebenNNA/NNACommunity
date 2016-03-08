//
//  PostInfoView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostInfoView.h"

#define UserV_h 60
#define TitleL_Margin_t 10

@interface PostInfoView ()

@property (nonatomic, strong) UserInfoView *userV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) SJEmojiLabel *infoL;

@end

@implementation PostInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _userV = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, UserV_h)];
        [self addSubview:_userV];
        
        _titleL = [UILabel new];
        _titleL.numberOfLines = 0;
        [self addSubview:_titleL];
        
        _infoL = [SJEmojiLabel new];
        [self addSubview:_infoL];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userV.mas_bottom).with.offset(TitleL_Margin_t);
        make.left.equalTo(self).with.offset(TitleL_Margin_t);
        make.right.equalTo(self).with.offset(-TitleL_Margin_t);
    }];
    
    [_infoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleL.mas_bottom).with.offset(TitleL_Margin_t);
        make.left.equalTo(self).with.offset(TitleL_Margin_t);
        make.right.equalTo(self).with.offset(-TitleL_Margin_t);
    }];
    
}


@end
