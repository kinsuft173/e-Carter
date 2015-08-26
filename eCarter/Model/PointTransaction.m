//
//  PointTransaction.m
//  eCarter
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "PointTransaction.h"

@implementation PointTransaction

@dynamic description;

+(NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"Description":@"description"};
    
}

@end
