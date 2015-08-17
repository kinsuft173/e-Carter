//
//  NetworkManager.h
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewworkConfig.h"
#import "FakeDataMgr.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "global.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD.h"

@interface NetworkManager : NSObject

+ (NetworkManager*)shareMgr;

//登陆注册
- (void)server_loginWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_genCodeWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_registerWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_logoutWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

- (NSString*)server_GetIdentyCode:(NSMutableDictionary*)dic url:(NSString*)ctUrl;

//首页
- (void)server_infoWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_allCouponListWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryCouponWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryStoreListWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryStoreDetailWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryStoreServiceTimeWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_saveOrderPayWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_fetchQueryUserCouponList:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//用户部分
- (void)server_queryOrderListWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryOrderDetailWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryOrderLogWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_updateOrderStatusWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_EditUserInfo:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

- (void)server_queryCarDetails:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

- (void)server_queryCarLists:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_submitOrderReviewsWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryUserAccountWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryUserRechargeWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_submitRechargeInfoWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryUserCarWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_addCarWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//车系
- (void)server_queryCarBrandWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_queryCarSeriesWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//地址
- (void)server_queryUserAddressWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_addUserAddressWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//积分
- (void)server_queryPointTransactionWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//广告
- (void)server_fetchAdvertisementWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

@end
