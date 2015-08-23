//
//  SelfDetailCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SelfDetailCtrl.h"
#import "BannerCell.h"
#import "ShopInfoCell.h"
#import "TimeCell.h"
#import "ServerListCell.h"
#import "CouponSlectedCell.h"
#import "DiscountScoreCell.h"
#import "TotalCountCell.h"
#import "PaymentCell.h"
#import "CommentCell.h"
#import "ServiceCommentinfoCell.h"
#import "PaymentCtrl.h"
#import "NetworkManager.h"
#import "ShopDetail.h"
#import "UserDataManager.h"

@interface SelfDetailCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) ShopDetail* shopDetail;

@property (nonatomic, strong) NSMutableArray* arraySelectedSevice;

@end

@implementation SelfDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen setExtraCellLineHidden:self.tableView];
    
    [HKCommen addHeadTitle:@"商家详情" whichNavigation:self.navigationItem];
    
    [self addRefresh];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRefresh
{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.preDataShopId,@"storeId", nil];
        
        [[NetworkManager shareMgr] server_queryStoreDetailWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSDictionary* dic = [response objectForKey:@"data"];
            
            if (dic) {
                
                self.shopDetail = [ShopDetail objectWithKeyValues:dic];
                
                self.arraySelectedSevice = [[NSMutableArray alloc] init];
                
                for (int i = 0 ; i < self.shopDetail.serviceItemList.count; i ++) {
                    
                    [self.arraySelectedSevice addObject:@"0"];
                    
                }
                
            }
            
            
            [self.tableView.header endRefreshing];
            
            [self.tableView reloadData];
            
        }];
        
    }];
    
    
    [self.tableView.header beginRefreshing];
    
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
    if (!self.shopDetail) {
        
        return 0;
    }
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1){
        
        return 1;
        
    }else if (section == 2){
        
        return 1;
        
    }else if (section == 3){
        
        return self.shopDetail.serviceItemList.count + 4;
        
    }else if (section == 4){
        
        return self.shopDetail.reviewsList.count + 1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 150;
        
    }else if (indexPath.section == 1){
        
        return 147;
        
    }else if (indexPath.section == 2){
        
        return 44;
        
    }else if(indexPath.section == 3){
        
        if (indexPath.row == self.shopDetail.serviceItemList.count + 3) {
            
            return 84;
            
        }else if (indexPath.row <self.shopDetail.serviceItemList.count){
            
            return 34;
        
        }
        
        return 44;
        
    }else if (indexPath.section == 4){
        
        if (indexPath.row == 0) {
            
            return 40;
            
        }
        
        return 80;
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"BannerCell";
    static NSString* cellId2 = @"ShopInfoCell";
    static NSString* cellId3 = @"TimeCell";
    static NSString* cellId4 = @"ServerListCell";
    static NSString* cellId5 = @"CouponSlectedCell";
    static NSString* cellId6 = @"DiscountScoreCell";
    static NSString* cellId7 = @"TotalCountCell";
    static NSString* cellId8 = @"PaymentCell";
    static NSString* cellId9 = @"CommentCell";
    static NSString* cellId10 = @"ServiceCommentinfoCell";
    
    if (indexPath.section == 0) {
        
        BannerCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        [cell.img sd_setImageWithURL:[NSURL URLWithString:self.shopDetail.storeImg]
                    placeholderImage:[UIImage imageNamed:PlaceHolderImage] options:SDWebImageContinueInBackground];
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        ShopInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(10, 85, SCREEN_WIDTH - 10, 0.5)];
            
            divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView];
            
            UIView* divideView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 146.5, SCREEN_WIDTH, 0.5)];
            
            divideView1.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView1];
            
        }
        
        cell.lblAddress.text = self.shopDetail.address;
        cell.lblDistance.text = [NSString stringWithFormat:@"%.1fkm",[self.shopDetail.distance floatValue]];
        cell.lblStoreName.text = self.shopDetail.storeName;
        cell.lblStoreScore.text = [NSString stringWithFormat:@"(%.1f)",[self.shopDetail.storeScore floatValue]];
        cell.lblTimeStartAndEnd.text = [NSString stringWithFormat:@"营业时间:%@ - %@",self.shopDetail.startBusinessTime,self.shopDetail.endBusinessTime];
        [cell.star setStarForValue:[self.shopDetail.storeScore floatValue]];
        
        NSString* strServerItems = @"";
        for (int i = 0; i < self.shopDetail.serviceItemList.count; i++ ) {
            
            Serviceitemlist* item = [self.shopDetail.serviceItemList objectAtIndex:i];
            
            if (i == 0) {
                
                strServerItems = [strServerItems stringByAppendingString:[NSString stringWithFormat:@"%@",item.serviceItemName]];
                
            }else{
                
                strServerItems = [strServerItems stringByAppendingString:[NSString stringWithFormat:@"/%@",item.serviceItemName]];
                
            }
            
            
        }
        
        cell.lblServerItems.text = strServerItems;
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        TimeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
            
//            if (indexPath.row == 0) {
            
                UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
                
                divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
                
                [cell.contentView addSubview:divideView];
                
//            }else if (indexPath.row == 2){
                
                UIView* divideView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
                
                divideView1.backgroundColor = [HKCommen getColor:@"cccccc"];
                
                [cell.contentView addSubview:divideView1];
                
//            }
            
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row < self.shopDetail.serviceItemList.count) {
        
        ServerListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId4];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId4 owner:self options:nil] objectAtIndex:0];
            
            if (indexPath.row == 0) {
            
            UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView];
            
            }
            
            Serviceitemlist* item = [self.shopDetail.serviceItemList objectAtIndex:indexPath.row];
            
            cell.lblServerPrice.text = [NSString stringWithFormat:@"¥%@",item.amount];
            cell.lblSeverName.text = item.serviceItemName;
            
            if ([[self.arraySelectedSevice objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
                
                cell.img_Button.image = [UIImage imageNamed:@"but_Unchecked"];
                
            }else{
            
                cell.img_Button.image = [UIImage imageNamed:@"but_checked"];
            
            }
            
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count) {
        
        CouponSlectedCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId5];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId5 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count +1) {
        
        DiscountScoreCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId6];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId6 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count +2) {
        
        TotalCountCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId7];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId7 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count + 3) {
        
        PaymentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId8];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId8 owner:self options:nil] objectAtIndex:0];
            
            cell.separatorInset = UIEdgeInsetsZero;
            
            [cell.btnConfirm addTarget:self action:@selector(goToConfirmPage:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
        
    }else if (indexPath.section == 4 && indexPath.row != 0) {
        
        CommentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId6];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId9 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }else if(indexPath.section == 4 && indexPath.row == 0){
        
        
        ServiceCommentinfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId10];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId10 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        
        return 10;
        
    }
    
    return 0 ; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:0xf1/256.0 green:0xf1/256.0 blue:0xf1/256.0 alpha:1.0];
    return headerView;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//    if (indexPath.section == 3 && (indexPath.row >=3 && indexPath.row <=7) ) {
//        NSLog(@"indexPath.row===%d",indexPath.row);
//        cell.separatorInset = UIEdgeInsetsZero;
//    }
//}


#pragma  mark - custom methods
- (void)goToConfirmPage:(UIButton*)btn
{

    

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    [dic setObject:self.shopDetail.id forKey:@"storeId"];
    
    [dic setObject:[NSNumber numberWithInteger:self.userCar.id] forKey:@"carId"];
    [dic setObject:self.userCar.no forKey:@"carnum"];
    
    NSString* str = @"";
    
    for (int i = 0 ; i < self.arraySelectedSevice.count; i ++) {
        
        if ( [str isEqualToString:@""] && [[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]) {
            
            
            Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i]; //[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
            
            str = list.serviceId;//[str stringByAppendingString:list.serviceId];
            
        }else if ([[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]){
        
            Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i];//[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
            
            NSString* strTemp = [NSString stringWithFormat:@",%@",list.serviceId];
            
            str = [str stringByAppendingString:strTemp];
        
        
        }
        
        
    }
    
    if ([str isEqualToString:@""]|| str == nil) {
        
        [HKCommen addAlertViewWithTitel:@"请选择一项服务"];
    
        
        hud.hidden = YES;
        
        return;
        
    }
    
    
    
    NSString* strItemNames = @"";
    
    for (int i = 0 ; i < self.arraySelectedSevice.count; i ++) {
        
        if ( [str isEqualToString:@""] && [[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]) {
            
            
            Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i];//[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
            
            strItemNames = list.serviceItemName; //[strItemNames stringByAppendingString:list.serviceItemName];
            
        }else if ([[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]){
            
            Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i];//[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
            
            NSString* strTemp = [NSString stringWithFormat:@",%@",list.serviceItemName];
            
            strItemNames = [strItemNames stringByAppendingString:strTemp];
            
            
        }
        
        
    }
    
    NSLog(@"str = %@",str);
    [dic setObject:str forKey:@"serviceItemId"];
    [dic setObject:strItemNames forKey:@"serviceItemName"];
    [dic setObject:@"0.01" forKey:@"serviceCost"];
    [dic setObject: @"0.01" forKey:@"amount"];
    
    [dic setObject:@"0.01" forKey:@"pay"];
    [dic setObject:@"2015-08-11" forKey:@"serviceDate"];
    
    [dic setObject:@"17:30-18:00" forKey:@"serviceTime"];
    [dic setObject:[NSString stringWithFormat:@"%@%@%@",self.userAddress.city,self.userAddress.area,self.userAddress.address ]forKey:@"userAddress"];
    
    NSLog(@"dic = %@",dic);
    
    
    
    [[NetworkManager shareMgr] server_saveServiceOrderWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSDictionary* dicTmep = [response objectForKey:@"data"];
        NSLog(@"登陆字典：%@",dicTmep);
        
        if (dicTmep) {
            
            [[NetworkManager shareMgr] server_payNotifytWithDic:[NSDictionary dictionaryWithObjectsAndKeys:dicTmep[@"orderId"],@"id", nil] completeHandle:^(NSDictionary *dic) {
                
                [HKCommen addAlertViewWithTitel:@"当前测试模式下，已经对该订单进行了支付操作"];
                
            } ];
            
            PaymentCtrl *vc=[[PaymentCtrl alloc] initWithNibName:@"PaymentCtrl" bundle:nil];
            vc.dicPreParams = dicTmep;

            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        hud.hidden = YES;
        
    }];
    
    
//    [self performSegueWithIdentifier:@"goToConfirmPage" sender:nil];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3 && indexPath.row < self.shopDetail.serviceItemList.count) {
        
        if ([[self.arraySelectedSevice objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            
            [self.arraySelectedSevice replaceObjectAtIndex:indexPath.row withObject:@"1"];
            
            
        }else{
        
            [self.arraySelectedSevice replaceObjectAtIndex:indexPath.row withObject:@"0"];
            
        }
        
        
        [self.tableView reloadData];
        
    }


}

@end
