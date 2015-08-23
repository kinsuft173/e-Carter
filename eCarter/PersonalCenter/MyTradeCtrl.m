//
//  MyTradeCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/29.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyTradeCtrl.h"
#import "CustomTradeCell.h"
#import "HKCommen.h"
#import "PlaceHolderCell.h"
#import "NetworkManager.h"
#import "UserDataManager.h"
#import "UserLoginInfo.h"

@interface MyTradeCtrl ()

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic,strong) UserLoginInfo *userInfo;
@property (nonatomic,strong)NSArray *arrayOfTrade;
@end

@implementation MyTradeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [HKCommen getColor:@"aaaaaa" WithAlpha:0.2];
    
    [self getModel];
    
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

- (void)getModel
{
    self.userInfo=[UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.userInfo.user.phone forKey:@"phone"];
    [dic setObject:self.userInfo.sessionId forKey:@"sessionId"];
    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"10" forKey:@"pageSize"];
    
    NSLog(@"交易字典：%@",dic);
    
    [[NetworkManager shareMgr] server_queryOrderLogWithDic:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"字典:%@",responseBanner);
        
        self.arrayOfTrade = [responseBanner objectForKey:@"data"];
        
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfTrade.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[self.arrayOfTrade objectAtIndex:indexPath.row];
    
    int type=[[dic objectForKey:@"type"] intValue];
    
    if(type  == 1 || type == 2 || type == 4){
        return 167;
    }
    else if (type==3)
    {
        return 97;
    }else
    {
        return 5;
    }
    
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"CustomTradeCell";
    static NSString* cellId2 = @"PlaceHolderCell";
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    
    NSLog(@"获得的字典%@",[self.arrayOfTrade objectAtIndex:indexPath.row]);
    NSDictionary *dic=[self.arrayOfTrade objectAtIndex:indexPath.row];
    
    int type=[[dic objectForKey:@"type"] intValue];
    
    if(type  == 1 || type == 2 || type == 4){
        
        CustomTradeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        cell.lbl_money.text=[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"amount"]];
        
        int paytype=[[dic objectForKey:@"paytype"] intValue];
        if (paytype==1) {
            cell.lbl_wayOfPay.text=@"支付宝";
        }
        else if (paytype==1) {
            cell.lbl_wayOfPay.text=@"微信";
        }
        else
        {
        cell.lbl_wayOfPay.text=@"余额";
        }
        
        cell.lbl_content.text=[dic objectForKey:@"items"];
        
        cell.lbl_time.text=[dic objectForKey:@"time"];
        cell.lbl_merchant.text=[dic objectForKey:@"storeName"];
        return cell;
        
    }else if(type==3){
        
        CustomTradeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:1];
            
        }
        
        cell.lbl_money.text=[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"amount"]];
        
        int paytype=[[dic objectForKey:@"paytype"] intValue];
        if (paytype==1) {
            cell.lbl_wayOfPay.text=@"支付宝";
        }
        else if (paytype==1) {
            cell.lbl_wayOfPay.text=@"微信";
        }
        else
        {
            cell.lbl_wayOfPay.text=@"余额";
        }
        
        cell.lbl_time.text=[dic objectForKey:@"time"];

        
        return cell;
        
    }else{
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            cell.contentView.backgroundColor = [HKCommen  getColor:@"aaaaaa" WithAlpha:0.2];
        }
        
        return cell;
        
    }
    
    //    return nil;
}


@end
