//
//  Coupon.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coupon : NSObject


@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *couponDescription;

@property (nonatomic, copy) NSString *couponName;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *couponLink;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *createTime;


@end
