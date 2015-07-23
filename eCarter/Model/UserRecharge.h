//
//  UserRecharge.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRecharge : NSObject

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger discountAmount;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *payStyle;


@end
