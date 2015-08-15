//
//  UserDataManager.m
//  ksbk
//
//  Created by 胡昆1 on 12/6/14.
//  Copyright (c) 2014 cn.chutong. All rights reserved.
//

#import "UserDataManager.h"



@implementation UserDataManager

@synthesize userId;

+ (UserDataManager*)shareManager
{
    static UserDataManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[UserDataManager alloc] init];
        
        //[instance fakeDate];
        
        
    });
    
    return instance;
}

- (void)fakeDate
{
    self.userId = @"1";
    self.userType = @"1";

}


@end
