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
#import "ConsulationManager.h"
#import "XMLReader.h"



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

- (void)server_setConsumePasswordWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_USER_CONSUME_PASSWORD_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        if (completeHandle) {
            
            completeHandle(nil);
        }
        NSLog(@"Error: %@", error);
        
        
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
        
        
        NSLog(@"server_loginWithDic=>%@",responseObject);
        
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
        
//        if (completeHandle) {
//            
//            completeHandle(responseObject);
//        }
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

//获取城市列表
- (void)server_fetchCityWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = CITY_URL;
        
    }else{
        
        strInterface = CITY_URL;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"server_fetchCityWithDic == > %@",responseObject);
        
        if (self.isTestMode) {
            
//            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseAllCouponList;
//            
//            if (completeHandle) {
//                
//                completeHandle(dictionary);
//                
//            }
            
        }else{
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"server_fetchCityWithDic  Error== > %@",error);
        
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    NSMutableDictionary* dicParams = [self addUserLocationWithDic:dic];
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_STROE_DETAIL_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dicParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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


- (void)server_queryStoreCommemtWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
//     NSMutableDictionary* dicParams = [self addUserLocationWithDic:dic];
    
    NSString* strInterface;
    

        
    strInterface = ECATER_QUERY_STROE_COMMENT_INTERFACE;
        
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (self.isTestMode) {
            
            NSDictionary *dictionary = [FakeDataMgr shareMgr].responseQueryStoreDetail;
            
            if (completeHandle) {
                
                completeHandle(dictionary);
                
            }
            
        }else{
            
            NSLog(@"server_queryStoreCommemtWithDic ==> %@",responseObject);
            
            if (completeHandle) {
                
                completeHandle(responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //ErrorHandle(error);
           completeHandle(nil);
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        if (completeHandle) {
            
            completeHandle(nil);
        }
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"server_saveOrderPayWithDic=>%@",responseObject);
        
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
        
//        ErrorHandle(error);
           NSLog(@"Error: %@", error);     
        if (completeHandle) {
            
            completeHandle(nil);
        }
        
        
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


- (void)server_cancelOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_CANCEL_ORDER_INTERFACE;
        
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


- (void)server_cancelAddressWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECARTER_DELETE_ADRRESS;
        
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
        
                completeHandle(nil);
        
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
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_ODER_LOG_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        completeHandle(nil);
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"用户账户数据:%@",responseObject);
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"server_queryUserCarWithDic=>%@",responseObject);
        
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
        completeHandle(nil);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_queryUserPointWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_USER_POINT;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"server_queryUserPointWithDic=>%@",responseObject);
        
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
        completeHandle(nil);
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        if (completeHandle) {
            
            completeHandle(nil);
        }
        
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

- (void)server_deleteCarWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_DELETE_CAR_INTERFACE;
        
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

- (void)server_EditUserInfo:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_EDIT_USERINFO_INTERFACE;
        
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
        
        completeHandle(nil);
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
    
//    NSString* url = [NSString stringWithFormat:@"%@%@",SERVER,strInterface];
//    
//    [self server_BasePost:dic url:url];
//     completeHandle(nil);
}


- (void)server_queryCarLists:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_CAR_LISTS;
        
    }
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER_CAR,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

- (void)server_queryCarDetails:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_CAR_DETAILS;
        
    }
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER_CAR,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        NSLog(@"server_queryUserAddressWithDic=>%@",responseObject);
        
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
        
        completeHandle(nil);
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"server_addUserAddressWithDic ==> %@",responseObject);
        
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
        
        if (completeHandle) {
            
            completeHandle(nil);
        }
        
        
    }];
    
}

- (void)server_editUserAddressWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    NSString* strInterface;
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_EDITE_USER_ADDRESS_INTERFACE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"server_addUserAddressWithDic ==> %@",responseObject);
        
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
        
        if (completeHandle) {
            
            completeHandle(nil);
        }
        
        
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
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,ECATER_QUERY_ADVERTISEMENT] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


#pragma mark - 获得最新版本

- (void)server_fetchVersionWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    NSDictionary* dicMore = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"device",@"v0.1",@"version", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
//    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,VERSION_LAST] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        NSLog(@"JSON: %@", responseObject);
//        
//        if (completeHandle) {
//            
//            completeHandle(responseObject);
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (completeHandle) {
//            
//            completeHandle(nil);
//        }
//        NSLog(@"Error: %@", error);
//        
//    }];
    
    NSString* strUrl = [NSString stringWithFormat:@"%@%@",SERVER,VERSION_LAST];
    
    NSMutableDictionary* dicNew =  [self server_BasePost:[[NSMutableDictionary alloc] init]  url:strUrl];
    
    NSLog(@"dicNew = %@",dicNew);
    
    if (dicNew) {
        
                if (completeHandle) {
        
                    completeHandle(dicNew);
                }
    }else{
    
        if (completeHandle) {
            
            completeHandle(nil);
        }
    
    
    }
    
}

#pragma mark - 天气页面

- (void)server_fetchWeatherWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER_CAR,APP_WEATHER_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];




}

//支付回调
- (void)server_payNotifytWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",SERVER,PAY_ALI_NOTIFY,[dic objectForKey:@"id"]];
    
    NSLog(@"url = %@",url);
    
    [manager POST:[NSString stringWithFormat:@"%@%@%@",SERVER,PAY_ALI_NOTIFY,[dic objectForKey:@"id"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
//    [self  server_BasePost:nil url:url];
    
//    completeHandle(nil);
}

- (void)server_fetchAdvertisementDetails:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,ECATER_DETAILS_ADVERTISEMENT] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)server_fetchAllCheapTickets:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,ECATER_CHEAP_TICKETS] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


- (void)server_snapCoupon:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,ECATER_SNAP_COUPON] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


- (void)server_fetchQueryUserCouponList:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_USER_COUPON;
        
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

        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_fetchQueryUserCouponNotList:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ECATER_QUERY_USER_COUPON_NOT;
        
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
        
        NSLog(@"Error: %@", error);
        
        
        
        
    }];
    
}



- (NSDictionary*)server_BasePost:(NSMutableDictionary*)dic url:(NSString*)ctUrl
{
    
    //download from server
    NSString* strUrl = ctUrl;//[NSString stringWithFormat:@"%@/base/addAppointmentOrder?", SERVER];
    
    if(dic == nil)
        return nil;
    
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
    
    
    
    if (error == nil)
    {
        // Parse data here
        NSString* myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"myString = %@",myString);
        
        // parse
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
//        NSDictionary *object = [parser objectWithString:myString];
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:myString error:&parseError];
        // 打印 NSDictionary
        NSLog(@"%@", xmlDictionary);
        
        return [NSMutableDictionary dictionaryWithDictionary:xmlDictionary];
    }

    
    return nil;
}


- (void)server_getOrderPreId:(NSString*)orderId completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = PAY_WX_ORDER_PRE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@%@",SERVER,strInterface,orderId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];



}


- (void)server_getRechangePreId:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = PAY_WX_RECHARGE_ORDER_PRE;
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];
    
    
    
}


- (void)server_getRechangeTradeId:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = PAY_WX_RECHARGE_ORDER_Trade;
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];
    
    
    
}

//提现

- (void)server_userAccountWithdrawCash:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = PAY_TIXIAN;
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];



}


- (void)server_etraPayWithOrderId:(NSString*)orderId completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = ETREA_PAY_WX_ORDER_PRE;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@%@",SERVER,strInterface,orderId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];

}


- (void)server_wxPayNotify:(NSString*)orderId completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = PAY_WX_NOTIFY;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@%@",SERVER,strInterface,orderId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];
    
}

- (void)server_wxRechargeNotify:(NSString*)orderId withDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = PAY_Recharge_WX_NOTIFY;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@%@",SERVER,strInterface,orderId] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];


}


- (void)server_aliRechargeNotify:(NSString*)orderId withDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* strInterface;
    
    
    if (self.isTestMode) {
        
        strInterface = ECATER_TEST_INTERFACE;
        
    }else{
        
        strInterface = PAY_Recharge_Ali_NOTIFY;
        
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@%@",SERVER,strInterface,orderId] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        NSLog(@"Error: %@", error);
        completeHandle(nil);
        
    }];
    
    
}


@end
