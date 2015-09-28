//
//  CarSeri.h
//  eCarter
//
//  Created by kinsuft173 on 15/9/25.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CarList,SecondList;
@interface CarSeri : NSObject


@property (nonatomic, strong) NSArray *List;

@property (nonatomic, assign) NSInteger I;

@property (nonatomic, copy) NSString *N;

@property (nonatomic, copy) NSString *L;



@end
@interface CarList : NSObject

@property (nonatomic, assign) NSInteger I;

@property (nonatomic, copy) NSString *N;

@property (nonatomic, strong) NSArray *List;

@end

@interface SecondList : NSObject

@property (nonatomic, assign) NSInteger I;

@property (nonatomic, copy) NSString *N;

@end

