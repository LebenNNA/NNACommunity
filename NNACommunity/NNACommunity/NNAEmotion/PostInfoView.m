//
//  PostInfoView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostInfoView.h"
#import "UserInfoModel.h"

#define UserV_h 60
#define TitleL_Margin_t 10

@interface PostInfoView ()

@property (nonatomic, strong) UserInfoView *userV;
@property (nonatomic, strong) SJEmojiLabel *titleL;
@property (nonatomic, strong) SJEmojiLabel *infoL;

@end

@implementation PostInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _userV = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, UserV_h)];
//        [_userV setBackgroundColor:[UIColor redColor]];
        [self addSubview:_userV];
        
        _titleL = [SJEmojiLabel new];
        _titleL.numberOfLines = 0;
        [_titleL setFont:[UIFont systemFontOfSize:30]];
//        [_titleL setBackgroundColor:[UIColor redColor]];
        [self addSubview:_titleL];
        
        _infoL = [SJEmojiLabel new];
        _infoL.numberOfLines = 0;
        [_infoL setFont:[UIFont systemFontOfSize:18]];
//        [_infoL setBackgroundColor:[UIColor grayColor]];
        _infoL.lineSpacing = 6;
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
        make.height.mas_equalTo(100);
    }];
    
    [_infoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleL.mas_bottom).with.offset(TitleL_Margin_t);
        make.left.equalTo(self).with.offset(TitleL_Margin_t);
        make.right.equalTo(self).with.offset(-TitleL_Margin_t);
        make.height.mas_equalTo(100);
    }];
    
}

- (CGFloat)setText {
    
    UserInfoModel *model = [[UserInfoModel alloc]initWithIsMaster:YES];
    [_userV setUserInfoWithModel:model];
    
    _titleL.text = @"【嘿嘿，夜深人静[淫笑]】";
    CGSize tH = [self stringLabelRectWithFont:[UIFont systemFontOfSize:30] textString:_titleL.text width:SCREEN_W-20];
    [_titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tH.height);
    }];
    
    NSString *text = @"对潇潇暮雨洒江天，一番洗清秋。\n[微笑]渐霜风凄紧，关河冷落，残照当楼。\n[微笑]是处红衰翠减，苒苒物华休。惟有长江水，无语东流。不忍登高临远，望故乡渺邈，归思难收。\n[微笑] 叹年来踪迹，何事苦淹留。[微笑] 想佳人、妆楼颙望，误几回、天际识归舟。争知我、倚阑干处，正恁凝愁 [微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑]";
    _infoL.text = text;
    
    CGSize iH = [self getAttributeSizeWithString:text width:SCREEN_W-20 font:_infoL.font];
    [_infoL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(iH.height);
    }];
    
    return (tH.height+iH.height+UserV_h+3*TitleL_Margin_t);

}

- (CGSize)stringLabelRectWithFont:(UIFont *)font textString:(NSString *)string width:(CGFloat)width {
    SJEmojiLabel *label = [[SJEmojiLabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = string;
    label.font = font;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    label.numberOfLines = 0;
    return size;
}

//宽度固定算高
- (CGSize)getAttributeSizeWithString:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.lineSpacing = 6;
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, text.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, text.length)];
    CGSize size = [SJEmojiLabel sizeThatFitsAttributedString:attrString withConstraints:CGSizeMake(width, MAXFLOAT) limitedToNumberOfLines:0];
    return size;
}


@end
