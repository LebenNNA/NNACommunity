//
//  UserInfoModel.h
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

/** 用户信息modle */

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface UserInfoModel : NSObject

@property (nonatomic, strong) NSString *Head;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Level;
@property (nonatomic, strong) NSString *Date;
@property (nonatomic, strong) NSString *Place;
@property (nonatomic, assign) BOOL isMale;
@property (nonatomic, assign) BOOL isMaster;

- (id)initWithIsMaster:(BOOL)isMaster;

@end
