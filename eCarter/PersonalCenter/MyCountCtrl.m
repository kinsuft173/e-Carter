//
//  MyCountCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyCountCtrl.h"
#import "MyCountMoneyCell.h"
#import "MyCountNomalCell.h"
#import "PlaceHolderCell.h"
#import "HKCommen.h"
#import "MyCountBalance.h"
#import "UserDataManager.h"
#import "UserLoginInfo.h"
#import "NetworkManager.h"

@interface MyCountCtrl ()
@property (strong,nonatomic) UserLoginInfo *userData;
@end

@implementation MyCountCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HKCommen setExtraCellLineHidden:self.myTable];

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

- (void)getModel
{
    self.userData= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:self.userData.user.uid forKey:@"userId"];
    [dic setValue:@"1" forKey:@"accountType"];
    
    NSLog(@"账户字典：%@",dic);
    
    [[NetworkManager shareMgr] server_queryUserAccountWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSLog(@"字典：%@",response);
        /*
         NSArray* arrayTemp = [response objectForKey:@"data"];
         
         if (arrayTemp.count != 0) {
         
         self.arrayAllOrder = arrayTemp;
         
         for (int i = 0 ; i < arrayTemp.count; i ++) {
         
         
         }
         }
         */
        
        [self.myTable  reloadData];
        
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

#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 12;
        
    }else if(indexPath.row == 1){
        
        return 44;
        
    }else if (indexPath.row == 2){
    
        
        return 40;
    
    }else{
    
        return 44;
    
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"MyCountMoneyCell";
    static NSString* cellId2 = @"MyCountNomalCell";
    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.row == 0 || indexPath.row == 2) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            cell.contentView.backgroundColor = [HKCommen  getColor:@"f1f1f1" WithAlpha:1.0];
            
        }
        
        return cell;
        
        
    }else if(indexPath.row == 1){
        
        MyCountMoneyCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        cell.lbl_BalanceMoney.text=@"100.0元";
        return cell;
        
        
    }else{
        
        MyCountNomalCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
        }
        
        if (indexPath.row == 3) {
            
            cell.lblTitel.text  = @"充值";
            
        }else if (indexPath.row == 4){
        
            cell.lblTitel.text = @"提现";
            
        }
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
 
        RechargeMoneyCtrl *chargeCtrl=[[RechargeMoneyCtrl alloc] initWithNibName:@"RechargeMoneyCtrl" bundle:nil];

        [self.navigationController pushViewController:chargeCtrl animated:YES];

    }
    
   else if (indexPath.row==4) {
        GetRealMoneyCtrl *vc=[[GetRealMoneyCtrl alloc]initWithNibName:@"GetRealMoneyCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
