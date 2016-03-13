//
//  ReplyDetailInfoView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/13.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ReplyDetailInfoView.h"
#import "SJRichLabel.h"

#define UserV_h 60
#define Defualt_Margin_t 10

@interface ReplyDetailInfoView ()

@property (nonatomic, strong) SJEmojiLabel *replyL;
@property (nonatomic, assign) BOOL isReply;

@end

@implementation ReplyDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _userV = [[ReplyUserInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, UserV_h)];
        [self addSubview:_userV];
        
        _replyL = [SJEmojiLabel new];
        [self addSubview:_replyL];
        [_replyL setFont:[UIFont systemFontOfSize:15]];
        _replyL.numberOfLines = 0;
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [_replyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userV.mas_bottom);
        make.left.equalTo(self).with.offset(6*Defualt_Margin_t);
        make.right.equalTo(self).with.offset(-Defualt_Margin_t);
        make.height.mas_equalTo(100);
    }];
}

- (void)setReplyText:(NSString *)text {
    _replyL.text = text;
    CGSize replySize = [self getAttributeSizeWithString:text width:(SCREEN_W-7*Defualt_Margin_t) font:_replyL.font];
    [_replyL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(replySize.height);
    }];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, replySize.height+UserV_h+2*Defualt_Margin_t)];
    UILabel *lineL = [UILabel new];
    [self addSubview:lineL];
    [lineL setBackgroundColor:[UIColor blackColor]];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-1);
        make.left.equalTo(self).with.offset(6*Defualt_Margin_t);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

//宽度固定算高
- (CGSize)getAttributeSizeWithString:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, text.length)];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    CGSize size = [SJEmojiLabel sizeThatFitsAttributedString:attrString withConstraints:CGSizeMake(width, MAXFLOAT) limitedToNumberOfLines:0];
    return size;
}


@end
