//
//  Order.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderImageList;
@interface Order : NSObject


@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *orderAmount;

@property (nonatomic, copy) NSString *orderTime;

@property (nonatomic, copy) NSString *storeId;

@property (nonatomic, copy) NSString *orderLogTime;

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *orderLogName;

@property (nonatomic, copy) NSString *orderLogId;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) NSArray *orderImageList;

@property (nonatomic, copy) NSString *orderStatus;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *services;

@property (nonatomic, copy) NSString *plateNumber;

@property (nonatomic, copy) NSString *updateTime;

@end

@interface OrderImageList : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *imageUrl;


@end
