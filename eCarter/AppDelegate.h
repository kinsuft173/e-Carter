//
//  AppDelegate.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/21.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentCtrl.h"
#import "RechargeMoneyCtrl.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak,nonatomic) PaymentCtrl* payCtrl;
@property (weak,nonatomic) RechargeMoneyCtrl* reCtrl;

@end

