//
//  SetTransactionPassworsCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/9.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"

@interface SetTransactionPassworsCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_commit;

@property (strong,nonatomic)NSString *judgeLoginOrPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_enterPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_confirmPassword;

@end
