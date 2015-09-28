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
#import "PlaceHolderCell.h"

@interface CouponCtrl()

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* arrayOfCheap;
@property (nonatomic, strong) NSMutableArray* arrayIndex;
@property (nonatomic,strong) UserLoginInfo *userInfo;

@property NSInteger pageNum;

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
    
    self.pageNum = 1;
    [dic setObject:[NSString stringWithFormat:@"%d",self.pageNum] forKey:@"pageNum"];
    [dic setObject:@"20" forKey:@"pageSize"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    
//    ,@"phone", [UserDataManager shareManager].userLoginInfo.sessionId,@"sessionId"
    NSLog(@"上传字典：%@",dic);
    
    [[NetworkManager shareMgr] server_fetchAllCheapTickets:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"获得的字典：%@",responseBanner);
     
        
        NSArray* arrayResult  = [responseBanner objectForKey:@"data"];
        self.arrayOfCheap = [[NSMutableArray alloc] init];
        
        if (arrayResult.count != 0) {
            
            [self.arrayOfCheap addObjectsFromArray:arrayResult];
        }


        
       NSLog(@"当前本地数据为%@",[ConsulationManager shareMgr].setModel);
        

        
        if (self.arrayOfCheap.count!=0) {
            
            for (int i=0; i<self.arrayOfCheap.count; i++) {
                [self.arrayIndex addObject:@0];
            }
        }
        
           NSLog(@"当前本地数据为%@",self.arrayOfCheap);
        
        [self.tableView reloadData];
        
        
        if (self.arrayOfCheap.count == 20) {
            
            [self addFootRe];
            
        }
        
    }];
    
}

- (void)addFootRe
{

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.arrayOfCheap.count%20 != 0) {
            [self.tableView.footer endRefreshing];
            return ;
        }
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        self.pageNum++;
        [dic setObject:[NSString stringWithFormat:@"%d",self.pageNum] forKey:@"pageNum"];
        [dic setObject:@"20" forKey:@"pageSize"];
        [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
        [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
        
        
        [[NetworkManager shareMgr] server_fetchAllCheapTickets:dic completeHandle:^(NSDictionary *response) {
            
            if ([[response objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                
                if ([[response objectForKey:@"data"] count] != 0) {
                    
                    if (self.arrayOfCheap.count == 0) {
                        
                        
                        
                    }else{
                        [self.arrayOfCheap  addObjectsFromArray:[response objectForKey:@"data"]];
                        
                    }
                }
                
                self.arrayIndex=[[NSMutableArray alloc] init];
                
                if (self.arrayOfCheap.count!=0) {
                    
                    for (int i=0; i<self.arrayOfCheap.count; i++) {
                        [self.arrayIndex addObject:@0];
                    }
                }
                
                
                
            }
            
            
            [self.tableView.footer endRefreshing];
            
            [self.tableView reloadData];
            
        }];
        
    }];
    

}


#pragma tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.arrayOfCheap.count  == 0) {
        
        return 1;
        
    }
    
    return self.arrayOfCheap.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.arrayOfCheap.count  == 0) {
        
        return 1;
        
    }
  
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
    static NSString* cellHolderId = @"PlaceHolderCell";
    
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.section == 0 && self.arrayOfCheap.count == 0) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:1];
            
            //  cell.contentView.backgroundColor = [HKCommen  getColor:@"aaaaaa" WithAlpha:0.2];
            
        }
        
        cell.lblText.text = @"暂无可领取的优惠券";
        
        return cell;
        
        
    }
    if (indexPath.row == 0) {
        
        CouponMainInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
            [cell.btnExpand addTarget:self action:@selector(expandEventHandle:) forControlEvents:UIControlEventTouchUpInside];
         
            
        }
        
        cell.tag = indexPath.section;
        
        
        cell.btnExpand.tag = indexPath.section;
        
       NSDictionary *dic= [self.arrayOfCheap objectAtIndex:indexPath.section];

        cell.lbl_company.text=[dic objectForKey:@"storeName"];
        cell.lbl_price.text=[dic objectForKey:@"price"];
        
        
       cell.couponId= [dic objectForKey:@"couponcode"];
        cell.storeId=[dic objectForKey:@"id"];
        cell.heheId = [dic objectForKey:@"storeName"];;
        
        cell.delegate=self;
        
        return cell;
        
        
    }else if (indexPath.row == 1){
        
        CouponExtraInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            
        }
        
        NSDictionary *dic= [self.arrayOfCheap objectAtIndex:indexPath.section];

        cell.lbl_couponDetail.text=[dic objectForKey:@"remark"];
        
        
        NSString* startTime = dic[@"startTime"];
        NSString* endTime = dic[@"endTime"];
        
        if (startTime.length == 10) {
            
            startTime  = [startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
            
        }
        
        if (endTime.length == 10) {
            
            endTime  = [endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
            
        }
        
        cell.lbl_userDate.text  = [NSString stringWithFormat:@"使用期限 ：%@-%@",startTime,endTime];
        
        return cell;
        
    }
    
    
    return nil;
}

-(void)getTicket:(NSString *)couponCode StoreNum:(NSString*)storeId id:(NSString *)heheID  btnTag:(NSInteger)tag
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
            

            [self getModel];

            
//            [self.arrayIndex removeObjectAtIndex:tag];
//            [self.arrayOfCheap removeObjectAtIndex:tag];
//            
//            
//            [self.tableView beginUpdates];
//            
//            
//            NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:tag];
//            
//            [self.tableView deleteSections:indexSet  withRowAnimation:UITableViewRowAnimationAutomatic];
//
//            [self.tableView endUpdates];
//
//            
//            [[ConsulationManager shareMgr] addHandledConsulation:heheID];
            
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
