//
//  SetTransactionPassworsCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/9.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SetTransactionPassworsCtrl.h"

@interface SetTransactionPassworsCtrl ()

@end

@implementation SetTransactionPassworsCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.judgeLoginOrPassword isEqualToString:@"login"]) {
        [self initLogin];
    }
    else if ([self.judgeLoginOrPassword isEqualToString:@"password"])
    {
        [self initPassword];
    }
    
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

-(void)initLogin
{
    [self.btn_commit setTitle:@"登录" forState:UIControlStateNormal];
    
    UIImageView *phoneView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_Account"]];
    [phoneView setFrame:CGRectMake(10, 0, 18, 18)];
    UIView *firstView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 22)];
    [firstView addSubview:phoneView];
    self.txt_confirmPassword.leftView=firstView;
    self.txt_confirmPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txt_confirmPassword.layer.cornerRadius=7.0;
    self.txt_confirmPassword.layer.masksToBounds=YES;
    self.txt_confirmPassword.layer.borderWidth=1.0;
    self.txt_confirmPassword.layer.borderColor=[UIColor colorWithRed:104.0/255.0 green:190.0/255.0 blue:239.0/255.0 alpha:1.0].CGColor;
    self.txt_confirmPassword.placeholder=@"请输入手机号码";
    
    UIImageView *codeView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    [codeView setFrame:CGRectMake(10, 0, 17, 22)];
    UIView *secondtView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 22)];
    [secondtView addSubview:codeView];
    self.txt_enterPassword.leftView=secondtView;
    self.txt_enterPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txt_enterPassword.layer.cornerRadius=7.0;
    self.txt_enterPassword.layer.masksToBounds=YES;
    self.txt_enterPassword.layer.borderWidth=1.0;
    self.txt_enterPassword.layer.borderColor=[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0].CGColor;
    
    [HKCommen addHeadTitle:@"登录" whichNavigation:self.navigationItem];
}

-(void)initPassword
{
    [self.btn_commit setTitle:@"完成" forState:UIControlStateNormal];
    
    UIImageView *phoneView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    [phoneView setFrame:CGRectMake(10, 0, 17, 22)];
    UIView *firstView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 22)];
    [firstView addSubview:phoneView];
    self.txt_confirmPassword.leftView=firstView;
    self.txt_confirmPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txt_confirmPassword.layer.cornerRadius=7.0;
    self.txt_confirmPassword.layer.masksToBounds=YES;
    self.txt_confirmPassword.layer.borderWidth=1.0;
    self.txt_confirmPassword.layer.borderColor=[UIColor colorWithRed:104.0/255.0 green:190.0/255.0 blue:239.0/255.0 alpha:1.0].CGColor;
    
    UIImageView *codeView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    [codeView setFrame:CGRectMake(10, 0, 17, 22)];
    UIView *secondtView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 22)];
    [secondtView addSubview:codeView];
    self.txt_enterPassword.leftView=secondtView;
    self.txt_enterPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txt_enterPassword.layer.cornerRadius=7.0;
    self.txt_confirmPassword.layer.masksToBounds=YES;
    self.txt_enterPassword.layer.borderWidth=1.0;
    self.txt_enterPassword.layer.borderColor=[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0].CGColor;
    
    [HKCommen addHeadTitle:@"设置交易密码" whichNavigation:self.navigationItem];
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
