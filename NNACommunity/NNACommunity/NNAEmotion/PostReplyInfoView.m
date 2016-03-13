//
//  PostReplyInfoView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/12.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostReplyInfoView.h"
#import "SJRichLabel.h"
#import "ReplyContentModel.h"

#define UserV_h 60

@interface PostReplyInfoView () {
    NSMutableArray *labelArr;
}

@property (nonatomic, strong) UILabel *floorL;
@property (nonatomic, strong) SJEmojiLabel *replyL;
@property (nonatomic, assign) BOOL isReply;

@end

@implementation PostReplyInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _userV = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, UserV_h)];
        [self addSubview:_userV];
        
        _floorL = [UILabel new];
        [_floorL setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_floorL];
        
        _replyL = [SJEmojiLabel new];
        _replyL.font = [UIFont systemFontOfSize:15];
        _replyL.numberOfLines = 0;
        [self addSubview:_replyL];

        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    [_replyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userV.mas_bottom);
        make.left.equalTo(self).with.offset(60);
        make.right.equalTo(self).with.offset(-10);
        //        make.width.mas_equalTo(SCREEN_W-70);
    }];
}

- (void)setFloorNumber:(NSInteger)row {
    [_floorL setText:[NSString stringWithFormat:@"%ldF", (long)row]];
}


- (void)setReplyText:(NSString *)text replyArr:(NSArray *)array{
    _replyL.text = text;
    if (!_isReply) {
        _isReply = YES;
        if (array.count>0) {
            UILabel *lineL = [UILabel new];
            [lineL setBackgroundColor:[UIColor blackColor]];
            [self addSubview:lineL];
            [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyL.mas_bottom).with.offset(10);
                make.left.equalTo(self).with.offset(60);
                make.right.equalTo(self).with.offset(-10);
                make.height.mas_equalTo(1);
            }];
            
            labelArr = [[NSMutableArray alloc] initWithCapacity:0];
            __block SJRichLabel *lab = [[SJRichLabel alloc]init];
            __weak typeof(self) weakself = self;
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (idx<3) {
                    SJRichLabel *label = [SJRichLabel new];
                    if (idx==2) {
                        label.text = [NSString stringWithFormat:@"更多%lu条评论", (array.count-2)];
                    } else {
                        ReplyContentModel *model = array[idx];
                        label.text = [NSString stringWithFormat:@"%@:%@",model.User.Name , model.Content];
                    }
                    [weakself addSubview:label];
                    label.numberOfLines = 0;
                    [labelArr addObject:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        if (idx == 0) {
                            make.top.equalTo(lineL.mas_bottom).with.offset(10);
                        } else {
                            lab = labelArr[idx-1];
                            make.top.equalTo(lab.mas_bottom).with.offset(10);
                        }
                        make.left.equalTo(weakself).with.offset(60);
                        make.right.equalTo(weakself).with.offset(-10);
                        if ((idx == array.count)||(idx == 2)) {
                            make.bottom.equalTo(weakself).with.offset(-10);
                        }
                    }];
                    
                } else {
                    *stop = YES;
                }
            }];
        } else {
            [_replyL mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).with.offset(-10);
            }];
        }
        
    }
    [self layoutIfNeeded];
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
