//
//  TransactionCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "TransactionCtrl.h"
#import "NetworkManager.h"
#import "NewworkConfig.h"
#import "PersonalCenterCtrl.h"
#import "UserDataManager.h"

@interface TransactionCtrl ()
@property (nonatomic,strong)NSTimer *count_Timer;
@property (assign)NSUInteger numCount;
@property (assign) NSUInteger countEveryTime;
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
    self.txt_phone.delegate=self;
    
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
    self.txt_code.delegate=self;
    
    self.btn_sendCode.layer.cornerRadius=5.0;
    self.btn_sendCode.layer.masksToBounds=YES;
    [self.btn_sendCode addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    
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

    
    if ([self.judgeLoginOrPassword isEqualToString:@"login"]) {
        [self initLogin];
    }
    else if ([self.judgeLoginOrPassword isEqualToString:@"password"])
    {
        [self initPassword];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initLogin
{
    [HKCommen addHeadTitle:@"登录" whichNavigation:self.navigationItem];
    [self.btn_goNext addTarget:self action:@selector(goToPersonalCenter) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton addTarget:self action:@selector(doNothing) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
}

-(void)doNothing
{}

-(void)initPassword
{
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
    
    [self.btn_goNext addTarget:self action:@selector(goSetPassword) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==self.txt_code) {

        self.txt_code.layer.borderColor=[UIColor colorWithRed:104.0/255.0 green:190.0/255.0 blue:239.0/255.0 alpha:1.0].CGColor;
        
        self.txt_phone.layer.borderColor=[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0].CGColor;
        
        return YES;
    }
    
    else if (textField==self.txt_phone)
    {

        self.txt_phone.layer.borderColor=[UIColor colorWithRed:104.0/255.0 green:190.0/255.0 blue:239.0/255.0 alpha:1.0].CGColor;
        
        self.txt_code.layer.borderColor=[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0].CGColor;
        return YES;
    }
    
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stop];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)sendCode
{
    self.numCount=10;
    self.count_Timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountTime) userInfo:nil repeats:YES];
    [self.btn_sendCode setBackgroundColor:[UIColor lightGrayColor]];
    [self.btn_sendCode setTitle:@"" forState:UIControlStateNormal];
    self.btn_sendCode.enabled=NO;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init ];
    [dic setObject:self.txt_phone.text forKey:@"phone"];
    
    
    [[NetworkManager shareMgr] server_genCodeWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSData *doubi = response;
        
        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
        NSLog(@"订单字典：%@",shabi);
        self.txt_code.text = shabi;
    }];
    
    
    /*
    NSString* strUrl = [NSString stringWithFormat:@"%@/ecar/mobile/genCode", SERVER];
    
    NSString *result= [[NetworkManager shareMgr] server_GetIdentyCode:dic url:strUrl];
    
    self.checkCode=result;
    */
    
}

-(void)CountTime
{
    if (self.numCount!=0) {
        self.lbl_ShowTime.hidden=NO;
        self.lbl_ShowTime.text=[NSString stringWithFormat:@"%d",self.numCount];
        self.numCount--;
    }
    else
    {
        [self stop];
        self.lbl_ShowTime.hidden=YES;
        self.btn_sendCode.enabled=YES;
        [self.btn_sendCode setBackgroundColor:[UIColor colorWithRed:104.0/255.0 green:190.0/255.0 blue:239.0/255.0 alpha:1.0]];
        [self.btn_sendCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
    
    
}

-(void)stop
{
    if (self.count_Timer&&[self.count_Timer isValid]) {
        [self.count_Timer invalidate];
    }
    
    self.count_Timer=nil;
}



-(void)goToPersonalCenter
{
    /*
    if (![self.txt_code.text isEqualToString:self.checkCode]) {

        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:[NSString stringWithFormat:@"请输入：%@",self.checkCode] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];

        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }
    else
    {
     */
        NSLog(@"goPersonalCenter");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:self.txt_phone.text forKey:@"phone"];
        [dic setObject:self.txt_code.text forKey:@"code"];
        
        [[NetworkManager shareMgr] server_loginWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSDictionary* dicTmep = [response objectForKey:@"data"];
            NSLog(@"登陆字典：%@",dicTmep);
            
            if (dicTmep) {
                
                [UserDataManager shareManager].userLoginInfo = [UserLoginInfo objectWithKeyValues:dicTmep];
                [UserDataManager shareManager].userLoginInfo.user = [User objectWithKeyValues:dicTmep];
                
                UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
                PersonalCenterCtrl* vc = [storyBoard instantiateViewControllerWithIdentifier:@"PersonalCenter"];
                vc.loginCome=@"yes";
                
                [[UserDataManager shareManager] writeUserData];
                
                [self.navigationController pushViewController:vc animated:YES];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"checkUser"];
                
            }
            
            hud.hidden = YES;
            
        }];
    
}

- (void)goSetPassword
{
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
