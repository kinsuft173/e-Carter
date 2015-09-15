//
//  BalanceMoneyCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "BalanceMoneyCtrl.h"
#import "NetworkManager.h"
#import "UserDataManager.h"
#import "SIAlertView.h"
#import "RechargeMoneyCtrl.h"

@interface BalanceMoneyCtrl ()

@end

@implementation BalanceMoneyCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"余额支付" whichNavigation:self.navigationItem];
    
    self.dict=[[NSMutableDictionary alloc] init];
    [self.dict setObject:self.strShopName forKey:@"company"];
    [self.dict setObject:[NSString stringWithFormat:@"%.2f元",[self.strTotalMount floatValue]] forKey:@"money"];
    [self.dict setObject:@"E车夫" forKey:@"receiver"];
    [self.dict setObject:self.strSeviceItem forKey:@"service"];
    
    [self initUI];
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -17;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
    }else
    {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI
{
    self.lbl_companyOfService.text=[self.dict objectForKey:@"company"];
    self.lbl_Money.text=[self.dict objectForKey:@"money"];
    self.lbl_Receiver.text=[self.dict objectForKey:@"receiver"];
    self.lbl_Service.text=[self.dict objectForKey:@"service"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finishPayment:(UIButton *)sender {
    
    if (self.BalanceMoney < self.strTotalMount.floatValue) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"余额不足,是否去充值？"];
        [alertView addButtonWithTitle:@"确认"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                 
                                  RechargeMoneyCtrl *chargeCtrl=[[RechargeMoneyCtrl alloc] initWithNibName:@"RechargeMoneyCtrl" bundle:nil];
                                 // chargeCtrl.balance=self.stringOfCount;
                                  [self.navigationController pushViewController:chargeCtrl animated:YES];
                                  
                                 
                              }];
        [alertView addButtonWithTitle:@"取消"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
        alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
        
        alertView.willShowHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, willShowHandler3", alertView);
        };
        alertView.didShowHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, didShowHandler3", alertView);
        };
        alertView.willDismissHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, willDismissHandler3", alertView);
        };
        alertView.didDismissHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, didDismissHandler3", alertView);
        };
        
        [alertView show];

        
        return;
        
    }
    
    
   // NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.uid,@"customerId", nil];
    
    [[NetworkManager shareMgr] server_etraPayWithOrderId:[self.dicPreParams objectForKey:@"orderId"] completeHandle:^(NSDictionary *response) {
        
        NSLog(@"response = %@");
        
        if (response[@"data"]) {
            
            self.BalanceMoney = [response[@"data"] floatValue];
            
        }
        
        
    }];
    
    SuccessCtrl *vc=[[SuccessCtrl alloc] initWithNibName:@"SuccessCtrl" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
