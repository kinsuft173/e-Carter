//
//  AddNewCarCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "AddNewCarCtrl.h"
#import "CarNumCell.h"
#import "SelectCarCell.h"
#import "CarDetailCell.h"
#import "ButtonCell.h"
#import "HKCommen.h"

@interface AddNewCarCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AddNewCarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"新增车辆" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    self.arrayOfCar=[NSArray arrayWithObjects:@"请选择品牌／车系",@"选择车款／排量系",@"请选择颜色", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        return 44;
    }
    else if (indexPath.section==1)
    {
        return 44;
    }
    else if (indexPath.section==2)
    {
        return 133;
    }
    else
    {
        return 85;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId1 = @"CarNumCell";
    NSString* cellId2 = @"SelectCarCell";
    NSString* cellId3=@"CarDetailCell";
    NSString* cellId4=@"ButtonCell";
    
    if (indexPath.section == 0) {
        
        CarNumCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }

        
        return cell;
        
        
    }
    
    else  if(indexPath.section==1){
        
        SelectCarCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
        }
        cell.lbl_KindOfCar.text=[self.arrayOfCar objectAtIndex:indexPath.row];

        return cell;
        
    }
    else  if(indexPath.section==2){
        
        CarDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
        }
        
        return cell;
        
    }
    else  if(indexPath.section==3){
        
        ButtonCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId4];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId4 owner:self options:nil] objectAtIndex:0];
        }
        [cell.btn_commitButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [cell.btn_commitButton addTarget:self action:@selector(goCommit:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section==1||section==2) {
        return 12.0;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            vc.JudgeWhereFrom=@"series";
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        else if (indexPath.row==1) {
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            vc.JudgeWhereFrom=@"name";
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        else if (indexPath.row==2) {
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            
            vc.JudgeWhereFrom=@"color";
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
    }
}


- (void)goCommit:(UIButton*)sender
{



}

@end







