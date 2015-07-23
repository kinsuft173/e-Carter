//
//  SettingCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SettingCtrl.h"

@interface SettingCtrl ()

@end

@implementation SettingCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"设置" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    self.arrayOfInfo=[NSArray arrayWithObjects:@"设置交易密码",@"关于我们",@"分享",@"版本更新", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        return 68;
    }
    
    return 44;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"SettingCell";
    NSString *address=@"AddAdressCell";

 
    if (indexPath.section==0) {
        SettingCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] objectAtIndex:0];
            
        }
        cell.lbl_info.text=[self.arrayOfInfo objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        AddAdressCell* cell = [tableView dequeueReusableCellWithIdentifier:address];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:address owner:self options:nil] objectAtIndex:0];
            
        }
        
        [cell.btn_commit setTitle:@"退出登录" forState:UIControlStateNormal];
        [cell.btn_commit addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    

    
}

-(void)loginOut
{
    SetTransactionPassworsCtrl *vc=[[SetTransactionPassworsCtrl alloc] initWithNibName:@"SetTransactionPassworsCtrl" bundle:nil];
    vc.judgeLoginOrPassword=@"login";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        TransactionCtrl *vc=[[TransactionCtrl alloc] initWithNibName:@"TransactionCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==1) {
        AboutUsCtrl *vc=[[AboutUsCtrl alloc] initWithNibName:@"AboutUsCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
