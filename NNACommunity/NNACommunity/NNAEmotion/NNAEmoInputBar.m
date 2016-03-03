//
//  NNAEmoInputBar.m
//  NNACommunity
//
//  Created by NNA on 16/3/3.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "NNAEmoInputBar.h"
#import "NNAEmoBoard.h"

#define DEFUALT_HEIGHT 44
#define LEFT_BUTTON_WIDTH 50
#define LEFT_BUTTON_HEIGHT 30
#define RIGHT_BUTTON_WIDTH 55
#define TEXTVIEW_DEFUALT_HEIGHT 34
#define TEXTVIEW_MAX_HEIGHT 80

@interface NNAEmoInputBar () <UITextViewDelegate, EmoBoardDelegate> {
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
    
}

@property (strong, nonatomic) void (^sendDidClickedHandler)(NSString *);
@property (strong, nonatomic) void (^sizeChangedHandler)();

@end

@implementation NNAEmoInputBar

+ (instancetype)inputBar{
    return [self new];
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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, DEFUALT_HEIGHT)]){
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
        [self layoutPageSubviews];

    }
    return self;
}


- (void)layoutPageSubviews{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    _keyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _keyboardButton.frame = CGRectMake(0.0f, (DEFUALT_HEIGHT-LEFT_BUTTON_HEIGHT)/2, LEFT_BUTTON_WIDTH, LEFT_BUTTON_HEIGHT);
    [_keyboardButton setImage:[UIImage imageNamed:@"keyBoardBtn"] forState:UIControlStateNormal];
    [_keyboardButton addTarget:self action:@selector(keyboardClick) forControlEvents:UIControlEventTouchUpInside];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(LEFT_BUTTON_WIDTH, (DEFUALT_HEIGHT-TEXTVIEW_DEFUALT_HEIGHT)/2, CGRectGetWidth(self.frame)-LEFT_BUTTON_WIDTH-RIGHT_BUTTON_WIDTH, TEXTVIEW_DEFUALT_HEIGHT)];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.tintColor = [UIColor whiteColor];
    _textView.scrollEnabled = NO;
    _textView.showsVerticalScrollIndicator = NO;
    [_textView.layer setCornerRadius:6];
    [_textView.layer setMasksToBounds:YES];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.delegate = self;
    
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(self.frame.size.width-RIGHT_BUTTON_WIDTH, 0, RIGHT_BUTTON_WIDTH, DEFUALT_HEIGHT);
    [_sendButton addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_sendButton.layer setCornerRadius:6];
    [_sendButton.layer setMasksToBounds:YES];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.3] forState:UIControlStateDisabled];
    [_sendButton setTitleEdgeInsets:UIEdgeInsetsMake(2.50f, 0.0f, 0.0f, 0.0f)];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:19];
    _sendButton.enabled = NO;
    
    [self addSubview:_keyboardButton];
    [self addSubview:_textView];
    [self addSubview:_sendButton];
    [self constructEmojiBoard];
    
}

- (void)constructEmojiBoard {
    _emoBoard = [[NNAEmoBoard alloc] init];
    _emoBoard.delegate = self;
    _emoBoard.inputTextView = _textView;
}

- (void)barLayout {
    
    _sendButton.enabled = ![@"" isEqualToString:_textView.text];
    
    CGRect textViewFrame = _textView.frame;
    CGSize textSize = [_textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    
    CGFloat offset = 10;
    _textView.scrollEnabled = (textSize.height > TEXTVIEW_MAX_HEIGHT-offset);
    textViewFrame.size.height = MAX(TEXTVIEW_DEFUALT_HEIGHT, MIN(TEXTVIEW_MAX_HEIGHT, textSize.height));
    _textView.frame = textViewFrame;
    
    CGRect addBarFrame = self.frame;
    CGFloat maxY = CGRectGetMaxY(addBarFrame);
    addBarFrame.size.height = textViewFrame.size.height+offset;
    addBarFrame.origin.y = maxY-addBarFrame.size.height;
    self.frame = addBarFrame;
    
    _keyboardButton.center = CGPointMake(CGRectGetMidX(_keyboardButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
    _sendButton.center = CGPointMake(CGRectGetMidX(_sendButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
    
    if (self.sizeChangedHandler){
        self.sizeChangedHandler();
    }
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
    if (_sendDidClickedHandler){
        _sendDidClickedHandler(_textView.text);
        _textView.text = @"";
        [self textViewDidChange:_textView];
        [_textView resignFirstResponder];
        _isFirstShowKeyboard = YES;
        _isButtonClicked = NO;
        _textView.inputView = nil;
        [_keyboardButton setImage:[UIImage imageNamed:@"emojiBoardBtn"]
                         forState:UIControlStateNormal];
    }
}


#pragma mark - NSNotification
- (void)keyboardWillShow:(NSNotification *)notification {
    _isBoardShowing = YES;
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize kbSize = [aValue CGRectValue].size;
    
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         CGRect newInputBarFrame = self.frame;
                         newInputBarFrame.origin.y = [UIScreen mainScreen].bounds.size.height-CGRectGetHeight(self.frame)-kbSize.height;
                         self.frame = newInputBarFrame;
                     }
                     completion:nil];
    
    
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
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.center = CGPointMake(self.bounds.size.width/2.0f, height-CGRectGetHeight(self.frame)/2.0);
                     }
                     completion:nil];
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

- (void)setDidSendClicked:(void (^)(NSString *))handler{
    _sendDidClickedHandler = handler;
}

- (void)setInputBarSizeChangedHandle:(void (^)())handler{
    _sizeChangedHandler = handler;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self barLayout];
    NSLog(@"textViewDidChange %@", textView.text);
    
}

@end
