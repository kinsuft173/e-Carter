//
//  NetworkManager.m
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "FakeDataMgr.h"
#import "HKMapManager.h"
#import "SBJsonParser.h"

@interface NetworkManager ()

@property BOOL isTestMode;

@end

@implementation NetworkManager

+ (NetworkManager*)shareMgr
{
    static NetworkManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[NetworkManager alloc] init];
        
        instance.isTestMode = ISINTEST;

    });
    
    return instance;
}

#pragma mark - 登陆注册接口

- (void)server_registerWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
    
        strInterface = ECATER_REGISTER_INTERFACE;
    
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseRegister;
            
            if (completeHandle) {
             
                completeHandle(dictionary);
                
            }
            
        }else{
        
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
        
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];

}

- (NSString*)server_GetIdentyCode:(NSMutableDictionary*)dic url:(NSString*)ctUrl
{
    
    //download from server
    NSString* strUrl = ctUrl;//[NSString stringWithFormat:@"%@/base/addAppointmentOrder?", SERVER];
    

    
    //download from server
    //NSString* strUrl = [NSString stringWithFormat:@"%@/base/addArchiveRecord", SERVER];
    
    
    NSString *BoundaryConstant = @"bP8bMGL3HEiJbMKsS289FSuSKw9Kq8iklhSPysQ";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    
    NSString *contentType = [[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    
    
    for (NSString *key in [dic allKeys])
    {
        
        
        
        id value = dic[key];
        if (([value isKindOfClass:[NSString class]] && ((NSString*)value).length == 0) ||
            value == [NSNull null] )
        {
            continue;
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    
    
    [request setHTTPBody:body];
    [request setHTTPMethod:@"POST"];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    NSURLResponse *response;
    NSError *error;
    
    NSLog(@"Post Request = %@",request);
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"数据%@",data);
    
    if (error == nil)
    {
        // Parse data here
        NSString* myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"myString = %@",myString);
        
        
        
        
        //debug
        //NSLog(@"server_addAppointmentOrder=> %@", myString);
        
        // parse
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
        NSDictionary *object = [parser objectWithString:myString];
        
        // check result
        NSNumber* status = [object objectForKey:@"status"];
        
        
        
        if([status intValue] == 5000101)
        {
           // return object;
        }
        return myString;
    }
    
    return nil;
}

- (void)server_genCodeWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    

    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{

        strInterface = ECATER_GENCODE_INTERFACE;

    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

            if (completeHandle) {
                
                
                completeHandle(responseObject);
            }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"错误: %@", error);  
        
    }];
    
}

- (void)server_loginWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_LOGIN_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseLogin;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_logoutWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_LOGOUT_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

#pragma mark --首页接口

- (void)server_infoWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_INFO_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseInfo;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_allCouponListWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_AllCOUPON_LIST_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseAllCouponList;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryCouponWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_COUPON_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryCoupon;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryStoreListWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSMutableDictionary* dicParams = [self addUserLocationWithDic:dic];
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_STORE_LIST_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dicParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryStoreList;
            
            NSLog(@"server_queryStoreListWithDic ==> %@",dictionary);
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            NSLog(@"server_queryStoreListWithDic ==> %@",responseObject);
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryStoreDetailWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_STROE_DETAIL_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryStoreDetail;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
             NSLog(@"server_queryStoreDetailWithDic ==> %@",responseObject);
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryStoreServiceTimeWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_STORE_SERVICETIME_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryStoreServiceTime;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_saveServiceOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_SAVE_SERVICE_ORDER_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_saveOrderPayWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_SAVE_ORDER_PAY_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


#pragma mark - 用户接口

- (void)server_queryOrderListWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_ORDER_LIST_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryOrderList;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_queryOrderDetailWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_ODERD_ETAIL_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryOrderDetail;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
                      
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_queryOrderLogWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_ODER_LOG_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryOrderLog;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_updateOrderStatusWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_UPDATE_ORDER_STATUS_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_submitOrderReviewsWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_SUBMIT_ODERRE_VIEW_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryUserAccountWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_USER_ACCOUNT_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryUserAccount;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryUserRechargeWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_USERRECHARGE_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryUserRecharge;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_submitRechargeInfoWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_SUBMIT_RECHARGEINO_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_queryUserCarWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_USER_CAR_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryUserCar;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_addCarWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_ADD_CAR_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_queryCarBrandWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_CAR_BRAND_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryCarBrand;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryCarSeriesWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_CAR_LISTS_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryCarSeries;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryUserAddressWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_USER_ADDRESS_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryUserAddress;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_addUserAddressWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_ADD_USER_ADDRESS_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",[NSNumber numberWithInt:200000],@"status", nil];
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_queryPointTransactionWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_POINT_TRANSACTION_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryPointTransaction;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
        
        NSLog(@"Error: %@", error);
        

        
    }];
    
}

- (NSMutableDictionary*)addUserLocationWithDic:(NSDictionary*)dic
{
    NSMutableDictionary* dicTemp;
    
    if (dic) {
        
        dicTemp = [NSMutableDictionary dictionaryWithDictionary:dic];
        
    }else{
    
        dicTemp = [[NSMutableDictionary alloc] init];
        
    }
    
    if ([HKMapManager shareMgr].currentLocation == nil || [HKMapManager shareMgr].userCurrentLatitude == nil) {
        
        return dicTemp;
        
    }
    
    [dicTemp setObject:[HKMapManager shareMgr].userCurrentLongitude forKey:@"dimensions_y"];
    [dicTemp setObject:[HKMapManager shareMgr].userCurrentLatitude forKey:@"dimensions_x"];
    
    return dicTemp;

}


#pragma mark - 广告页面

- (void)server_fetchAdvertisementWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //    NSDictionary *parameters = @{@"id": @"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVERADTEST,APP_AD_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


@end
