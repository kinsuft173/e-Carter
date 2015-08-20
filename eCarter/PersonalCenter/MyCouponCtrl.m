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

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* arrayOfCoupon;
@property (nonatomic, strong) NSMutableArray* arrayIndex;
@property (nonatomic,strong) UserLoginInfo *userInfo;

@end

@implementation MyCouponCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"测试优惠劵");
    [HKCommen addHeadTitle:@"我的优惠劵" whichNavigation:self.navigationItem];
    
    [self getModel];
    

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
   self.userInfo= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.userInfo.user.phone forKey:@"phone"];
    [dic setObject:self.userInfo.sessionId forKey:@"sessionId"];
    
    NSLog(@"优惠劵字典:%@",dic);
    
    [[NetworkManager shareMgr] server_fetchQueryUserCouponList:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"字典：%@",responseBanner);
        self.arrayOfCoupon = [responseBanner objectForKey:@"data"];
        
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
    return self.arrayOfCoupon.count;
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
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:1];
            
            [cell.btnExpand addTarget:self action:@selector(expandEventHandle:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnExpand.tag = indexPath.section;
            
        }
        Coupon *coupon=[self.arrayOfCoupon objectAtIndex:indexPath.row];
        
        return cell;
        
        
    }else if (indexPath.row == 1){
        
        CouponExtraInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            
        }
        
        
        return cell;
        
    }
    
    
    return nil;
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
