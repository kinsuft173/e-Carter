//
//  AdvertisementForEcart.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementForEcart : NSObject


@property (nonatomic, assign) NSInteger position;

@property (nonatomic, assign) NSInteger city;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *cityName;


@end
