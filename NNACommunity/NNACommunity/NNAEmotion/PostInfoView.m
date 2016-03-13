//
//  PostInfoView.m
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "PostInfoView.h"
#import "SDPhotoBrowser.h"
//#import "UIButton+WebCache.h"

#define UserV_h 60
#define TitleL_Margin_t 10

@interface PostInfoView () <SDPhotoBrowserDelegate> {
    float HH;
    NSArray *picArr;
    UIView *picBgView;
}

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

- (CGFloat)setContentWithModel:(PostInfoModel *)model {
    [_userV setUserInfoWithModel:model.User];
    _titleL.text = model.Title;
    CGSize tH = [self stringLabelRectWithFont:[UIFont systemFontOfSize:30] textString:_titleL.text width:SCREEN_W-20];
    [_titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tH.height);
    }];
    
    NSString *text = model.Content;
    text = [text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    _infoL.text = text;
    
    CGSize iH = [self getAttributeSizeWithString:text width:(SCREEN_W-20) font:_infoL.font];
    [_infoL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(iH.height);
    }];
    HH = (tH.height+iH.height+UserV_h+3*TitleL_Margin_t);
    
    return HH;

}

- (CGFloat)setImagesWithArray:(NSArray *)array {
    if (array.count>0) {
        picArr = array;
        picBgView = [[UIView alloc]initWithFrame:CGRectMake(0, HH, SCREEN_W, 100)];
        [self addSubview:picBgView];
        __block CGFloat hh = 0;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, hh, SCREEN_W, 100)];
//            [picBtn sd_setImageWithURL:[NSURL URLWithString:array[idx]] forState:UIControlStateNormal];
            [picBtn setBackgroundImage:[UIImage imageNamed:array[idx]] forState:UIControlStateNormal];
            picBtn.tag = idx;
            [picBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            HH += 110;
            hh += 110;
            [picBgView addSubview:picBtn];
        }];
    }
    [picBgView setFrame:CGRectMake(0, picBgView.frame.origin.y, SCREEN_W, HH-picBgView.frame.origin.y)];
    return HH;
}

- (void)buttonClick:(UIButton *)sender {
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = picBgView; // 原图的父控件
    browser.imageCount = picArr.count; // 图片总数
    browser.currentImageIndex = sender.tag;
    browser.delegate = self;
    [browser show];
    
}

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return [UIImage imageNamed:picArr[index]];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
//    NSString *urlStr = [[self.photoItemArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return nil;
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
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    CGSize size = [SJEmojiLabel sizeThatFitsAttributedString:attrString withConstraints:CGSizeMake(width, MAXFLOAT) limitedToNumberOfLines:0];
    return size;
}


@end
