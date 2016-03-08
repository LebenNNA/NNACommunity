//
//  NNAEmoUnit.h
//  NNACommunity
//
//  Created by NNA on 16/3/2.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#ifndef NNAEmoUnit_h
#define NNAEmoUnit_h

#define COLOR_RGB(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//键盘背景颜色
#define EMOJBOARD_BG_COLOR COLOR_RGB(236.0, 236.0, 236.0, 1)
//pager颜色
#define CURRENTPAGE_COLOR COLOR_RGB(0, 0, 0, 0.5)
#define PAGE_COLOR COLOR_RGB(255.0, 255.0, 255.0, 1)

//inputbar颜色
#define INPUTBAR_BG_COLOR EMOJBOARD_BG_COLOR

#define SENDBTN_TITLE_N COLOR_RGB(206.0, 206.0, 206.0, 1)
#define SENDBTN_TITLE_Y COLOR_RGB(0.0, 0.0, 0.0, 1)

#define CLEAR_COLOR [UIColor clearColor]

#define SCREEN_W [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H [[UIScreen mainScreen] bounds].size.height

#endif /* NNAEmoUnit_h */
