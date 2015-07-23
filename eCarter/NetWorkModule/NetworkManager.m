//
//  NetworkManager.m
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetworkManager

+ (NetworkManager*)shareMgr
{
    static NetworkManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[NetworkManager alloc] init];

    });
    
    return instance;
}



#pragma mark - 用户相关接口
- (void)server_createUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,USER_REGESTER_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_fetchUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"id": @"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,USER_FETCH_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_updateUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"email": @"xianfengshizhazha@caidigou.net"};
    
    [manager PUT:[NSString stringWithFormat:@"%@%@&%@=%@",SERVER,USER_UPDATE_URL,@"id",@"1"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


#pragma mark - 广告页面

- (void)server_fetchAdvertisementWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"id": @"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,APP_AD_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


#pragma mark -- 医生

- (void)server_fetchDoctorsWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"recommended": @"0"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,DOCTOR_FETCH_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

#pragma mark - 咨询问诊

- (void)server_createConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"doctor_id": @"1",@"patient_name":@"SDS",@"patient_sex": @"1",@"patient_age":@"1",@"patient_mobile": @"18672354399",@"patient_dept":@"SDS",@"symptom_id": @"1",@"patient_illness":@"SDS",@"anamnesis_id": @"1",@"timely":@"1",@"other_order":@"1"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,CONSULATION_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


- (void)server_fetchConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"id": @"1",@"patient_name":@"SDS",@"patient_sex": @"1",@"patient_age":@"1",@"patient_mobile": @"18672354399",@"patient_dept":@"SDS",@"symptom_id": @"1",@"patient_illness":@"SDS",@"anamnesis_id": @"1",@"timely":@"1",@"other_order":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,CONSULATION_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}



#pragma mark - 订单
- (void)server_createOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,ORDER_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)server_fetchOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,ORDER_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)server_updateOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"status":@"2"};
    
    [manager PUT:[NSString stringWithFormat:@"%@%@&%@=%@",SERVER,ORDER_UPDATE_URL,@"id",@"1"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//病史

- (void)server_fetchAnamnesisWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,ANAMNESIS_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


//分类
- (void)server_fetchCategoryWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,CATEGORY_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//城市
- (void)server_fetchCityWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,CITY_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//评价
- (void)server_createEvaluateWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"doctor_id":@"1",@"evaluated_doctor_id":@"2",@"order_id":@"1",@"score":@"4",@"content":@"显峰号恶心啊"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,EVALUATE_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


- (void)server_fetchEvaluateWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
        NSDictionary *parameters = @{@"order_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,EVALUATE_FETCH_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


//专长
- (void)server_fetchExpertiseWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"order_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,EXPERTISE_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//收藏
- (void)server_createFavoritesWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
        NSDictionary *parameters = @{@"doctor_id":@"1",@"favorites_doctor_id":@"1"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,FAVORITES_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//投诉
- (void)server_fetchRepineWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"doctor_id":@"1",@"repined_doctor_id":@"1",@"order_id":@"1",@"content":@"11111"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,REPINE_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//症状
- (void)server_fetchSymptomWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"doctor_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,REPINE_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}





@end
