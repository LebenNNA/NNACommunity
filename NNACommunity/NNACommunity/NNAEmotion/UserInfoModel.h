//
//  UserInfoModel.h
//  NNACommunity
//
//  Created by NNA on 16/3/9.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, strong) NSString *Head;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Level;
@property (nonatomic, strong) NSString *Date;
@property (nonatomic, strong) NSString *Place;
@property (nonatomic, assign) BOOL isMall;
@property (nonatomic, assign) BOOL isMaster;

- (id)initWithIsMaster:(BOOL)isMaster;

@end
