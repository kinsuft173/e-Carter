//
//  MyCarLibrary.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyCarLibrary.h"
#import "AddCarCell.h"
#import "CarInfoCell.h"
#import "PlaceHolderCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "Car.h"
#import "UserDataManager.h"
#import "UserLoginInfo.h"

@interface MyCarLibrary ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)NSArray *arrayOfCar;
@end

@implementation MyCarLibrary

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen addHeadTitle:@"我的车库" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    
    [self getModel];
    
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
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    
    NSLog(@"车库字典：%@",dic);
    
    [[NetworkManager shareMgr] server_queryCarSeriesWithDic:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"字典：%@",responseBanner);
        
        self.arrayOfCar = [responseBanner objectForKey:@"data"];
        
        [self.myTable reloadData];
        
        
    }];
    
    
    
}


- (void)CancelCar:(NSString*)carId
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    [dic setObject:carId forKey:@"carId"];
    
    NSLog(@"删除字典：%@",dic);
    
    [[NetworkManager shareMgr] server_deleteCarWithDic:dic completeHandle:^(NSDictionary *responseBanner) {
        
        
        
        if ([[responseBanner objectForKey:@"message"] isEqualToString:@"OK"]) {
            [HKCommen addAlertViewWithTitel:@"删除成功"];
            [self getModel];
        }
        else
        {
            [HKCommen addAlertViewWithTitel:@"删除失败"];
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

#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else{
    
        return self.arrayOfCar.count*2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 44;
        
    }else if(indexPath.row % 2 == 0){
        
        return 12;
        
    }else{
    
        return 165;
    
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"AddCarCell";
    static NSString* cellId2 = @"CarInfoCell";
    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.row % 2 == 0 && indexPath.section != 0) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            cell.contentView.backgroundColor = [HKCommen  getColor:@"f1f1f1" WithAlpha:1.0];
            
        }
        
        return cell;
        
        
    }else if(indexPath.section == 0){
        
        AddCarCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
        
    }else if(indexPath.row % 2 != 0){
    
        CarInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
        }
        
        
        
        NSUInteger row=(indexPath.row-1)/2;
        
        Car *car=[Car objectWithKeyValues:[self.arrayOfCar objectAtIndex:row]];
        cell.lbl_brand.text=car.brand;
        cell.lbl_colorOfCar.text=car.color;
        cell.lbl_engine.text=car.engineNo;
        cell.lbl_nameOfCar.text=[NSString stringWithFormat:@"爱车%ld号",row+1];
        cell.lbl_numOfCar.text=car.no;
        cell.lbl_numOfFrame.text=car.frameNo;
        cell.lbl_year.text=car.year;
        cell.lbl_volume.text=car.volume;
        cell.lbl_seriesOfCar.text=car.model;
        
        
        
        [cell.btn_DeleteCar setTag:car.id];
        [cell.btn_DeleteCar addTarget:self action:@selector(DeleteCar:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    
    }
    return nil;
}

-(void)DeleteCar:(UIButton*)button
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除车辆" message:@"是否删除该车辆？" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:
                               ^(UIAlertAction *action) {
                                   [self CancelCar:[NSString stringWithFormat:@"%ld",button.tag]];
                               }
                               ];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
      
            AddNewCarCtrl *vc=[[AddNewCarCtrl alloc] initWithNibName:@"AddNewCarCtrl" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }


@end
