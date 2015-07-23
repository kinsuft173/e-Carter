//
//  ShopServerTime.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Servicetimelist;

@interface ShopServerTime : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *storeId;

@property (nonatomic, strong) NSArray *serviceTimeList;

@property (nonatomic, copy) NSString *serviceDate;

@end

@interface Servicetimelist : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *serviceTimeS;

@property (nonatomic, copy) NSString *serviceTimeE;


@end
