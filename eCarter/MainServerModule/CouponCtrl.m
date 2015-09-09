//
//  CouponCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "CouponCtrl.h"
#import "CouponExtraInfoCell.h"
#import "CouponMainInfoCell.h"
#import "NetworkManager.h"
#import "UserLoginInfo.h"
#import "UserDataManager.h"
#import "HKCommen.h"
#import "ConsulationManager.h"

@interface CouponCtrl()

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* arrayOfCheap;
@property (nonatomic, strong) NSMutableArray* arrayIndex;
@property (nonatomic,strong) UserLoginInfo *userInfo;

@end

@implementation CouponCtrl


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    self.arrayIndex=[[NSMutableArray alloc] init];
    
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

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getModel
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"20" forKey:@"pageSize"];
    
    NSLog(@"上传字典：%@",dic);
    
    [[NetworkManager shareMgr] server_fetchAllCheapTickets:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"获得的字典：%@",responseBanner);
     
        
        NSArray* arrayResult  = [responseBanner objectForKey:@"data"];
        self.arrayOfCheap = [[NSMutableArray alloc] init];
        

        
       NSLog(@"当前本地数据为%@",[ConsulationManager shareMgr].setModel);
        
        for (int i = 0; i < arrayResult.count; i ++) {
            
            NSDictionary* dic = [arrayResult objectAtIndex:i];
            
            NSString* str =  [dic  objectForKey:@"id"];
            
            BOOL isNewConsult = YES;
            
            for (NSString* consultId in [ConsulationManager shareMgr].setModel) {
                
                if ([[NSString stringWithFormat:@"%@",consultId] isEqualToString:[NSString stringWithFormat:@"%@",str]]) {
                    
                    
                    isNewConsult = NO;
                }
                
            }
            
            
            if (isNewConsult == YES) {
                
                [self.arrayOfCheap addObject:[arrayResult objectAtIndex:i]];
                
            }
            
        }
        
        if (self.arrayOfCheap.count!=0) {
            
            for (int i=0; i<self.arrayOfCheap.count; i++) {
                [self.arrayIndex addObject:@0];
            }
        }
        
           NSLog(@"当前本地数据为%@",self.arrayOfCheap);
        
        [self.tableView reloadData];
    }];
}


#pragma tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayOfCheap.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    NSNumber* isExpand = [self.arrayIndex objectAtIndex:section];
    
    if (isExpand.boolValue == YES) {
        
        return 2;
        
    }else{
    
        return 1;
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
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
            [cell.btnExpand addTarget:self action:@selector(expandEventHandle:) forControlEvents:UIControlEventTouchUpInside];
         
            
        }
        
           cell.btnExpand.tag = indexPath.section;
        
       NSDictionary *dic= [self.arrayOfCheap objectAtIndex:indexPath.section];

        cell.lbl_company.text=[dic objectForKey:@"storeName"];
        cell.lbl_price.text=[dic objectForKey:@"price"];
        
        
       cell.couponId= [dic objectForKey:@"couponcode"];
        cell.storeId=[dic objectForKey:@"id"];
        cell.heheId =  cell.storeId;
        
        cell.delegate=self;
        
        return cell;
        
        
    }else if (indexPath.row == 1){
        
        CouponExtraInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            
        }
        
        NSDictionary *dic= [self.arrayOfCheap objectAtIndex:indexPath.section];

        cell.lbl_couponDetail.text=[dic objectForKey:@"remark"];
        
        return cell;
        
    }
    
    
    return nil;
}

-(void)getTicket:(NSString *)couponCode StoreNum:(NSString*)storeId id:(NSString *)heheID
{
    if ([[UserDataManager shareManager].userLoginInfo.user.phone isEqualToString:@""]) {
        NSLog(@"用户没登陆");
        return;
    }
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    [dic setObject:couponCode forKey:@"couponCode"];
    [dic setObject:storeId forKey:@"storeId"];
    
    
    NSLog(@"抢优惠劵的上传：%@",dic);
    [[NetworkManager shareMgr] server_snapCoupon:dic completeHandle:^(NSDictionary *response) {
        
        NSLog(@"抢到的优惠：%@",response);
        
        if ([[response objectForKey:@"status"] integerValue]== 1) {
            
            [HKCommen addAlertViewWithTitel:@"抢优惠券失败"];
            
        }else if ([[response objectForKey:@"status"] integerValue]== 2){
        
            [HKCommen addAlertViewWithTitel:@"抢优惠券成功"];
            
            [[ConsulationManager shareMgr] addHandledConsulation:heheID];
            
        }else if ([[response objectForKey:@"status"] integerValue]== 3){
            
            [HKCommen addAlertViewWithTitel:@"不能重复领取优惠券"];
        }
        
    }];
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
        
        [btn setImage:[UIImage imageNamed:@"Coupons_but_more.png"] forState:UIControlStateNormal];
    }else{
    
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:index];
        
        NSArray* array = [NSArray arrayWithObjects:indexPath, nil];
    
        [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [btn setTitle:@"展开" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Coupons_buts_top.png"] forState:UIControlStateNormal];
    }
    
    
    [self. tableView endUpdates];
    
}


@end
