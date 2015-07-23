//
//  NewworkConfig.h
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#ifndef GSAPP_NewworkConfig_h
#define GSAPP_NewworkConfig_h


#define SERVER    @"http://115.28.85.76/gaoshou/api/web/?r="

#pragma mark - 网络接口回调类型
typedef void (^CompleteHandle)(NSDictionary*);


#pragma mark - 网络相关url

//用户部分
#define USER_REGESTER_URL @"user/create"
#define USER_FETCH_URL @"user/view"   
#define USER_UPDATE_URL @"user/update"  

//广告部分
#define APP_AD_URL @"advertisement/index"

//医生
#define DOCTOR_FETCH_URL @"doctor/index"

//咨询问诊
#define CONSULATION_CREATE_URL @"consultation/create"
#define CONSULATION_FETCH_URL @"consultation/index"

//订单创建
#define ORDER_CREATE_URL @"order/create"
#define ORDER_FETCH_URL @"order/index"
#define ORDER_UPDATE_URL @"order/update"

//病史
#define ANAMNESIS_FETCH_URL @"anamnesis/index"

//分类
#define CATEGORY_FETCH_URL @"category/index"

//城市
#define CITY_FETCH_URL @"city/index"

//评价
#define EVALUATE_CREATE_URL @"evaluate/create"
#define EVALUATE_FETCH_URL @"evaluate/index"

//专长
#define EXPERTISE_FETCH_URL @"expertise/index"

//收藏
#define FAVORITES_FETCH_URL @"favorites/index"
#define FAVORITES_CREATE_URL @"favorites/create"
//投死
#define REPINE_CREATE_URL @"repine/create"

//症状
#define REPINE_FETCH_URL @"symptom/index"

#endif
