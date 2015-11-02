//
//  PersonalCenterCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "PersonalCenterCtrl.h"
#import "PersonInfoCell.h"
#import "PersonNormalCell.h"
#import "PlaceHolderCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "UserDataManager.h"
#import "FirstViewCtrl.h"
#import "MyOrderCtrl.h"

@interface PersonalCenterCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  NSArray* arrayInfo;
@property (nonatomic, strong)  NSArray* arrayImage;
@property (nonatomic, strong)  IBOutlet UITableView* tableView;

@end

@implementation PersonalCenterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen setExtraCellLineHidden:self.tableView];
    //[self getModel];
    
    self.arrayInfo = [NSArray arrayWithObjects:@"我的订单",@"我的账户",@"我的车库",@"我的地址",@"交易记录",@"我的优惠券",@"我的e积分", nil];
    self.arrayImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"mine_My-order"],[UIImage imageNamed:@"mine_My-account"],[UIImage imageNamed:@"mine_mycar"],[UIImage imageNamed:@"mine_Address"],[UIImage imageNamed:@"mine_Trade-record"],[UIImage imageNamed:@"mine_On-Sale"],[UIImage imageNamed:@"mine_Integral"]];
    
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
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goMyOrder2) name:@"goMyOrder2" object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.fromMyOrder2 == 1) {
        
        self.fromMyOrder2 = 0;
        
        [self performSelector:@selector(goMyOrder2) withObject:nil afterDelay:0.2];
        
        
    }
    
    
}

- (void)goMyOrder2
{
    
    [self performSegueWithIdentifier:@"goMyOrder" sender:nil];
}

-(void)back
{
//    NSString *check=[[NSUserDefaults standardUserDefaults] objectForKey:@"checkUser"];
//    
//    if ([self.loginCome isEqualToString:@"yes"]) {
//        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        FirstViewCtrl *vc=[story instantiateViewControllerWithIdentifier:@"FirstViewCtrl"];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else
//    {
//        if ([check isEqualToString:@"yes"]) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            FirstViewCtrl *vc=[story instantiateViewControllerWithIdentifier:@"FirstViewCtrl"];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];

    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];

}

- (void)getModel
{
    
//    [[NetworkManager shareMgr] server_loginWithDic:nil completeHandle:^(NSDictionary *response) {
//        
//        NSDictionary* dicTmep = [response objectForKey:@"data"];
//        
//        if (dicTmep) {
//            
//            [UserDataManager shareManager].userLoginInfo = [UserLoginInfo objectWithKeyValues:dicTmep];
//            
//        }
//        
//        [self.tableView  reloadData];
//        
//    }];
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1){
        
        return 4;
        
    }else{
        
        return 5;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 80;
        
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            return 10;
            
        }
        
        return 44;
        
    }else{
        
        
        if (indexPath.row == 0) {
            
            return 10;
            
        }
        
        
        return 44;
        
    }
    
    
    return 0;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"PersonInfoCell";
    static NSString* cellId2 = @"PersonNormalCell";
    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.section == 0) {
        
        PersonInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        cell.imgHead.layer.cornerRadius=30.0;
        cell.imgHead.layer.masksToBounds=YES;
        
        if ([UserDataManager shareManager].userLoginInfo) {
            
            [cell.imgHead sd_setImageWithURL:[NSURL URLWithString:[UserDataManager shareManager].userLoginInfo.user.avatarUrl]
                            placeholderImage:[UIImage imageNamed:PlaceHolderImage] options:SDWebImageContinueInBackground];
            
            if ([UserDataManager shareManager].userLoginInfo.user.nickname.length >0) {
                
                if ([[UserDataManager shareManager].userLoginInfo.user.sex isEqualToString:@"男"]) {
                    cell.lblName.text = [NSString stringWithFormat:@"%@先生",[[UserDataManager shareManager].userLoginInfo.user.nickname substringToIndex:1]];
                }else{
                
                    cell.lblName.text = [NSString stringWithFormat:@"%@女士",[[UserDataManager shareManager].userLoginInfo.user.nickname substringToIndex:1]];
                
                }
                
                if ([[UserDataManager shareManager].userLoginInfo.user.nickname isEqualToString:[UserDataManager shareManager].userLoginInfo.user.phone]) {
                    
                    
                    cell.lblName.text = [UserDataManager shareManager].userLoginInfo.user.phone;
                    
                }
                

                
            }
            

            
            cell.lblPhoneNumber.text = [UserDataManager shareManager].userLoginInfo.user.phone;
            
        }
        
        CGFloat pixelAdjustOffset = 0;
        
        if (((int)(SINGLE_LINE_WIDTH * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
            
            pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
            
        }
        
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0 - pixelAdjustOffset, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
        headView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        
        UIView *underView=[[UIView alloc]initWithFrame:CGRectMake(0, 80.0 - pixelAdjustOffset, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
        underView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        
        [cell.contentView addSubview:headView];
        [cell.contentView addSubview:underView];
        
        return cell;
        
    }else if (indexPath.row == 0){
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            cell.contentView.backgroundColor = [HKCommen  getColor:@"e6e6e6"];
            
        }
        
        return cell;
        
    }else{
        
        PersonNormalCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            
        }
        
        cell.lblTitel.text = [self.arrayInfo objectAtIndex:(indexPath.section-1)*3+indexPath.row- 1];
        cell.img.image = [self.arrayImage objectAtIndex:(indexPath.section - 1)*3 + indexPath.row - 1 ];
        
        /*
        CGFloat pixelAdjustOffset = 0;
        
        if (((int)(SINGLE_LINE_WIDTH * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
            
            pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
            
        }
        
        
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0 + pixelAdjustOffset, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
        headView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        
        
        UIView *underView=[[UIView alloc]initWithFrame:CGRectMake(0, 44.0 + pixelAdjustOffset, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
        underView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        
        [cell.contentView addSubview:headView];
        [cell.contentView addSubview:underView];
        */
        return cell;
        
    }
}


#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MyAccountCtrl *vc=[[MyAccountCtrl alloc] initWithNibName:@"MyAccountCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1 ) {
        
       // [self performSegueWithIdentifier:@"goMyOrder" sender:nil];
        MyOrderCtrl* vc = [[UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil] instantiateViewControllerWithIdentifier:@"goMyOrder"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 2){
        
        [self performSegueWithIdentifier:@"goMyCount" sender:nil];
        
    }else if (indexPath.section == 1 && indexPath.row == 3){
        
        [self performSegueWithIdentifier:@"goMyCar" sender:nil];
        
    }else if (indexPath.section == 2 && indexPath.row == 1){
        
        [self performSegueWithIdentifier:@"goMyAdress" sender:nil];
        
    }else if (indexPath.section == 2 && indexPath.row == 2){
        
        [self performSegueWithIdentifier:@"goMyTrade" sender:nil];
        
    }else if (indexPath.section == 2 && indexPath.row == 3){
        
        [self performSegueWithIdentifier:@"goMyCouPon" sender:nil];
        
    }else if (indexPath.section == 2 && indexPath.row == 4){
        
        PointOfMeCtrl *vc=[[PointOfMeCtrl alloc] initWithNibName:@"PointOfMeCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 5){
        
        SettingCtrl *vc=[[SettingCtrl alloc] initWithNibName:@"SettingCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (IBAction)goConfig:(id)sender
{
    
    SettingCtrl *vc=[[SettingCtrl alloc] initWithNibName:@"SettingCtrl" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
