//
//  TransactionCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetTransactionPassworsCtrl.h"
#import "HKCommen.h"

@interface TransactionCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txt_phone;
@property (weak, nonatomic) IBOutlet UITextField *txt_code;
@property (weak, nonatomic) IBOutlet UIButton *btn_sendCode;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ShowTime;

@end
