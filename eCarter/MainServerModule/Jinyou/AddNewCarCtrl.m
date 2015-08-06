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

@interface AddNewCarCtrl ()<UITableViewDataSource,UITableViewDelegate,carSelect>

@end

@implementation AddNewCarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"新增车辆" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    self.arrayOfCar=[NSArray arrayWithObjects:@"请选择品牌／车系",@"选择车款／排量系",@"请选择颜色", nil];
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
    [rightButton setFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(goCommit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
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
    return 0;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId1 = @"CarNumCell";
    NSString* cellId2 = @"SelectCarCell";
    NSString* cellId3 = @"CarDetailCell";
    NSString* cellId4 = @"ButtonCell";
    
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
            vc.JudgeWhereFrom=@"name";
            
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else if (indexPath.row==1) {
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            vc.JudgeWhereFrom=@"series";
            
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        else if (indexPath.row==2) {
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            
            vc.JudgeWhereFrom=@"color";
            
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
    }
}


- (void)goCommit:(UIButton*)sender
{

    CarNumCell* cellCarNo = (CarNumCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    NSString* strCarNo = [NSString stringWithFormat:@"%@%@",cellCarNo.lblCarNo.text,cellCarNo.textFiledCarNo.text];
    
    //车系
    
    SelectCarCell* cellSelectCar1 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    NSString* strSelectCar1 = cellSelectCar1.lbl_KindOfCar.text;
    
    //排量
    
    SelectCarCell* cellSelectCar2 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    NSString* strSelectCar2 = cellSelectCar2.lbl_KindOfCar.text;
    
    //颜色
    
    SelectCarCell* cellSelectCar3 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    
    NSString* strSelectCar3 = cellSelectCar3.lbl_KindOfCar.text;
    
    
    CarDetailCell* cellCarDetail = (CarDetailCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    
    NSString* strFadongji = cellCarDetail.textFiledFadongji.text;
    NSString* strChejia   = cellCarDetail.textFiledChejia.text;
    
    if (![HKCommen validateCarNo:cellCarNo.textFiledCarNo.text]) {
        
        [HKCommen addAlertViewWithTitel:@"请输入正确的车牌号"];
     
        return;
        
    }else if ([strSelectCar1 isEqualToString:[self.arrayOfCar objectAtIndex:0]]){
    
        [HKCommen addAlertViewWithTitel:@"请选择车系"];
        
        return;
    
    }else if ([strSelectCar2 isEqualToString:[self.arrayOfCar objectAtIndex:1]]){
        
        [HKCommen addAlertViewWithTitel:@"请选择车款"];
        
        return;
        
    }else if ([strSelectCar3 isEqualToString:[self.arrayOfCar objectAtIndex:2]]){
        
        [HKCommen addAlertViewWithTitel:@"请选择颜色"];
        
        return;
        
        
    }else if (![HKCommen validateSixNumber:strFadongji]){
    
        [HKCommen addAlertViewWithTitel:@"请输入发动机号后六位"];
        
        return;
    
    
    }else if (![HKCommen validateSixNumber:strChejia]){
        
        [HKCommen addAlertViewWithTitel:@"请输入车架号后六位"];
        
        return;
        
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)handleCarSlect:(NSDictionary *)dic
{
    NSLog(@"handleCarSlect = %@",dic);
    //车系
    SelectCarCell* cellSelectCar1 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    //排量
    SelectCarCell* cellSelectCar2 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    //颜色
    SelectCarCell* cellSelectCar3 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    
    
    if ([dic objectForKey:@"name"]) {
        
        cellSelectCar1.lbl_KindOfCar.text = [dic objectForKey:@"name"];
        
        
    }else if ([dic objectForKey:@"series"]) {
        
        cellSelectCar2.lbl_KindOfCar.text = [dic objectForKey:@"series"];
        
    }else if ([dic objectForKey:@"color"]) {
        
        cellSelectCar3.lbl_KindOfCar.text = [dic objectForKey:@"color"];
        
        
    }


}




@end







