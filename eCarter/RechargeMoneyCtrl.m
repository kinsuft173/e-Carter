//
//  RechargeMoneyCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "RechargeMoneyCtrl.h"

@interface RechargeMoneyCtrl ()

@end

@implementation RechargeMoneyCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [HKCommen addHeadTitle:@"充值" whichNavigation:self.navigationItem];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)commitReCharge:(UIButton *)sender {
    ReChargeSuccessCtrl *vc=[[ReChargeSuccessCtrl alloc] initWithNibName:@"ReChargeSuccessCtrl" bundle:nil];
    vc.judgeRefillOrGetReal=@"refill";
    [self.navigationController pushViewController:vc animated:YES];
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
