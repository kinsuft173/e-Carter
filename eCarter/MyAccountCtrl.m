//
//  MyAccountCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyAccountCtrl.h"
#import "HKCommen.h"
#import "UserDataManager.h"
#import "UserLoginInfo.h"
#import "NetworkManager.h"

@interface MyAccountCtrl ()
@property (nonatomic,strong)UserLoginInfo *userInfo;
@end

@implementation MyAccountCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"个人信息" whichNavigation:self.navigationItem];
    self.judgeSex=YES;
    
    self.lbl_mobile.text=[UserDataManager shareManager].userLoginInfo.user.phone;
    self.txt_name.placeholder = [UserDataManager shareManager].userLoginInfo.user.nickname;
    
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
    
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 40)];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    
    [self setLine];
}

- (IBAction)selectBOT:(UIButton *)sender {
    self.judgeSex=YES;
    [self.btn_boy setImage:[UIImage imageNamed:@"but_checked"] forState:UIControlStateNormal];
    [self.btn_girl setImage:[UIImage imageNamed:@"but_Unchecked"] forState:UIControlStateNormal];
}

- (IBAction)selectGIRL:(UIButton *)sender {
    self.judgeSex=NO;
    [self.btn_boy setImage:[UIImage imageNamed:@"but_Unchecked"] forState:UIControlStateNormal];
    [self.btn_girl setImage:[UIImage imageNamed:@"but_checked"] forState:UIControlStateNormal];
}


-(void)setLine
{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 44.0 - SINGLE_LINE_ADJUST_OFFSET, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
    headView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, 56.0 - SINGLE_LINE_ADJUST_OFFSET, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
    middleView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    UIView *underView=[[UIView alloc]initWithFrame:CGRectMake(0, 144.0 - SINGLE_LINE_ADJUST_OFFSET, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
    underView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    [self.view addSubview:headView];
    [self.view addSubview:middleView];
    [self.view addSubview:underView];
}

-(void)save
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    NSString *sex;
    if (self.judgeSex) {
        sex=@"男";
    }
    else
    {
    sex=@"女";
    }
    
    if ([self.txt_name.text isEqualToString:@""]) {
        [HKCommen addAlertViewWithTitel:@"请输入姓名"];
        return;
    }
    
   
    [dic setValue:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    [dic setValue:self.txt_name.text forKey:@"name"];
    [dic setValue:sex forKey:@"sex"];
    
    NSLog(@"账户字典：%@",dic);
    
    [[NetworkManager shareMgr] server_EditUserInfo:dic completeHandle:^(NSDictionary *response) {
        
        NSLog(@"response = %@",response);
        
        if ([[response objectForKey:@"message"] isEqualToString:@"OK"]) {
            
           // NSLog(@"修改成功");
            
            [HKCommen addAlertViewWithTitel:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [HKCommen addAlertViewWithTitel:@"修改失败!"];
            //NSLog(@"修改失败");
        }
    }];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
