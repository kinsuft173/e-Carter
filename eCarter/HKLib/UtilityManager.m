//
//  UtilityManager.m
//  GSAPP
//
//  Created by kinsuft173 on 15/6/6.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "UtilityManager.h"
#import "HKCommen.h"
#import <AFNetworking.h>

@implementation UtilityManager

+ (UtilityManager*)shareMgr
{
    static UtilityManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[UtilityManager alloc] init];

    });
    
    return instance;
}

- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(HKSignInResponse)completeBlock
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager POST:@"http://115.28.85.76/apiFirstStep/fetchVideo/queryVideo.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        if (responseObject != nil) {
            
            completeBlock(YES);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        completeBlock(NO);
        
    }];


}

@end
