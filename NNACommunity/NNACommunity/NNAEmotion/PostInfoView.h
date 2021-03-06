//
//  PostInfoView.h
//  NNACommunity
//
//  Created by Leben.NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "SJEmojiLabel.h"
#import "UserInfoView.h"
#import "PostInfoModel.h"

@interface PostInfoView : UIView

- (CGFloat)setContentWithModel:(PostInfoModel *)model;
- (CGFloat)setImagesWithArray:(NSArray *)array;

@end
