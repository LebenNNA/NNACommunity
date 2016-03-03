//
//  KBViewController.h
//  NNACommunity
//
//  Created by NNA on 16/3/1.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNAEmoBoard.h"
//#import "SJEmojiLabel.h"
//#import "SJRichLabel.h"

@interface KBViewController : UIViewController <UITextViewDelegate, EmoBoardDelegate> {
    UIView *_toolBar;
    UITextView *_textView;
    UIButton *_keyboardButton;
    UIButton *_sendButton;
    
    BOOL _isFirstShowKeyboard;
    BOOL _isButtonClicked;
    BOOL _isBoardShowing;
    
    BOOL _isKeyBoardShow;
    
    BOOL _isEmojiBoardShow;
    BOOL _isImageBoardShow;
    
    CGFloat _keyboardHeight;
    NNAEmoBoard *_emoBoard;
    UIView *_imageBoard;
    
//    SJEmojiLabel *_contentLabel;
}

@end

