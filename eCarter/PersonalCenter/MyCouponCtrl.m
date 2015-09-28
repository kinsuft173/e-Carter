//
//  MyCouponCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/29.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyCouponCtrl.h"
#import "CouponMainInfoCell.h"
#import "CouponExtraInfoCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "UserDataManager.h"
#import "UserLoginInfo.h"
#import "Coupon.h"
#import "PlaceHolderCell.h"


@interface MyCouponCtrl ()<UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray* arrayOfCoupon;
@property (nonatomic, strong) NSMutableArray* arrayIndex;
@property (nonatomic,strong) UserLoginInfo *userInfo;


@end

@implementation MyCouponCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen addHeadTitle:@"我的优惠劵" whichNavigation:self.navigationItem];
    self.dictOfCard=[[NSMutableDictionary alloc]init];
    self.arrayOfCard=[[NSMutableArray alloc]init];
    
    
    [self getModel];
    
    if (self.isCardSelected) {
        [self editModel];
    }
    
    self.arrayIndex = [NSMutableArray arrayWithObjects:@0,@0, nil];
    
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

-(void)editModel
{
//    [self.tableView setEditing:YES animated:YES];
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

-(void)back
{
    if (self.isCardSelected) {
        
        //self.arrayOfCard= [[NSMutableArray alloc] initWithArray:[self.tableView indexPathsForSelectedRows]];
        
        if (self.indexCheck != -1) {
            
            
            
            [self.delegate saveMoney:[self.arrayOfCoupon objectAtIndex:self.indexCheck] withIndex:self.indexCheck];
            
        }else{
        
             [self.delegate saveMoney:nil withIndex:self.indexCheck];
        
        }
    
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)getModel
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    
   self.userInfo= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.userInfo.user.phone forKey:@"phone"];
    [dic setObject:self.userInfo.sessionId forKey:@"sessionId"];
    
    if (self.isCardSelected == YES) {
        
        [dic setObject:self.shopDetail.id forKey:@"storeId"];
        
         NSLog(@"开始查询用户的优惠券");
        
        [[NetworkManager shareMgr] server_fetchQueryUserCouponList:dic completeHandle:^(NSDictionary *responseBanner) {
            
            NSLog(@"字典：%@",responseBanner);
            
            NSArray* arrayTemp = [responseBanner objectForKey:@"data"];
            
            self.arrayOfCoupon = [[NSMutableArray alloc] init];
//            [self.arrayOfCoupon addObjectsFromArray:arrayTemp];
            for (int i = 0; i < arrayTemp.count; i ++) {
                
                CouponMyAll *coupon=[CouponMyAll objectWithKeyValues:[arrayTemp objectAtIndex:i]];
                
                if (([coupon.state rangeOfString:@"未使用"].length > 0 )) {
                    
                     //有效期设定
                    //定义fmt
                    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
                    
                    //设置格式:去除时分秒
                    fmt.dateFormat=@"yyyy-MM-dd";
                    
                    //得到字符串格式的时间
                    //NSString *dateString= //[fmt stringFromDate:self];
                    
                    //再转为date
                    NSDate *dateStart=[fmt dateFromString:coupon.startTimeString];
                     NSDate *dateEnd=[fmt dateFromString:coupon.endTimeString];
                    
                    if ([[NSDate date] timeIntervalSinceDate:dateStart] > 0 && [[NSDate date] timeIntervalSinceDate:dateEnd] < 0) {
                        
                        [self.arrayOfCoupon addObject:[arrayTemp objectAtIndex:i]];
                        
                    }
              
                    
//                    [self.arrayOfCoupon addObject:[arrayTemp objectAtIndex:i]];
                    
                }
                
            }
            
            if (self.arrayOfCoupon.count!=0) {
                
                for (int i=0; i<self.arrayOfCoupon.count; i++) {
                    [self.arrayIndex addObject:@0];
                }
            }
            
            [self.tableView reloadData];
            
            hud.hidden = YES;
        }];
        
        
        
    }else{
    
    NSLog(@"优惠劵字典:%@",dic);
    
    [[NetworkManager shareMgr] server_fetchQueryUserCouponNotList:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"字典：%@",responseBanner);
        self.arrayOfCoupon = [responseBanner objectForKey:@"data"];
        
        if (self.arrayOfCoupon.count!=0) {
            
            for (int i=0; i<self.arrayOfCoupon.count; i++) {
                [self.arrayIndex addObject:@0];
            }
        }
        
        [self.tableView reloadData];
        
        hud.hidden = YES;
    }];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.arrayOfCoupon.count==0) {
        return 1;
    }
    
    return self.arrayOfCoupon.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.arrayOfCoupon.count == 0) {
        
        return 1;
        
    }
    
    
    if (self.isCardSelected) {
        return 1;
    }
    else
    {
        NSNumber* isExpand = [self.arrayIndex objectAtIndex:section];
        
        if (isExpand.boolValue == YES) {
            
            return 2;
            
        }else{
            
            return 1;
        }
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrayOfCoupon.count == 0) {
        
        return 44;
        
    }
    
    return 107;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"CouponMainInfoCell";
    static NSString* cellId2 = @"CouponExtraInfoCell";
//        static NSString* cellHolderId = @"PlaceHolderCell";    
    static NSString* cellHolderId = @"PlaceHolderCell";
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.section == 0 && self.arrayOfCoupon.count == 0) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:1];
            
          //  cell.contentView.backgroundColor = [HKCommen  getColor:@"aaaaaa" WithAlpha:0.2];
            
        }
        
        cell.lblText.text = @"暂无优惠券可用";
        
        return cell;
        
        
    }
    
    if (indexPath.row == 0) {
        
        CouponMainInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            if (self.isCardSelected == YES) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:2];
                
                [cell.btnCheck addTarget:self action:@selector(selectCheck:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                
                cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:1];
            
            }
        
            [cell.btnExpand addTarget:self action:@selector(expandEventHandle:) forControlEvents:UIControlEventTouchUpInside];

            
        }
        
        cell.btnExpand.tag = indexPath.section;
        
        if (self.isCardSelected == YES) {
            
            cell.btnExpand.hidden = YES;
            
        }
        
        CouponMyAll*coupon =[CouponMyAll objectWithKeyValues:[self.arrayOfCoupon objectAtIndex:indexPath.section]];
        
        NSLog(@"测试字典:%@",[self.arrayOfCoupon objectAtIndex:indexPath.row]);
        cell.lbl_shop.text=coupon.title;
        cell.lbl_value.text= [NSString stringWithFormat:@"%d",coupon.price];

        
       NSString *startMonth= [coupon.startTimeString substringWithRange:NSMakeRange(5, 2)];
        NSString *startDay= [coupon.startTimeString substringWithRange:NSMakeRange(8, 2)];
        
        NSString *endMonth= [coupon.endTimeString substringWithRange:NSMakeRange(5, 2)];
        NSString *endDay= [coupon.endTimeString substringWithRange:NSMakeRange(8, 2)];
        
        cell.lbl_endTime.text=[NSString stringWithFormat:@"期限%@.%@-%@.%@",startMonth,startDay,endMonth,endDay];
 
        cell.lbl_ticketNo.text=[NSString stringWithFormat:@"编号：%@",coupon.code];
        
        if (self.isCardSelected) {
            
            
            cell.btnCheck.tag = indexPath.section;
            
            cell.lbl_shop.text = self.shopDetail.storeName;
            
            if(indexPath.section == self.indexCheck){
            
                [cell.btnCheck setImage:[UIImage imageNamed:@"but_checked"] forState:UIControlStateNormal];
            
            }else{
            
                [cell.btnCheck setImage:[UIImage imageNamed:@"but_Unchecked"] forState:UIControlStateNormal];
            
            }
            
        }
        else
        {
           cell.selectionStyle=UITableViewCellAccessoryNone;
        }
        
        return cell;
        
        
    }else if (indexPath.row == 1){
        
        CouponExtraInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
        }
        
        CouponMyAll *coupon=[CouponMyAll objectWithKeyValues:[self.arrayOfCoupon objectAtIndex:indexPath.section]];
        
        cell.lbl_couponDetail.text=coupon.remark;
        
        
        cell.lbl_userDate.text=[NSString stringWithFormat:@"使用期限：%@ 至 %@",coupon.startTimeString,coupon.endTimeString];
        
        return cell;
        
    }
    
    
    return nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return UITableViewCellEditingStyleDelete;
    return UITableViewCellEditingStyleInsert;
}

- (void)expandEventHandle:(UIButton*)btn
{
    NSInteger index = btn.tag;
    
    NSNumber* isExpand = [self.arrayIndex objectAtIndex:index];
    
    isExpand = [NSNumber numberWithBool:!(isExpand.boolValue)];
    
    [self.arrayIndex replaceObjectAtIndex:index withObject:isExpand];
    
    
    [self.tableView beginUpdates];
    
    if (isExpand.boolValue == YES) {
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:index];
        
        NSArray* array = [NSArray arrayWithObjects:indexPath, nil];
        
        [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //        [btn setTitle:@"收起" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Coupons_buts_top.png"] forState:UIControlStateNormal];
        
    }else{
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:index];
        
        NSArray* array = [NSArray arrayWithObjects:indexPath, nil];
        
        [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //        [btn setTitle:@"展开" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Coupons_but_more.png"] forState:UIControlStateNormal];
    }
    

    
    [self. tableView endUpdates];
    
}

- (void)selectCheck:(UIButton*)sender
{
    if (sender.tag == self.indexCheck) {
        
        self.indexCheck = -1;
        
        [self.tableView reloadData];
        
    }else{
    
        self.indexCheck = sender.tag;
        
        [self.tableView reloadData];
    
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.arrayOfCoupon.count == 0) {
        
        
        return;
        
    }
    
    if (!self.isCardSelected) {
        
        return;
        
    }
    
//    if (self.arrayOfCoupon) {
  //      CouponMyAll *coupon=[CouponMyAll objectWithKeyValues:[self.arrayOfCoupon objectAtIndex:indexPath.section]];
        
//        cell.lbl_couponDetail.text=coupon.remark;
//    }
//    if (!([coupon.state rangeOfString:@"未使用"].length > 0 )) {
//        
//        [HKCommen addAlertViewWithTitel:@"该优惠券无法使用"];
//        
//        return;
//        
//    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:coupon.state message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    return;

    
    if (indexPath.section == self.indexCheck) {
        
        self.indexCheck = -1;
        
        [self.tableView reloadData];
        
    }else{
        
        self.indexCheck = indexPath.section;
        
        [self.tableView reloadData];
        
        [self back];
        
    }
}

@end
