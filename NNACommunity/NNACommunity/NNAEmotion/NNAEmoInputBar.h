//
//  NNAEmoInputBar.h
//  NNACommunity
//
//  Created by NNA on 16/3/3.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNAEmoInputBar : UIView

+ (instancetype)inputBar;

@property (assign, nonatomic) BOOL fitWhenKeyboardShowOrHide;

- (void)setDidSendClicked:(void(^)(NSString *text))handler;

@property (copy, nonatomic) NSString *placeHolder;

- (void)setInputBarSizeChangedHandle:(void(^)())handler;

@end
