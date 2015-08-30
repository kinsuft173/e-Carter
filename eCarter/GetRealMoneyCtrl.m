//
//  GetRealMoneyCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "GetRealMoneyCtrl.h"
#import "ReChargeSuccessCtrl.h"
#import "UserDataManager.h"
#import "NetworkManager.h"

@interface GetRealMoneyCtrl ()

@end

@implementation GetRealMoneyCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"提现" whichNavigation:self.navigationItem];
    
    self.lbl_balance.text=self.balance;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitGetRealMoney:(UIButton *)sender {
    
    if ([self.txt_amount.text isEqualToString:@"请输入提现金额"] || [self.txt_amount.text  isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请输入提现金额"];
        
        return;
        
    }
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    NSDictionary* dicNew = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.uid,@"customerId",@"0.01",@"amount" ,nil];
    
    [[NetworkManager shareMgr] server_userAccountWithdrawCash:dicNew completeHandle:^(NSDictionary *responese) {
        
        if (responese == nil) {
            
            hud.hidden = YES;
        }
        
        
        hud.hidden = YES;
        
        
        if ([[responese objectForKey:@"message"] isEqualToString:@"OK"]) {
            
            ReChargeSuccessCtrl *vc=[[ReChargeSuccessCtrl alloc] initWithNibName:@"ReChargeSuccessCtrl" bundle:nil];
            vc.judgeRefillOrGetReal=@"getReal";
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
        
        
            [HKCommen addAlertViewWithTitel:@"提现失败"];
        
        }
        
        
    }];
    

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
