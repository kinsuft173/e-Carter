//
//  ConsulationManager.m
//  GSAPP
//
//  Created by kinsuft173 on 15/9/9.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ConsulationManager.h"
#import "NetworkManager.h"
#import "UserDataManager.h"

@interface ConsulationManager()

//@property (nonatomic, strong) NSMutableSet* setModel;

@end

@implementation ConsulationManager

@synthesize setModel = _setModel;

+ (ConsulationManager*)shareMgr
{
    static ConsulationManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[ConsulationManager alloc] init];
        
        NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"setModel"];
    
        instance.setModel =  [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (instance.setModel == nil) {
            
            
            instance.setModel = [[NSMutableSet alloc] init];
        }else{
        
            instance.setModel = [NSMutableSet setWithSet:instance.setModel];
        
        }
        
        NSData* data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"setComment"];
        
        instance.setComment =  [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        if (instance.setComment == nil) {
            
            
            instance.setComment = [[NSMutableSet alloc] init];
        }else{
            
            instance.setComment = [NSMutableSet setWithSet:instance.setModel];
            
        }
        
    });
    
    return instance;
}

- (NSSet*)modelSet
{
    if (_setModel == nil) {
        
        
        _setModel = [[NSMutableSet alloc] init];
    }

    return _setModel;
}



- (void)addHandledConsulation:(NSString*)consulationId
{
    if (consulationId) {
        
        [self.setModel addObject:consulationId];
        
        NSSet* setTemp = [NSSet setWithSet:self.setModel];
        
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:setTemp];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"setModel"];

    }

}

- (BOOL)isCommented:(NSString*)consulationId
{
    if ([self.setComment containsObject:consulationId]) {
        
        return YES;
        
    }

    return NO;

}

- (void)addHandledComment:(NSString*)consulationId
{
    if (consulationId) {
        
        [self.setComment addObject:consulationId];
        
        NSSet* setTemp = [NSSet setWithSet:self.setComment];
        
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:setTemp];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"setComment"];
        
    }
    
}

- (void)getMycounPonModel
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    
    [[NetworkManager shareMgr] server_fetchQueryUserCouponNotList:dic completeHandle:^(NSDictionary *responseBanner) {
        
        
        NSLog(@"获取的优惠券数据= %@",responseBanner);
        
        if ([[responseBanner objectForKey:@"status"] integerValue] == 5000103) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"setModel"];
            [ConsulationManager shareMgr].setModel = nil;
            [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"checkUser"];
            
        }
        
        if ([[responseBanner objectForKey:@"status"] integerValue] == 2000000) {
            
            NSArray* arrayCounpon =  [responseBanner objectForKey:@"data"];
            
            
            for (int i = 0; i < arrayCounpon.count; i ++) {
                
                NSDictionary* dic = [arrayCounpon objectAtIndex:i];
                
                NSLog(@"将要处理的优惠券模型=%@",dic);
                
                
                [self addHandledConsulation:dic[@"title"]];
                
            }
        }
        

        
    
    }];
        




}

@end
