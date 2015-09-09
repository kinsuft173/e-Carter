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
#import "MyCouponCtrl.h"
#import "SelectStoreTimeCtrl.h"
#import "Coupon.h"
#import  "CommentModel.h"

@interface SelfDetailCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) ShopDetail* shopDetail;

@property (nonatomic, strong) NSMutableArray* arraySelectedSevice;
@property (nonatomic, strong) NSMutableArray* arrayComment;

@property (nonatomic, strong) Coupon* coupon;

@property (strong,nonatomic) NSString *stringOfCount;

@property BOOL isUseDiscount;

@property (strong,nonatomic) NSString *stringOfTotal;
@property (strong,nonatomic) NSString *stringOfTimel;

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
        
        
        NSDictionary* dicComment = [NSDictionary dictionaryWithObjectsAndKeys:self.preDataShopId,@"storeId",@"1",@"pageNum",@"100",@"pageSize", nil];
    
        
        [[NetworkManager shareMgr] server_queryStoreCommemtWithDic:dicComment completeHandle:^(NSDictionary *response) {
            
            if ([[response objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                self.arrayComment = [NSMutableArray arrayWithArray:[response objectForKey:@"data"] ];
                
            }
            

            
            
            [self.tableView reloadData];
            
        }];
        
        
        
    }];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        
        NSDictionary* dicComment = [NSDictionary dictionaryWithObjectsAndKeys:self.preDataShopId,@"storeId",[NSString stringWithFormat:@"%d",(self.arrayComment.count + 1)],@"pageNum",@"100",@"pageSize", nil];
        
        
        [[NetworkManager shareMgr] server_queryStoreCommemtWithDic:dicComment completeHandle:^(NSDictionary *response) {
            
            if ([[response objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                if ([[response objectForKey:@"data"] count] != 0) {
                    if (self.arrayComment.count == 0) {
                        
                        
                        self.arrayComment = [[NSMutableArray alloc] init];
                        
                        [self.arrayComment  addObjectsFromArray:[response objectForKey:@"data"]];
                    }
                }
                
            }
            
            
            
            [self.tableView.footer endRefreshing];
            
            [self.tableView reloadData];
            
        }];
        
    }];
    
    
    
    NSMutableDictionary *dicNew=[[NSMutableDictionary alloc]init];
    
    [dicNew setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dicNew setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    
    
    [[NetworkManager shareMgr] server_queryUserPointWithDic:dicNew completeHandle:^(NSDictionary *response) {
        
        NSLog(@"字典：%@",response);
        
        self.stringOfCount= [NSString stringWithFormat:@"%@",[[response objectForKey:@"data"] objectForKey:@"point"]];
        
        
        [self.tableView  reloadData];
        
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
        
        return 5;
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
        
        return self.shopDetail.serviceItemList.count + 5;
        
    }else if (section == 4){
        
        return self.arrayComment.count + 1;
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
        
        if (indexPath.row == self.shopDetail.serviceItemList.count + 4) {
            
            return 84;
            
        }else if (indexPath.row <self.shopDetail.serviceItemList.count + 1){
            
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
            
            
        }
        
        Serviceitemlist* item = [self.shopDetail.serviceItemList objectAtIndex:indexPath.row];
        
        cell.lblServerPrice.text = [NSString stringWithFormat:@"¥%@",item.amount];
        cell.lblSeverName.text = item.serviceItemName;
        
        if ([[self.arraySelectedSevice objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            
            cell.img_Button.image = [UIImage imageNamed:@"but_Unchecked"];
            
        }else{
            
            cell.img_Button.image = [UIImage imageNamed:@"but_checked"];
            
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count) {
        
        ServerListCell* cell ;//= [tableView dequeueReusableCellWithIdentifier:cellId4];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId4 owner:self options:nil] objectAtIndex:0];
            
            if (indexPath.row == 0) {
                
                UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
                
                divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
                
                [cell.contentView addSubview:divideView];
                
            }
            
            
        }
        
        
        cell.lblServerPrice.text = [NSString stringWithFormat:@"¥%@",self.shopDetail.serviceCharge];
        cell.lblSeverName.text = @"服务费";
        

            
        cell.img_Button.image = [UIImage imageNamed:@"but_checked"];
            
  
            
       // }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count + 1) {
        
        CouponSlectedCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId5];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId5 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        if (self.coupon.price) {
            
            cell.lbl_price.text = [NSString stringWithFormat:@"%@元优惠劵",self.coupon.price];
            
        }else{
            
            cell.lbl_price.text = @"";//[NSString stringWithFormat:@"%@元优惠劵",self.coupon.price];
        
        }

        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count +2) {
        
        DiscountScoreCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId6];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId6 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
            
            [cell.switchCount addTarget:self action:@selector(selectedDiscunt:) forControlEvents:UIControlEventValueChanged];
        }

        
      //  cell.lblDiscount.text =  [UserDataManager shareManager].userLoginInfo.user.
        
        if ([self.stringOfCount integerValue] != 0) {
            
            cell.lblDiscount.text = [NSString stringWithFormat:@"可用积分%@分",self.stringOfCount];
            cell.lblRMBDiscount.text = [NSString stringWithFormat:@"%.1f",-[self.stringOfCount integerValue]/100.0];
            
        }else{
        
             cell.lblDiscount.text = [NSString stringWithFormat:@"无可用积分"];
             cell.lblRMBDiscount.text = @"";
        }
        
        
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count +3) {
        
        TotalCountCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId7];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId7 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        

        
        CGFloat money = 0;
        
        for (int i = 0 ; i < self.arraySelectedSevice.count; i ++) {
            
            if ( [[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]) {
                
                
                Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i];//[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
                
                money  += list.amount.floatValue;
                
                //strItemNames = list.serviceItemName; //[strItemNames stringByAppendingString:list.serviceItemName];
                
            }
        }
        
        if (self.coupon.price) {
            
            money -= self.coupon.price.floatValue;
            
        }
        
        if (self.isUseDiscount) {
            
            money -= self.stringOfCount.floatValue/100.0;
            
        }

        money += self.shopDetail.serviceCharge.floatValue;
        
        if (money < 0) {
            
            money = 0.01;
        }
        

        
        self.stringOfTotal = [NSString stringWithFormat:@"%.2f",money];
        
        cell.lblTotel.text = [NSString stringWithFormat:@"%@元",self.stringOfTotal];

        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == self.shopDetail.serviceItemList.count + 4) {
        
        PaymentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId8];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId8 owner:self options:nil] objectAtIndex:0];
            
            cell.separatorInset = UIEdgeInsetsZero;
            
            [cell.btnConfirm addTarget:self action:@selector(goToConfirmPage:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
        
    }else if (indexPath.section == 4 && indexPath.row != 0) {
        
        CommentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId9];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId9 owner:self options:nil] objectAtIndex:0];
            
        }
        
        CommentModel* comment = [CommentModel objectWithKeyValues:[self.arrayComment objectAtIndex:indexPath.row -1]];
        
        
        cell.lblContent.text = comment.commentContent;
        cell.lblPhone.text = comment.userPhone;
        cell.lblServerItems.text = comment.serviceItem;
        cell.lblTime.text = comment.createTime;
        [cell.star setStarForValue:comment.storeScore.floatValue];
        
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
    
//    [dic setObject:[NSNumber numberWithInteger:self.userCar.id] forKey:@"carId"];
//    [dic setObject:self.userCar.no forKey:@"carnum"];
//    
//    //获得carId
    Car* firstCar = [Car objectWithKeyValues:[self.userCar objectAtIndex:0]];
    
    NSString* carId= [NSString stringWithFormat:@"%ld",(long)firstCar.id];
    
    NSString* carnumId = [NSString stringWithFormat:@"%@",firstCar.no];
    
    for (int i = 1; i < self.userCar.count; i ++) {
        
    Car* firstCar = [Car objectWithKeyValues:[self.userCar objectAtIndex:i]];
        
        NSString* carIdTemp= [NSString stringWithFormat:@",%ld",(long)firstCar.id];
        
        NSString* carnumIdTemp = [NSString stringWithFormat:@",%@",firstCar.no];
        
        carId = [carId stringByAppendingString:carIdTemp];
        
        carnumId = [carnumId stringByAppendingString:carnumIdTemp];
        
    }
    
    [dic setObject:carId forKey:@"carId"];
    [dic setObject:carnumId forKey:@"carnum"];
    
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
    
    
    if ([self.stringOfTimel isEqualToString:@""]|| self.stringOfTimel == nil) {
        
        [HKCommen addAlertViewWithTitel:@"请选择预约时间"];
        
        
        hud.hidden = YES;
        
        return;
        
    }
    
    
    
    NSString* strItemNames = @"";
    
    for (int i = 0 ; i < self.arraySelectedSevice.count; i ++) {
        
        if (strItemNames && [[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]) {
            
            
            Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i];//[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
            
            strItemNames = list.serviceItemName; //[strItemNames stringByAppendingString:list.serviceItemName];
            
        }else if ([[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]){
            
            Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i];//[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
            
            NSString* strTemp = [NSString stringWithFormat:@",%@",list.serviceItemName];
            
            strItemNames = [strItemNames stringByAppendingString:strTemp];
            
            
        }
        
        
    }
    
    if (self.coupon && self.isUseDiscount == YES) {
        
        [HKCommen addAlertViewWithTitel:@"优惠券和积分不能同时使用"];
        
         hud.hidden = YES;
        
        return;
        
    }
    
    //获取总额
    CGFloat money = 0;
    
    for (int i = 0 ; i < self.arraySelectedSevice.count; i ++) {
        
        if ( [[self.arraySelectedSevice objectAtIndex:i] isEqualToString:@"1"]) {
            
            
            Serviceitemlist* list = [self.shopDetail.serviceItemList objectAtIndex:i];//[Serviceitemlist objectWithKeyValues:[self.shopDetail.serviceItemList objectAtIndex:i]];
            
            money  += list.amount.floatValue;
            
            //strItemNames = list.serviceItemName; //[strItemNames stringByAppendingString:list.serviceItemName];
            
        }
    }
    
    NSLog(@"str = %@",str);
    [dic setObject:str forKey:@"serviceItemId"];
    [dic setObject:strItemNames forKey:@"serviceItemName"];
    [dic setObject:self.stringOfTotal forKey:@"serviceCost"];
    [dic setObject:[NSString stringWithFormat:@"%.2f",money] forKey:@"amount"];
    
    [dic setObject:self.stringOfTotal forKey:@"pay"];
    
    
    
    NSString* strDate,*strHour;
    
    if (self.stringOfTimel.length > 10) {
        
        strDate = [self.stringOfTimel substringToIndex:10];
        
    }
    
    NSString* strTemp = [self.stringOfTimel stringByReplacingOccurrencesOfString:@"至" withString:@"-"];
    
    NSRange rang1;
    
    rang1.location = 11;
    
    rang1.length = 11;
    
    strHour = [strTemp substringWithRange:rang1];
    
    
    [dic setObject:strDate forKey:@"serviceDate"];
    
    [dic setObject:strHour forKey:@"serviceTime"];
    [dic setObject:[NSString stringWithFormat:@"%@%@%@",self.userAddress.city,self.userAddress.area,self.userAddress.address ]forKey:@"userAddress"];
    
//    if (self.isUseDiscount) {
//        
//        [dic setObject:self.stringOfCount forKey:@"point"];
//        
//    }
    
    if (self.coupon) {
        
        
        [dic setObject:self.coupon.id forKey:@"couponRecordId"];
    }
    
    NSLog(@"dic = %@",dic);
    
    
    
    
    [[NetworkManager shareMgr] server_saveServiceOrderWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSDictionary* dicTmep = [response objectForKey:@"data"];
        NSLog(@"登陆字典：%@",dicTmep);
        
        if (dicTmep) {
            
//            [[NetworkManager shareMgr] server_payNotifytWithDic:[NSDictionary dictionaryWithObjectsAndKeys:dicTmep[@"orderId"],@"id", nil] completeHandle:^(NSDictionary *dic) {
//                
//                [HKCommen addAlertViewWithTitel:@"当前测试模式下，已经对该订单进行了支付操作"];
//                
//            } ];
            
            PaymentCtrl *vc=[[PaymentCtrl alloc] initWithNibName:@"PaymentCtrl" bundle:nil];
            vc.dicPreParams = dicTmep;
            vc.strTotalMount = self.stringOfTotal;
            vc.strSeviceItem = strItemNames;
            vc.strShopName = self.shopDetail.storeName;

            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        hud.hidden = YES;
        
    }];
    
    
//    [self performSegueWithIdentifier:@"goToConfirmPage" sender:nil];

}

- (void)selectedDiscunt:(UISwitch*)switchDiscount
{
    if (switchDiscount.isOn == YES) {
        
        self.isUseDiscount = YES;
        
    }else{
    
        self.isUseDiscount = NO;
    
    }

    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.shopDetail.serviceItemList.count +3 inSection:3]] withRowAnimation:UITableViewRowAnimationAutomatic];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        
        
        SelectStoreTimeCtrl *vc=[[SelectStoreTimeCtrl alloc]initWithNibName:@"SelectStoreTimeCtrl" bundle:nil];
        vc.delegate=self;
        vc.shopDetail = self.shopDetail;
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    if (indexPath.section == 3 && indexPath.row < self.shopDetail.serviceItemList.count) {
        
        
        if ([[self.arraySelectedSevice objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            
            [self.arraySelectedSevice replaceObjectAtIndex:indexPath.row withObject:@"1"];
            
            
        }else{
        
            [self.arraySelectedSevice replaceObjectAtIndex:indexPath.row withObject:@"0"];
            
        }
        
        
        [self.tableView reloadData];
        
    }
    else  if (indexPath.section == 3 && indexPath.row  == self.shopDetail.serviceItemList.count + 1 )
    {
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
        MyCouponCtrl *vc=[story instantiateViewControllerWithIdentifier:@"MyCouponCtrl"];
        vc.delegate=self;
       
        vc.shopDetail = self.shopDetail;
        vc.isCardSelected=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)saveMoney:(NSMutableDictionary*)dic
{
    NSLog(@"获得的优惠劵字典：%@",dic);
  //  CouponSlectedCell* cell = (CouponSlectedCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.shopDetail.serviceItemList.count inSection:3]];
    
    self.coupon = [Coupon objectWithKeyValues:[NSDictionary dictionaryWithDictionary:dic]];
    
    //if ([[cell class] isSubclassOfClass:[CouponSlectedCell class]]) {
    
//        cell.lbl_price.text=[NSString stringWithFormat:@"%@元优惠劵",[dic objectForKey:@"price"]];

        
    //}
    
    [self.tableView reloadData];
    
}


-(void)pickTime:(NSString*)string
{
    TimeCell *cell=(TimeCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    cell.lbl_Time.text=string;
    
    self.stringOfTimel = string;
}

@end
