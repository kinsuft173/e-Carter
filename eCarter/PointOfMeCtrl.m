//
//  PointOfMeCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "PointOfMeCtrl.h"
#import "UserDataManager.h"
#import "UserLoginInfo.h"
#import "NetworkManager.h"
#import "PointTransaction.h"

@interface PointOfMeCtrl ()
@property (strong,nonatomic) NSArray *arrayOfCount;
@property (strong,nonatomic) UserLoginInfo *userInfo;
@end

@implementation PointOfMeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"我的积分" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
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
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getModel
{
    self.userInfo=[UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.userInfo.user.phone forKey:@"phone"];
    [dic setObject:self.userInfo.sessionId forKey:@"sessionId"];
    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"10" forKey:@"pageSize"];
    
    NSLog(@"积分字典：%@",dic);
    
    [[NetworkManager shareMgr] server_queryPointTransactionWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSLog(@"获得的字典：%@",response);
        self.arrayOfCount = [response objectForKey:@"data"];
        
        [self.myTable reloadData];
    }];
    
    NSMutableDictionary *dicAccount=[[NSMutableDictionary alloc]init];
    [dicAccount setValue:self.userInfo.user.uid forKey:@"userId"];
    [dicAccount setValue:@"2" forKey:@"accountType"];

    [[NetworkManager shareMgr] server_queryUserAccountWithDic:dicAccount completeHandle:^(NSDictionary *response) {
        
        NSLog(@"字典：%@",response);
        self.lbl_myCount.text=[NSString stringWithFormat:@"%@",[response objectForKey:@"data"]];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfCount.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId = @"MyScoreNomalCell";
    
    
    MyScoreNomalCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil];
        
        cell = [topLevelObjects objectAtIndex:0];
    }
    PointTransaction *myPoint=[PointTransaction objectWithKeyValues:[self.arrayOfCount objectAtIndex:indexPath.row]];
    cell.lbl_thisPoint.text=myPoint.point;
    cell.lbl_totalPoint.text=myPoint.totalPoint;
    cell.lbl_time.text=myPoint.createTime;
    cell.lbl_type.text=myPoint.Description;
    
    return cell;
    
}

@end
