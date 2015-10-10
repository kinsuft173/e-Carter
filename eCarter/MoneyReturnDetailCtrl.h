//
//  MoneyReturnDetailCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/8/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderSingle.h"

@interface MoneyReturnDetailCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewForReturnDetail;
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;

@property (nonatomic, strong) OrderSingle* order;
@property (nonatomic, strong) NSString* strType;
@end
