//
//  ViewController.m
//  NNACommunity
//
//  Created by NNA on 16/3/1.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static inline NSRegularExpression * NameRegularExpression() {
    static NSRegularExpression *_nameRegularExpression = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nameRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"^\\w+" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    return _nameRegularExpression;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidHide:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
        
        _isFirstShowKeyboard = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Emoji Label & keyboard";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    SJEmojiLabel *titleLabel = [[SJEmojiLabel alloc] initWithFrame:CGRectMake(10, 74, self.view.frame.size.width - 20, 20)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = [UIFont systemFontOfSize:15];
//    titleLabel.text = @"[大兵] [大兵]I am Soldier[大兵][大兵]";
//    [self.view addSubview:titleLabel];
    
    [self constructView];
    [self constructKeyBoardView];
    
//    [self richText];
    
}


- (void)constructView{
//    _contentLabel = [[SJEmojiLabel alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 300)];
//    _contentLabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.1];
//    _contentLabel.textAlignment = NSTextAlignmentLeft;
//    _contentLabel.font = [UIFont systemFontOfSize:18];
//    _contentLabel.delegate = self; //打开链接
//    [self.view addSubview:_contentLabel];
}

- (void)constructKeyBoardView{
    _toolBar = [[UIView alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 100)];
    _toolBar.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.6];
    [self.view addSubview:_toolBar];
    
    _keyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _keyboardButton.frame = CGRectMake(10, 10, 32, 32);
    [_keyboardButton setImage:[UIImage imageNamed:@"keyBoardBtn"] forState:UIControlStateNormal];
    [_keyboardButton addTarget:self action:@selector(keyboardClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_keyboardButton];
    
    _imageBoardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBoardButton.frame = CGRectMake(10, 62, 32, 32);
    [_imageBoardButton setImage:[UIImage imageNamed:@"imageBoardBtn"] forState:UIControlStateNormal];
    [_imageBoardButton addTarget:self action:@selector(imageBoardClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_imageBoardButton];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(_toolBar.frame.size.width - 50, 10, 45, 35);
    [_sendButton addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_sendButton.layer setCornerRadius:6];
    [_sendButton.layer setMasksToBounds:YES];
    [_sendButton setTitle:@"send" forState:UIControlStateNormal];
    [_sendButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [_toolBar addSubview:_sendButton];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(52, 10, _toolBar.frame.size.width - 52 - 60, _toolBar.frame.size.height - 20)];
    [_textView.layer setCornerRadius:6];
    [_textView.layer setMasksToBounds:YES];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.delegate = self;
    [_toolBar addSubview:_textView];
    
    [self constructEmojiBoard];
//    [self constructImageBoard];
}

- (void)constructEmojiBoard {
    _emoBoard = [[NNAEmoBoard alloc] init];
    _emoBoard.delegate = self;
    _emoBoard.inputTextView = _textView;
}

- (void)keyboardClick{
    _isButtonClicked = YES;
    
    if (_isBoardShowing) {
        [_textView resignFirstResponder];
    } else {
        if (_isFirstShowKeyboard) {
            _isFirstShowKeyboard = NO;
            _isKeyBoardShow = NO;
        }
        
        if (!_isKeyBoardShow) {
            _textView.inputView = _emoBoard;
        }
        
        [_textView becomeFirstResponder];
    }
}

- (void)sendBtnAction {
    _textView.text = @"";
    [self textViewDidChange:_textView];
    
    [_textView resignFirstResponder];
    
    _isFirstShowKeyboard = YES;
    _isButtonClicked = NO;
    
    _textView.inputView = nil;
    
    [_keyboardButton setImage:[UIImage imageNamed:@"emojiBoardBtn"]
                     forState:UIControlStateNormal];
}


#pragma mark - NSNotification
- (void)keyboardWillShow:(NSNotification *)notification {
    _isBoardShowing = YES;
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = _toolBar.frame;
                         frame.origin.y += _keyboardHeight;
                         frame.origin.y -= keyboardRect.size.height;
                         _toolBar.frame = frame;
                         
                         _keyboardHeight = keyboardRect.size.height;
                     }];
    
    if (_isFirstShowKeyboard) {
        _isFirstShowKeyboard = NO;
        _isKeyBoardShow = !_isButtonClicked;
    }
    
    if (_isKeyBoardShow ) {
        [_keyboardButton setImage:[UIImage imageNamed:@"keyBoardBtn"]
                         forState:UIControlStateNormal];
    } else {
        [_keyboardButton setImage:[UIImage imageNamed:@"emojiBoardBtn"]
                         forState:UIControlStateNormal];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = _toolBar.frame;
                         frame.origin.y += _keyboardHeight;
                         _toolBar.frame = frame;
                         
                         _keyboardHeight = 0;
                     }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    _isBoardShowing = NO;
    
    if (_isButtonClicked) {
        _isButtonClicked = NO;
        if (![_textView.inputView isEqual:_emoBoard] ) {
            _isKeyBoardShow = NO;
            _textView.inputView = _emoBoard;
        } else {
            _isKeyBoardShow = YES;
            _textView.inputView = nil;
        }
        [_textView becomeFirstResponder];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"textViewDidChange %@", textView.text);
    
//    _contentLabel.text = textView.text;
}


@end
