//
//  BalanceMoneyCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "BalanceMoneyCtrl.h"

@interface BalanceMoneyCtrl ()

@end

@implementation BalanceMoneyCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"余额支付" whichNavigation:self.navigationItem];
    
    self.dict=[[NSMutableDictionary alloc] init];
    [self.dict setObject:@"广州市天河区汽车美容服务部" forKey:@"company"];
    [self.dict setObject:@"39.00元" forKey:@"money"];
    [self.dict setObject:@"E车夫" forKey:@"receiver"];
    [self.dict setObject:@"洗车" forKey:@"service"];
    
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
    SuccessCtrl *vc=[[SuccessCtrl alloc] initWithNibName:@"SuccessCtrl" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
