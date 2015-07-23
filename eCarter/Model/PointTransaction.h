//
//  PointTransaction.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointTransaction : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger totalPoint;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) NSInteger point;

@property (nonatomic, copy) NSString *description;

@end
