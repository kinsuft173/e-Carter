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


@interface MyCouponCtrl ()


@property (nonatomic, strong) NSArray* arrayOfCoupon;
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
    
    self.arrayIndex = [NSMutableArray arrayWithObjects:@1,@0, nil];
    
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
    [self.tableView setEditing:YES animated:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

-(void)back
{
    if (self.isCardSelected) {
        self.arrayOfCard=[[NSMutableArray alloc] initWithArray:[self.tableView indexPathsForSelectedRows]];
        
        if (self.arrayOfCard.count>1) {
            [HKCommen addAlertViewWithTitel:@"只能选择一个优惠劵"];
            return;
        }
        
        if (self.arrayOfCard.count>0) {
            NSIndexPath *index=[self.arrayOfCard objectAtIndex:0];
            [self.delegate saveMoney:[self.arrayOfCoupon objectAtIndex:index.section]];
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
   self.userInfo= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.userInfo.user.phone forKey:@"phone"];
    [dic setObject:self.userInfo.sessionId forKey:@"sessionId"];
    
    NSLog(@"优惠劵字典:%@",dic);
    
    [[NetworkManager shareMgr] server_fetchQueryUserCouponList:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"字典：%@",responseBanner);
        self.arrayOfCoupon = [responseBanner objectForKey:@"data"];
        
        if (self.arrayOfCoupon.count!=0) {
            
            for (int i=0; i<self.arrayOfCoupon.count; i++) {
                [self.arrayIndex addObject:@0];
            }
        }
        
        [self.tableView reloadData];
    }];
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
        return 0;
    }
    
    return self.arrayOfCoupon.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    return 107;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"CouponMainInfoCell";
    static NSString* cellId2 = @"CouponExtraInfoCell";
    
    if (indexPath.row == 0) {
        
        CouponMainInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:1];
            
            [cell.btnExpand addTarget:self action:@selector(expandEventHandle:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnExpand.tag = indexPath.section;
            
        }
        
        Coupon *coupon=[Coupon objectWithKeyValues:[self.arrayOfCoupon objectAtIndex:indexPath.section]];
        
        NSLog(@"测试字典:%@",[self.arrayOfCoupon objectAtIndex:indexPath.row]);
        //cell.lbl_shop.text=coupon.remark;
        cell.lbl_value.text=coupon.price;

        
       NSString *startMonth= [coupon.startTimeString substringWithRange:NSMakeRange(5, 2)];
        NSString *startDay= [coupon.startTimeString substringWithRange:NSMakeRange(8, 2)];
        
        NSString *endMonth= [coupon.endTimeString substringWithRange:NSMakeRange(5, 2)];
        NSString *endDay= [coupon.endTimeString substringWithRange:NSMakeRange(8, 2)];
        
        cell.lbl_endTime.text=[NSString stringWithFormat:@"期限%@.%@-%@.%@",startMonth,startDay,endMonth,endDay];
 
        cell.lbl_ticketNo.text=[NSString stringWithFormat:@"编号：%@",coupon.id];
        
        if (self.isCardSelected) {
            cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:104.0/255.0 green:190.0/255.0 blue:239.0/255.0 alpha:1.0];
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
        
        Coupon *coupon=[Coupon objectWithKeyValues:[self.arrayOfCoupon objectAtIndex:indexPath.section]];
        
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

@end
