//
//  ShopDetail.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reviewslist,Storeinfo,Serviceitemlist;
@interface ShopDetail : NSObject

@property (nonatomic, strong) NSArray *reviewsList;


@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *endBusinessTime;

@property (nonatomic, copy) NSString *storeScore;

@property (nonatomic, copy) NSString *storeImg;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *startBusinessTime;

//@property (nonatomic, strong) Storeinfo *storeInfo;

@property (nonatomic, strong) NSArray *serviceItemList;

@end

@interface Reviewslist : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *storeId;

@property (nonatomic, copy) NSString *reviews;

@property (nonatomic, copy) NSString *userId;

@end

@interface Storeinfo : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *endBusinessTime;

@property (nonatomic, copy) NSString *storeScore;

@property (nonatomic, copy) NSString *storeImg;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *startBusinessTime;

@end

@interface Serviceitemlist : NSObject

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *storeId;

@property (nonatomic, copy) NSString *serviceItemName;


@end
