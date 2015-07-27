//
//  FakeDataMgr.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/25.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeDataMgr : NSObject

+ (FakeDataMgr*)shareMgr;

@property (nonatomic, strong) NSDictionary* responseRegister;
@property (nonatomic, strong) NSDictionary* responseLogin;
@property (nonatomic, strong) NSDictionary* responseInfo;
@property (nonatomic, strong) NSDictionary* responseAllCouponList;
@property (nonatomic, strong) NSDictionary* responseQueryCarBrand;
@property (nonatomic, strong) NSDictionary* responseQueryCarSeries;
@property (nonatomic, strong) NSDictionary* responseQueryCoupon;
@property (nonatomic, strong) NSDictionary* responseQueryOrderDetail;
@property (nonatomic, strong) NSDictionary* responseQueryOrderList;
@property (nonatomic, strong) NSDictionary* responseQueryOrderLog;
@property (nonatomic, strong) NSDictionary* responseQueryPointTransaction;
@property (nonatomic, strong) NSDictionary* responseQueryStoreDetail;
@property (nonatomic, strong) NSDictionary* responseQueryStoreList;
@property (nonatomic, strong) NSDictionary* responseQueryStoreServiceTime;
@property (nonatomic, strong) NSDictionary* responseQueryUserAccount;
@property (nonatomic, strong) NSDictionary* responseQueryUserAddress;
@property (nonatomic, strong) NSDictionary* responseQueryUserCar;
@property (nonatomic, strong) NSDictionary* responseQueryUserRecharge;


@end
