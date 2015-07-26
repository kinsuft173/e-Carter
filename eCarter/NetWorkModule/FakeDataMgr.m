//
//  FakeDataMgr.m
//  eCarter
//
//  Created by kinsuft173 on 15/7/25.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "FakeDataMgr.h"
#import "HKCommen.h"

@implementation FakeDataMgr

@synthesize responseRegister,responseLogin,responseInfo,responseAllCouponList,responseQueryCarBrand,responseQueryCarSeries,responseQueryCoupon;
@synthesize responseQueryOrderDetail,responseQueryOrderList,responseQueryOrderLog,responseQueryPointTransaction,responseQueryStoreDetail,responseQueryStoreList;
@synthesize responseQueryStoreServiceTime,responseQueryUserAccount,responseQueryUserAddress,responseQueryUserCar,responseQueryUserRecharge;

+ (FakeDataMgr*)shareMgr
{
    static FakeDataMgr* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[FakeDataMgr alloc] init];
        
    });
    
    return instance;
}

- (NSDictionary*)responseRegister
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"register" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseLogin
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"login" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseInfo
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"info" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}
- (NSDictionary*)responseAllCouponList
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"allCouponList" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}
- (NSDictionary*)responseQueryCarBrand
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryCarBrand" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}
- (NSDictionary*)responseQueryCarSeries
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryCarSeries" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryCoupon
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryCoupon" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryOrderDetail
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryOrderDetail" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryOrderList
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryOrderList" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryOrderLog
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryOrderLog" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}


- (NSDictionary*)responseQueryPointTransaction
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryPointTransaction" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}


- (NSDictionary*)responseQueryStoreDetail
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryStoreDetail" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryStoreList
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryStoreList" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryStoreServiceTime
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryStoreServiceTime" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryUserAccount
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryUserAccount" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryUserAddress
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryUserAddress" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryUserCar
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryUserCar" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}

- (NSDictionary*)responseQueryUserRecharge
{
    NSString* strJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"queryUserRecharge" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary* dic = [HKCommen dictionaryWithJsonString:strJson];
    
    return dic;
}


@end
