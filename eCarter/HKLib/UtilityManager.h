//
//  UtilityManager.h
//  GSAPP
//
//  Created by kinsuft173 on 15/6/6.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HKSignInResponse)(BOOL);

@interface UtilityManager : NSObject

+ (UtilityManager*)shareMgr;

- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(HKSignInResponse)completeBlock;


@end
