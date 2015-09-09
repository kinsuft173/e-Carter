//
//  SelfGetCtrl.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"
#import "Car.h"
#import "UserAddress.h"

@interface SelfGetCtrl : UIViewController
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSArray* userCar;
@property (strong,nonatomic) UserAddress* userAddress;

@end
