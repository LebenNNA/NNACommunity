//
//  NNAEmoBoard.h
//  NNACommunity
//
//  Created by NNA on 16/3/2.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmoBoardDelegate <NSObject>

@optional

- (void)textViewDidChange:(UITextView *)textView;
- (void)textFieldDidChange:(UITextField *)textField;

@end

@interface NNAEmoBoard : UIView <UIScrollViewDelegate> {
    UIScrollView *_emoView;
    UIPageControl *_pageControl;
    NSDictionary *_emoMap;
}


@property (nonatomic, weak) id<EmoBoardDelegate> delegate;

//适用于UITextField \ UITextView
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UITextView *inputTextView;


- (void)deleteEmo;

@end
