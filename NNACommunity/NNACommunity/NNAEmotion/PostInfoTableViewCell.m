//
//  PostInfoTableViewCell.m
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostInfoTableViewCell.h"

@interface PostInfoTableViewCell ()

@end

@implementation PostInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        _priV = [PostReplyInfoView new];
        [self.contentView addSubview:_priV];
        
        __weak typeof (self) wself = self;
        [_priV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wself.contentView);
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
