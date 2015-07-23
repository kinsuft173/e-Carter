//
//  ShopDetail.m
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ShopDetail.h"

@implementation ShopDetail


+ (NSDictionary *)objectClassInArray{
    return @{@"serviceItemList":[Serviceitemlist class], @"reviewsList":[Reviewslist class]};
}


@end


@implementation Reviewslist

@end

@implementation Storeinfo

@end

@implementation Serviceitemlist

@end
