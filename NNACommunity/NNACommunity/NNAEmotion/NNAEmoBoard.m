//
//  NNAEmoBoard.m
//  NNACommunity
//
//  Created by NNA on 16/3/2.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "NNAEmoBoard.h"
#import "NNAEmoButton.h"

#define EMO_X_START 17
#define EMO_X_PADDING 15
#define EMO_Y_START 20
#define EMO_Y_PADDING 20

#define EMO_COUNT_ALL  51
#define EMO_COUNT_ROW  3
#define EMO_COUNT_CLU  7
#define EMO_COUNT_PAGE (EMO_COUNT_ROW * EMO_COUNT_CLU) //每页个数
#define EMO_ICON_SIZE floor(([[UIScreen mainScreen] bounds].size.width - EMO_X_START * 2 - EMO_X_PADDING * (EMO_COUNT_CLU - 1)) / EMO_COUNT_CLU) //28
#define EMO_PAGE_ALL (EMO_COUNT_ALL / EMO_COUNT_PAGE + 1) //共有多少页

@implementation NNAEmoBoard

- (void)dealloc {
    [self setDelegate:nil];
}

- (id)init {
    CGFloat with = [[UIScreen mainScreen] bounds].size.width;
    self = [super initWithFrame:CGRectMake(0, 0, with, 216)];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:236.0 / 255.0
                                               green:236.0 / 255.0
                                                blue:236.0 / 255.0
                                               alpha:1];
        
        _emoMap = [NSDictionary
                     dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                   pathForResource:@"EmojiMap"
                                                   ofType:@"plist"]];
        
        [self constructEmoView];
        [self layoutEmoView];
    }
    
    return self;
}

- (void)constructEmoView {
    //表情盘
    _emoView = [[UIScrollView alloc]
                  initWithFrame:CGRectMake(0, 0, self.frame.size.width, 190)];
    _emoView.pagingEnabled = YES;
    _emoView.contentSize = CGSizeMake(
                                        (EMO_COUNT_ALL / EMO_COUNT_PAGE + 1) * self.frame.size.width, 190);
    _emoView.showsHorizontalScrollIndicator = NO;
    _emoView.showsVerticalScrollIndicator = NO;
    _emoView.delegate = self;
    
    //添加PageControl
    _pageControl = [[UIPageControl alloc]
                    initWithFrame:CGRectMake(self.frame.size.width * 0.5 -
                                             EMO_PAGE_ALL * 20 * 0.5,
                                             self.frame.size.height - 15 - 20,
                                             EMO_PAGE_ALL * 20, 20)];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255.0 / 255.0
                                                          green:255.0 / 255.0
                                                           blue:255.0 / 255.0
                                                          alpha:1];
    _pageControl.currentPageIndicatorTintColor =
    [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.5];
    [_pageControl addTarget:self
                     action:@selector(pageChange:)
           forControlEvents:UIControlEventValueChanged];
    _pageControl.numberOfPages = EMO_PAGE_ALL;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    [self addSubview:_emoView];
}

- (void)layoutEmoView {
    int deleteBtnCount = 0;
    for (int i = 1; i <= EMO_COUNT_PAGE * EMO_PAGE_ALL; i++) {
        //计算每一个表情按钮的坐标和在哪一屏
        CGFloat x = (((i - 1) % EMO_COUNT_PAGE) % EMO_COUNT_CLU) *
        (EMO_ICON_SIZE + EMO_X_PADDING) +
        EMO_X_START +
        ((i - 1) / EMO_COUNT_PAGE * self.frame.size.width);
        CGFloat y = (((i - 1) % EMO_COUNT_PAGE) / EMO_COUNT_CLU) *
        (EMO_ICON_SIZE + EMO_Y_PADDING) +
        EMO_Y_START;
        
        //删除按钮
        if (i % EMO_COUNT_PAGE == 0) {
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
            [deleteBtn setImage:[UIImage imageNamed:@"deleteEmoji"]
                       forState:UIControlStateNormal];
            [deleteBtn setImage:[UIImage imageNamed:@"deleteEmoji_hl"]
                       forState:UIControlStateSelected];
            [deleteBtn addTarget:self
                          action:@selector(deleteEmo)
                forControlEvents:UIControlEventTouchUpInside];
            deleteBtn.frame = CGRectMake(x + 5, y + 10, 23, 21);
            [_emoView addSubview:deleteBtn];
            
            deleteBtnCount++;
            
            continue;
        }
        
        if (i > (EMO_COUNT_ALL + EMO_PAGE_ALL - 1)) {
            continue;
        }
        
        //表情
        NNAEmoButton *emoButton = [NNAEmoButton buttonWithType:UIButtonTypeCustom];
        emoButton.buttonIndex = i - deleteBtnCount;
        [emoButton addTarget:self
                        action:@selector(emoButton:)
              forControlEvents:UIControlEventTouchUpInside];
        emoButton.frame = CGRectMake(x, y, EMO_ICON_SIZE, EMO_ICON_SIZE);
        [emoButton
         setImage:[UIImage
                   imageNamed:[NSString stringWithFormat:@"emoji_%03d",
                               i - deleteBtnCount]]
         forState:UIControlStateNormal];
        [_emoView addSubview:emoButton];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pageControl
     setCurrentPage:_emoView.contentOffset.x / self.frame.size.width];
    [_pageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {
    [_emoView
     setContentOffset:CGPointMake(
                                  _pageControl.currentPage * self.frame.size.width, 0)
     animated:YES];
    [_pageControl setCurrentPage:_pageControl.currentPage];
}

- (void)emoButton:(id)sender {
    int i = (int)((NNAEmoButton *)sender).buttonIndex;
    if (_inputTextField) {
        
        NSMutableString *emoString =
        [[NSMutableString alloc] initWithString:_inputTextField.text];
        [emoString
         appendString:[_emoMap
                       objectForKey:[NSString stringWithFormat:@"%03d", i]]];
        _inputTextField.text = emoString;
        
    } else if (_inputTextView) {
        NSMutableString *emoString =
        [[NSMutableString alloc] initWithString:_inputTextView.text];
        [emoString
         insertString:[_emoMap
                       objectForKey:[NSString stringWithFormat:@"%03d", i]]
         atIndex:_inputTextView.selectedRange.location];
        _inputTextView.text = emoString;
        
        if (_delegate &&
            [_delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [_delegate textViewDidChange:_inputTextView];
        }
    }
}

- (void)deleteEmo {
    NSString *inputString;
    inputString = _inputTextField.text;
    if (_inputTextView) {
        inputString = _inputTextView.text;
    }
    
    NSString *string = nil;
    NSInteger stringLength = inputString.length;
    if (stringLength > 0) {
        if ([@"]" isEqualToString:[inputString
                                   substringFromIndex:stringLength - 1]]) {
            if ([inputString rangeOfString:@"["].location == NSNotFound) {
                string = [inputString substringToIndex:stringLength - 1];
            } else {
                string = [inputString
                          substringToIndex:[inputString rangeOfString:@"["
                                                              options:NSBackwardsSearch]
                          .location];
            }
        } else {
            string = [inputString substringToIndex:stringLength - 1];
        }
    }
    
    if (_inputTextField) {
        _inputTextField.text = string;
        
    } else if (_inputTextView) {
        _inputTextView.text = string;
        
        if (_delegate &&
            [_delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [_delegate textViewDidChange:_inputTextView];
        }
    }
}


@end
