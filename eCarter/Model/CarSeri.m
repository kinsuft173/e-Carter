//
//  CarSeri.m
//  eCarter
//
//  Created by kinsuft173 on 15/9/25.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "CarSeri.h"

@implementation CarSeri


+ (NSDictionary *)objectClassInArray{
    return @{@"List" : [CarList class]};
}
@end
@implementation CarList

+ (NSDictionary *)objectClassInArray{
    return @{@"List" : [SecondList class]};
}

@end


@implementation SecondList

@end


