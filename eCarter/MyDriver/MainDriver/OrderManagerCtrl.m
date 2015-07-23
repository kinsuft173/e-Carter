//
//  OrderManagerCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "OrderManagerCtrl.h"

@interface OrderManagerCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OrderManagerCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    [HKCommen addHeadTitle:@"订单管理" whichNavigation:self.navigationItem];
}

-(void)initUI
{
    self.table_waiting.hidden=NO;
    self.table_servicing.hidden=YES;
    self.table_returning.hidden=YES;
    self.table_receiving.hidden=YES;
    self.table_complete.hidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OrderWaiting:(UIButton *)sender {
    self.table_waiting.hidden=NO;
    self.table_servicing.hidden=YES;
    self.table_returning.hidden=YES;
    self.table_receiving.hidden=YES;
    self.table_complete.hidden=YES;
    
}

- (IBAction)BusWaiting:(UIButton *)sender {
    self.table_waiting.hidden=NO;
    self.table_servicing.hidden=YES;
    self.table_returning.hidden=YES;
    self.table_receiving.hidden=YES;
    self.table_complete.hidden=YES;
}

- (IBAction)Servicing:(UIButton *)sender {
    self.table_waiting.hidden=YES;
    self.table_servicing.hidden=NO;
    self.table_returning.hidden=YES;
    self.table_receiving.hidden=YES;
    self.table_complete.hidden=YES;
}

- (IBAction)CarReturning:(UIButton *)sender {
    self.table_waiting.hidden=YES;
    self.table_servicing.hidden=YES;
    self.table_returning.hidden=NO;
    self.table_receiving.hidden=YES;
    self.table_complete.hidden=YES;
}

- (IBAction)OrderCompleted:(UIButton *)sender {
    self.table_waiting.hidden=YES;
    self.table_servicing.hidden=YES;
    self.table_returning.hidden=YES;
    self.table_receiving.hidden=YES;
    self.table_complete.hidden=NO;
}



- (NSInteger)tableView:(UITableView * )tableView
 numberOfRowsInSection:(NSInteger)section
{

    
    return 4;
}

- (UITableViewCell * )tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.row==0) {
        static NSString *mainOrderCell=@"OrderManagerCell";
        OrderManagerCell *cell=[tableView dequeueReusableCellWithIdentifier:mainOrderCell];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:mainOrderCell owner:self options:nil][0];
        }

        
        return cell;
    }
    else if(indexPath.row==1)
    {
        static NSString *progressIndentifier=@"OrderProgressCell";
        OrderProgressCell *cell=[tableView dequeueReusableCellWithIdentifier:progressIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:progressIndentifier owner:self options:nil][0];
        }
        cell.lbl_TimeOfOrder.text=@"2015-02-20 14:35:25";
        
        return cell;
    }
    
    else if(indexPath.row==2)
    {
        static NSString *callingIndentifier=@"CallingCell";
        CallingCell *cell=[tableView dequeueReusableCellWithIdentifier:callingIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:callingIndentifier owner:self options:nil][0];
        }

        return cell;
    }
    
    else
    {
        static NSString *buttonCellIndentifier=@"ButtonCell";
        ButtonCell *cell=[tableView dequeueReusableCellWithIdentifier:buttonCellIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:buttonCellIndentifier owner:self options:nil][0];
        }
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView * )tableView
heightForRowAtIndexPath:(NSIndexPath * )indexPath
{
    
    if (indexPath.row==0) {
        return 297.0;
    }
    else if(indexPath.row==1)
    {
        return 113.0;
    }
    else if(indexPath.row==2)
    {
        return 127.0;
    }
    else
    {
        return 80.0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (void)tableView:(UITableView * )tableView
didSelectRowAtIndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            [self performSegueWithIdentifier:@"goOrderStatus" sender:nil];
        }
    }
}

@end


















