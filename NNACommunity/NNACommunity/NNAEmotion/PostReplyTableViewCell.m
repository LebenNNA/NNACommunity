//
//  PostReplyTableViewCell.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/12.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostReplyTableViewCell.h"
#import "SJRichLabel.h"
#import "Masonry.h"

@interface PostReplyTableViewCell ()

@property (nonatomic, strong) SJRichLabel *contentL;

@end

@implementation PostReplyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        _contentL = [SJRichLabel new];
        _contentL.numberOfLines = 0;
        [self.contentView addSubview:_contentL];
        
        __weak typeof (self) wself = self;
        [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wself.contentView).with.offset(5);
            make.left.equalTo(wself.contentView).with.offset(60);
            make.right.equalTo(wself.contentView).with.offset(-10);
            make.bottom.equalTo(wself.contentView).with.offset(-5);
        }];
    }
    return self;
}

- (void)setContentWithModel:(ReplyContentModel *)model {
    _contentL.text = [NSString stringWithFormat:@"%@：%@", model.User.Name, model.Content];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
