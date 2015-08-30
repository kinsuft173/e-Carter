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
#import "PaymentRequest.h"
//#import "PaymentConfig.h"

@interface PaymentCtrl : UIViewController

@property (strong,nonatomic) NSString *howMuch;
@property (assign)CGFloat BalanceMoney;
@property (strong,nonatomic) NSArray *arrayOfPayment;

@property (weak, nonatomic) IBOutlet UILabel *lbl_howMuch;
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property (nonatomic, strong) NSDictionary* dicPreParams;

@property (nonatomic, strong) PaymentRequest* paymentRequest;

@property (nonatomic, strong) NSString* strTotalMount;
@property (nonatomic, strong) NSString* strShopName;
@property (nonatomic, strong) NSString* strSeviceItem;

@end
