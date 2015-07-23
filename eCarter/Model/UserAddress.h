//
//  UserAddress.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAddress : NSObject


@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) BOOL isDefault;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *man;

@property (nonatomic, copy) NSString *province;


@end
