//
//  PostInfoTableViewCell.h
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"

@interface PostInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UserInfoView *userV;
@property (nonatomic, assign) CGFloat cellH;

- (void)setFloorNumber:(NSInteger)row;
- (void)setReplyText:(NSString *)text;

@end
