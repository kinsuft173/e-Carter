//
//  OrderSingle.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Returnimagelist,Orderimagelist;
@interface OrderSingle : NSObject


@property (nonatomic, copy) NSString *carnum;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *pay;

@property (nonatomic, copy) NSString *items;

@property (nonatomic, copy) NSString *paytype;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *pickerId;

@property (nonatomic, copy) NSString *pointCost;

@property (nonatomic, copy) NSString *customId;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *appointment;

@property (nonatomic, copy) NSString *point;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *storeId;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *itemsCost;

@property (nonatomic, strong) NSArray *orderImageList;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *orderTime;

@property (nonatomic, strong) NSArray *returnImageList;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *serviceCost;


@end

@interface Returnimagelist : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *imageUrl;

@end

@interface Orderimagelist : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *imageUrl;

@end

