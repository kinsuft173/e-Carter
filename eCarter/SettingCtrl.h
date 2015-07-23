//
//  SettingCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingCell.h"
#import "HKCommen.h"
#import "AddAdressCell.h"
#import "TransactionCtrl.h"
#import "AboutUsCtrl.h"
#import "SetTransactionPassworsCtrl.h"

@interface SettingCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong,nonatomic)NSArray *arrayOfInfo;

@end
