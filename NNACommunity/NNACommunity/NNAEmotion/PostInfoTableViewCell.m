//
//  PostInfoTableViewCell.m
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostInfoTableViewCell.h"
#import "SJRichLabel.h"

#define UserV_h 60

@interface PostInfoTableViewCell ()

@property (nonatomic, strong) UILabel *floorL;
@property (nonatomic, strong) SJEmojiLabel *replyL;

@end

@implementation PostInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        _userV = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, UserV_h)];
//        [_userV setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_userV];
        _cellH = CGRectGetMaxY(_userV.frame);
        
        _floorL = [UILabel new];
        [_floorL setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_floorL];
        
        _replyL = [SJEmojiLabel new];
        _replyL.font = [UIFont systemFontOfSize:15];
        _replyL.numberOfLines = 0;
//        [_replyL setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_replyL];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    [_replyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userV.mas_bottom);
        make.left.equalTo(self.contentView).with.offset(60);
        make.bottom.equalTo(self.contentView).with.offset(-10);
        make.width.mas_equalTo(SCREEN_W-70);
    }];
}

- (void)setFloorNumber:(NSInteger)row {
    [_floorL setText:[NSString stringWithFormat:@"%ldF", (long)row]];
}

- (void)setReplyText:(NSString *)text {
    _replyL.text = text;
//    CGFloat replyH = [self getAttributeSizeWithString:text width:SCREEN_W-70 font:_replyL.font].height;
//    [_replyL mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(replyH);
//    }];
//    _cellH += replyH + 10;
//    return _cellH;
    
}

//宽度固定算高
- (CGSize)getAttributeSizeWithString:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, text.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, text.length)];
    CGSize size = [SJEmojiLabel sizeThatFitsAttributedString:attrString withConstraints:CGSizeMake(width, MAXFLOAT) limitedToNumberOfLines:0];
    return size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
