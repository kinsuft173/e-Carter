//
//  ConsulationManager.h
//  GSAPP
//
//  Created by kinsuft173 on 15/9/9.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsulationManager : NSObject

+ (ConsulationManager*)shareMgr;

- (void)addHandledConsulation:(NSString*)consulationId;
- (void)addHandledComment:(NSString*)consulationId;
- (void)getMycounPonModel;
- (BOOL)isCommented:(NSString*)consulationId;

@property (nonatomic, strong,getter=modelSet) NSMutableSet* setModel;
@property (nonatomic, strong) NSMutableSet* setComment;
@end
