//
//  ReChargeSuccessCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ReChargeSuccessCtrl.h"

@interface ReChargeSuccessCtrl ()

@end

@implementation ReChargeSuccessCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    NSArray* array = self.navigationController.childViewControllers;
    
    UIViewController* vc = [array objectAtIndex:1];
    
    
    [self.navigationController popToViewController:vc animated:YES];
}

-(void)initUI
{
    if ([self.judgeRefillOrGetReal isEqualToString:@"refill"]) {
        
        [HKCommen addHeadTitle:@"充值成功" whichNavigation:self.navigationItem];
        self.lbl_hint.text=@"充值成功";
        self.lbl_detail.text=  [NSString stringWithFormat:@"成功充值%@元到我的账户",self.amout];//@"成功充值%@元到我的账户";
    }
    else if ([self.judgeRefillOrGetReal isEqualToString:@"getReal"])
    {
       [HKCommen addHeadTitle:@"提现申请成功" whichNavigation:self.navigationItem];
        self.lbl_hint.text=@"提现申请成功";
        self.lbl_detail.text=@"已成功提交提现申请，请您耐心等候";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
