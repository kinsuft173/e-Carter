//
//  OrderManagerCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderManagerCell.h"
#import "CallingCell.h"
#import "ButtonCell.h"
#import "OrderProgressCell.h"
#import "HKCommen.h"

@interface OrderManagerCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table_waiting;
@property (weak, nonatomic) IBOutlet UITableView *table_receiving;
@property (weak, nonatomic) IBOutlet UITableView *table_servicing;
@property (weak, nonatomic) IBOutlet UITableView *table_returning;
@property (weak, nonatomic) IBOutlet UITableView *table_complete;

@end
