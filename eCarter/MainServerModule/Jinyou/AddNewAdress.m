//
//  AddNewAdress.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "AddNewAdress.h"
#import "HKCommen.h"
#import "HKMapCtrl.h"
#import "HKMapManager.h"
#import "HKMapManager.h"
#import "NetworkManager.h"
#import "UserDataManager.h"

@interface AddNewAdress ()<UITextViewDelegate>

@end

@implementation AddNewAdress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.province=@"广东省";
    self.city=@"广州市";
    self.place=@"天河区";
    self.type = @"1";
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([HKMapManager shareMgr].address) {
        
        self.lbl_AdressOfSelect.text = [HKMapManager shareMgr].address;
    }

}

-(void)initUI
{
    [HKCommen addHeadTitle:@"编辑地址" whichNavigation:self.navigationItem];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [rightButton setFrame:CGRectMake(0, 0, 30, 50)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    rightButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=item;
    
    self.lbl_Alert.text= @"你选择的位置暂时未提供服务；已反馈给商家，敬请期待";
    self.lbl_AdressOfSelect.text=[NSString stringWithFormat:@"%@%@%@",self.province,self.city,self.place];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save
{
    
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:self.type forKey:@"type"];
    [dic setObject:self.province forKey:@"string"];
    [dic setObject:self.city forKey:@"city"];
    [dic setObject:self.place forKey:@"area"];
    
    if (self.txt_AdressDetail.text) {
        [dic setObject:self.txt_AdressDetail.text forKey:@"detail"];
    }

    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    
    [[NetworkManager shareMgr] server_addUserAddressWithDic:dic completeHandle:^(NSDictionary *response) {
        
        

        NSString* messege = [response objectForKey:@"message"];

        
        if ([messege isEqualToString:@"OK"]) {
            

            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCarOrAddress" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        hud.hidden = YES;
        
    }];
    

}

- (IBAction)goMapCtrl:(id)sender
{
    HKMapCtrl* vc  = [[HKMapCtrl alloc]  initWithNibName:@"HKMapCtrl" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        
        self.lbl_placeHolder.text = @"请输入详细地址";
        
    }else{
    
        self.lbl_placeHolder.text = @"";
    
    }


}




@end
