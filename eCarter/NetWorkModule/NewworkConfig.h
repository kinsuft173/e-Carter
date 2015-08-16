//
//  NewworkConfig.h
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#ifndef GSAPP_NewworkConfig_h
#define GSAPP_NewworkConfig_h


#define SERVER     @"http://119.29.0.81:8087/ecf/app"

#define SERVER_CAR     @"http://apis.haoservice.com"

#define SERVERADTEST    @"http://115.28.85.76/gaoshou/api/web/?r="
#define ISINTEST  NO

#pragma mark - 网络接口回调类型
typedef void (^CompleteHandle)(NSDictionary*);
typedef void (^ErrorHandle)(NSError*);

#pragma mark - 网络相关url

//test
#define ECATER_TEST_INTERFACE @""

//用户部分
#define ECATER_LOGIN_INTERFACE @"/ecar/mobile/code/login"
#define ECATER_GENCODE_INTERFACE @"/ecar/mobile/genCode"
#define ECATER_REGISTER_INTERFACE @"/ecar/mobile/register"
#define ECATER_LOGOUT_INTERFACE @"/ecar/mobile/logout"

//首页部分
#define ECATER_INFO_INTERFACE @"/api/user/info"
#define ECATER_AllCOUPON_LIST_INTERFACE @"/ecar/mobile/allCouponList"
#define ECATER_QUERY_COUPON_INTERFACE @"/ecar/mobile/queryCoupon"
#define ECATER_QUERY_STORE_LIST_INTERFACE @"/ecar/mobile/queryStoreList"
#define ECATER_QUERY_STROE_DETAIL_INTERFACE @"/ecar/mobile/queryStoreDetail"
#define ECATER_QUERY_STORE_SERVICETIME_INTERFACE @"/ecar/mobile/queryStoreServiceTime"
#define ECATER_SAVE_SERVICE_ORDER_INTERFACE @"/ecar/mobile/saveServiceOrder"
#define ECATER_SAVE_ORDER_PAY_INTERFACE @"/ecar/mobile/saveOrderPay"


#define ECATER_QUERY_ORDER_LIST_INTERFACE @"/ecar/mobile/queryOrderList"
#define ECATER_QUERY_ODERD_ETAIL_INTERFACE @"/ecar/mobile/queryOrderDetail"
#define ECATER_QUERY_ODER_LOG_INTERFACE @"/ecar/mobile/queryOrderLog"
#define ECATER_UPDATE_ORDER_STATUS_INTERFACE @"/ecar/mobile/updateOrderStatus"
#define ECATER_SUBMIT_ODERRE_VIEW_INTERFACE @"/ecar/mobile/submitOrderReviews"
#define ECATER_USER_ACCOUNT_INTERFACE @"/ecar/mobile/queryUserAccount"
#define ECATER_QUERY_USERRECHARGE_INTERFACE @"/ecar/mobile/queryUserRecharge"
#define ECATER_SUBMIT_RECHARGEINO_INTERFACE @"/ecar/mobile/submitRechargeInfo"
#define ECATER_QUERY_USER_CAR_INTERFACE @"/ecar/mobile/queryUserCar"
#define ECATER_ADD_CAR_INTERFACE @"/ecar/mobile/addCar"


#define ECATER_QUERY_CAR_BRAND_INTERFACE @"/ecar/mobile/queryCarBrand"
#define ECATER_QUERY_CAR_SERIES_INTERFACE @"/ecar/mobile/queryCarSeries"
#define ECATER_QUERY_CAR_LISTS_INTERFACE @"/ecar/mobile/queryCustomerCar"

#define ECATER_QUERY_CAR_LISTS @"/lifeservice/car/GetSeries"

#define ECATER_QUERY_CAR_DETAILS @"/lifeservice/car/GetModel/"


#define ECATER_QUERY_USER_ADDRESS_INTERFACE @"/ecar/mobile/queryUserAddress"
#define ECATER_ADD_USER_ADDRESS_INTERFACE @"/ecar/mobile/addUserAddress"

#define ECATER_POINT_TRANSACTION_INTERFACE @"/ecar/mobile/queryPointTransaction"

#define ECATER_QUERY_USER_COUPON @"/ecar/mobile/queryUserCoupon"

//广告部分
#define APP_AD_URL @"advertisement/index"


//#define ECATER_INFO_INTERFACE @""
//#define ECATER_INFO_INTERFACE @""


#endif
