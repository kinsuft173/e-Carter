//
//  TransactionCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "TransactionCtrl.h"

@interface TransactionCtrl ()

@end

@implementation TransactionCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *phoneView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_phone"]];
    [phoneView setFrame:CGRectMake(10, 0, 14, 22)];
    UIView *firstView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 22)];
    [firstView addSubview:phoneView];
    self.txt_phone.leftView=firstView;
    self.txt_phone.leftViewMode=UITextFieldViewModeAlways;
    self.txt_phone.layer.cornerRadius=7.0;
    self.txt_phone.layer.masksToBounds=YES;
    self.txt_phone.layer.borderWidth=1.0;
    self.txt_phone.layer.borderColor=[UIColor colorWithRed:104.0/255.0 green:190.0/255.0 blue:239.0/255.0 alpha:1.0].CGColor;
    
    UIImageView *codeView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_code"]];
    [codeView setFrame:CGRectMake(10, 0, 14, 22)];
    UIView *secondtView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 22)];
    [secondtView addSubview:codeView];
    self.txt_code.leftView=secondtView;
    self.txt_code.leftViewMode=UITextFieldViewModeAlways;
    self.txt_code.layer.cornerRadius=7.0;
    self.txt_code.layer.masksToBounds=YES;
    self.txt_code.layer.borderWidth=1.0;
    self.txt_code.layer.borderColor=[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0].CGColor;
    
    self.btn_sendCode.layer.cornerRadius=5.0;
    self.btn_sendCode.layer.masksToBounds=YES;
    
    [HKCommen addHeadTitle:@"设置交易密码" whichNavigation:self.navigationItem];
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

- (IBAction)goSetPassword:(UIButton *)sender {
    SetTransactionPassworsCtrl *vc=[[SetTransactionPassworsCtrl alloc] initWithNibName:@"SetTransactionPassworsCtrl" bundle:nil];
    vc.judgeLoginOrPassword=@"password";
    [self.navigationController pushViewController:vc animated:YES];
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
