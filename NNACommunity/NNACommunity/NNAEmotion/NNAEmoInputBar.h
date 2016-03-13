//
//  NNAEmoInputBar.h
//  NNACommunity
//
//  Created by NNA on 16/3/3.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNAEmoUnit.h"

@interface NNAEmoInputBar : UIView

+ (instancetype)inputBar;

@property (nonatomic, assign) BOOL fitWhenKeyboardShowOrHide;

- (void)setDidSendClicked:(void(^)(NSString *text))handler;

@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, strong)UITextView *textView;

- (void)setInputBarSizeChangedHandle:(void(^)())handler;

@end
