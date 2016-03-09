//
//  PostInfoTableViewCell.m
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostInfoTableViewCell.h"
#import "UserInfoView.h"

#define UserV_h 60

@interface PostInfoTableViewCell ()

@property (nonatomic, strong) UserInfoView *userV;

@end

@implementation PostInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userV = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, UserV_h)];
        [_userV setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_userV];

        [self layoutPageSubviews];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)layoutPageSubviews {
    
}

@end
