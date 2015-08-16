//
//  Coupon.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coupon : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *endTimeString;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *startTimeString;

@property (nonatomic, copy) NSString *state;


@end
