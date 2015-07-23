//
//  PaymentCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceMoneyCell.h"
#import "HKCommen.h"
#import "BalanceMoneyCtrl.h"

@interface PaymentCtrl : UIViewController

@property (strong,nonatomic) NSString *howMuch;
@property (assign)CGFloat BalanceMoney;
@property (strong,nonatomic) NSArray *arrayOfPayment;

@property (weak, nonatomic) IBOutlet UILabel *lbl_howMuch;
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end
