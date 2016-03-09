//
//  UserInfoModel.m
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (id)initWithIsMaster:(BOOL)isMaster {
    if (isMaster) {
        _Name = @"夜深人不静";
        _Head = @"headPic";
        _Level = @"LV12";
        _Date = @"2016-01-01";
        _Place = @"上海市";
        _isMall = YES;
    } else {
        _Name = @"夜踹寡妇门";
        _Head = @"headPic@";
        _Level = @"LV10";
        _Date = @"2016-11-11";
        _Place = @"北京市";
        _isMall = NO;
    }
    _isMaster = isMaster;
    return self;
}

@end
