//
//  ReChargeSuccessCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"

@interface ReChargeSuccessCtrl : UIViewController

@property (strong,nonatomic)NSString *judgeRefillOrGetReal;
@property (weak, nonatomic) IBOutlet UILabel *lbl_hint;
@property (weak, nonatomic) IBOutlet UILabel *lbl_detail;

@property (nonatomic, strong) NSString* amout;

@end
