//
//  BalanceMoneyCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"
#import "SuccessCtrl.h"

@interface BalanceMoneyCtrl : UIViewController

@property (strong,nonatomic)NSMutableDictionary *dict;

@property (weak, nonatomic) IBOutlet UILabel *lbl_companyOfService;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Money;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Receiver;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Service;

@end
