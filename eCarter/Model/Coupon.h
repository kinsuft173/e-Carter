//
//  Coupon.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface Coupon : NSObject
//
//@property (nonatomic, copy) NSString *code;
//
//@property (nonatomic, copy) NSString *endTimeString;
//
//@property (nonatomic, copy) NSString *id;
//
//@property (nonatomic, copy) NSString *price;
//
//@property (nonatomic, copy) NSString *remark;
//
//@property (nonatomic, copy) NSString *startTimeString;
//
//@property (nonatomic, copy) NSString *state;
//
////@property (nonatomic, copy) NSString *storeName;
//
//
//@end



@interface CouponAll : NSObject


@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *couponcode;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *couponId;



@end


@interface CouponMyAll : NSObject



@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *startTimeString;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *endTimeString;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *state;




@end


@interface CouponMyToShop : NSObject



@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *startTimeString;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *endTimeString;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *state;



@end

