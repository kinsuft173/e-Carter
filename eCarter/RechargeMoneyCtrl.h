//
//  RechargeMoneyCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"
#import "ReChargeSuccessCtrl.h"

@interface RechargeMoneyCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_balance;
@property (strong,nonatomic) NSString *balance;

@end
