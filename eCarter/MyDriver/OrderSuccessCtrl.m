//
//  OrderSuccessCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/4.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "OrderSuccessCtrl.h"


@interface OrderSuccessCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OrderSuccessCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [HKCommen addHeadTitle:@"抢单成功" whichNavigation:self.navigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView * )tableView
 numberOfRowsInSection:(NSInteger)section
{

    
    return 3;
}

- (UITableViewCell * )tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.row==0) {
        static NSString *successCellIndentifier=@"OrderSuccessCell";
        OrderSuccessCell *cell=[tableView dequeueReusableCellWithIdentifier:successCellIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:successCellIndentifier owner:self options:nil][0];
        }
        

        
        return cell;
    }
    else if(indexPath.row==1)
    {
        static NSString *orderCellIndentifier=@"OrderManagerCell";
        OrderManagerCell *cell=[tableView dequeueReusableCellWithIdentifier:orderCellIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:orderCellIndentifier owner:self options:nil][0];
        }
        
        cell.lbl_contentOfService.text=@"洗车";
        cell.lbl_IdOfOrder.text=@"THTX123456";
        cell.lbl_Owner.text=@"张先生";
        cell.lbl_Price.text=@"39.00元";
        cell.lbl_statusOfOrder.text=@"待受理";
        cell.lbl_attributeOfCar.text=@"黑色：奥迪：粤A 6666";
        
        
        
        
        
        return cell;
    }
    else if (indexPath.section==2) {
        static NSString *progressCellIndentifier=@"OrderProgressCell";
        OrderProgressCell *cell=[tableView dequeueReusableCellWithIdentifier:progressCellIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:progressCellIndentifier owner:self options:nil][0];
        }
        
        
        
        return cell;
    }
    else
    {
        static NSString *callingCellIndentifier=@"CallingCell";
        OrderSuccessCell *cell=[tableView dequeueReusableCellWithIdentifier:callingCellIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:callingCellIndentifier owner:self options:nil][0];
        }
        
        
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView * )tableView
heightForRowAtIndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.row==0) {
        return 121;
    }
    else if (indexPath.row==1)
    {
        return 297;
    }else if (indexPath.row==2)
    {
        return 113;
    }else
    {
        return 127;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (void)tableView:(UITableView * )tableView
didSelectRowAtIndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==2) {
            [self performSegueWithIdentifier:@"goOrderManager" sender:nil];
        }

    }
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{

    return 20;
}


@end







