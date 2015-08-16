//
//  SelectCarAndAressCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/25.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SelectCarAndAressCtrl.h"
#import "PhoneInfoCell.h"
#import "AddInfoCell.h"
#import "CarAndAdressCell.h"
#import "NextStepCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "UserDataManager.h"
#import "Car.h"
#import "UserAddress.h"
#import "SelfGetCtrl.h"

@interface SelectCarAndAressCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* arrayCars;
@property (nonatomic, strong) NSMutableArray* arrayAdresses;

@property (nonatomic, strong) NSIndexPath* indexPathCar;
@property (nonatomic, strong) NSIndexPath* indexPathAddress;

@end

@implementation SelectCarAndAressCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.arrayAdresses = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
//    self.arrayCars = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
    
//    self.tableView.backgroundColor = [UIColor colorWithRed:0xaa/256.0 green:0xaa/256.0 blue:0xaa/256.0 alpha:0.2];
    [HKCommen setExtraCellLineHidden:self.tableView];
    
    [HKCommen addHeadTitle:@"上门服务" whichNavigation:self.navigationItem];
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    
    
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
    
    [self getModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"changeCarOrAddress" object:nil];
}


- (void)getModel
{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.phone,@"phone", [UserDataManager shareManager].userLoginInfo.sessionId,@"sessionId",nil];
    
    [[NetworkManager shareMgr] server_queryUserAddressWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSArray* tempArray = [response objectForKey:@"data"];
        
        if (tempArray.count != 0) {
            
            self.arrayAdresses = tempArray;
            
        }
    
        [self.tableView reloadData];
        
    }];
    
    
    [[NetworkManager shareMgr] server_queryUserCarWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSArray* tempArray = [response objectForKey:@"data"];
        
        if (tempArray.count != 0) {
            
            self.arrayCars = tempArray;
            
        }
        
        [self.tableView reloadData];
        
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"goSelfList"]) {
        
        SelfGetCtrl* vc = segue.destinationViewController;
        
        vc.userAddress = [UserAddress objectWithKeyValues:[self.arrayAdresses objectAtIndex:(self.indexPathAddress.row - 1)]];
        
        vc.userCar = [Car objectWithKeyValues:[self.arrayCars  objectAtIndex:self.indexPathCar.row - 1]];
    }
}


#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1){
    
        return self.arrayCars.count + 1;
    
    }else if (section == 2){
    
        return self.arrayAdresses.count + 1;
    
    }else if(section == 3){
    
        return 1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        
        return 100;
        
    
    }
    
    if (indexPath.row==0) {
        return 40;
    }
    
        return 44;
    
    
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"PhoneInfoCell";
    static NSString* cellId2 = @"AddInfoCell";
    static NSString* cellId3 = @"CarAndAdressCell";
    static NSString* cellId4 = @"NextStepCell";
    
    if (indexPath.section == 0) {
        
        PhoneInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }else if ((indexPath.section == 1 && indexPath.row == 0)|| (indexPath.section == 2 && indexPath.row == 0)){
    
        AddInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
        }
        
        
        if (indexPath.section == 1) {
        
            cell.lblContent.text = @"添加车辆";
            
        }else{
        
            cell.lblContent.text = @"添加地址";
        }
        
        return cell;
    
    
    
    }else if (indexPath.section == 3){
        

        NextStepCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId4];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId4 owner:self options:nil] objectAtIndex:0];
            
        }
        
        [cell.btnNextStep addTarget:self action:@selector(goNextStep:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else{
    
        CarAndAdressCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        

        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
            
        }
        
        
        if (indexPath.section == 1) {
            
            

            
            cell.lblContent.text = @"粤A8888 白色 奥迪A1";
            
            if (self.indexPathCar.row == indexPath.row && self.indexPathCar.section == indexPath.section) {
                
                cell.img_btn.image = [UIImage imageNamed:@"but_checked"];
            }else{
            
                cell.img_btn.image = [UIImage imageNamed:@"but_Unchecked"];
            
            }
            
        }else{
            
            NSDictionary* dic = [self.arrayAdresses objectAtIndex:indexPath.row - 1];
            
            if ([[dic class] isSubclassOfClass:[NSDictionary class]]) {
                cell.lblContent.text = [NSString  stringWithFormat:@"家庭地址：%@%@%@",[dic objectForKey:@"city"],[dic objectForKey:@"area"],[dic objectForKey:@"address"],[dic objectForKey:@"address"] ];
            }
            
            if (self.indexPathAddress.row == indexPath.row && self.indexPathAddress.section == indexPath.section) {
                
                cell.img_btn.image = [UIImage imageNamed:@"but_checked"];
                
            }else{
            
                cell.img_btn.image = [UIImage imageNamed:@"but_Unchecked"];
            }
        }
        
        return cell;
    
    
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        
        return 12;
        
    }
    
    return 0 ; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [HKCommen getColor:@"ededed"];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            AddNewCarCtrl *vc=[[AddNewCarCtrl alloc] initWithNibName:@"AddNewCarCtrl" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
        
            self.indexPathCar = indexPath;
            
            [self.tableView reloadData];
        
        
        
        
        }
    }
    else if (indexPath.section==2) {
        if (indexPath.row==0) {
            AddNewAdress *vc=[[AddNewAdress alloc] initWithNibName:@"AddNewAdress" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            self.indexPathAddress = indexPath;
            
            [self.tableView reloadData];
            
            
            
            
        }
    }
}


#pragma mark - custom methods

- (void)goNextStep:(UIButton*)btn
{
    if (self.indexPathAddress.row == 0) {
        
        [HKCommen addAlertViewWithTitel:@"请选择地址"];
        
        return;
        
    }
    
    if (self.indexPathCar.row == 0) {
        
        [HKCommen addAlertViewWithTitel:@"请选择车辆"];
        
        return;
        
    }
    
    
    [self performSegueWithIdentifier:@"goSelfList" sender:nil];
//    PaymentCtrl *vc=[[PaymentCtrl alloc] initWithNibName:@"PaymentCtrl" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];

}

@end
