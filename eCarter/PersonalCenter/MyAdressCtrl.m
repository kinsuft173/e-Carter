//
//  MyAdressCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyAdressCtrl.h"
#import "AdressCell.h"
#import "AddAdressCell.h"
#import "HKCommen.h"
#import "FirstViewCtrl.h"
#import "UserDataManager.h"
#import "UserLoginInfo.h"
#import "NetworkManager.h"
#import "UserAddress.h"
#import "MBProgressHUD.h"

@interface MyAdressCtrl ()<UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* arrayModel;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic,strong) UserLoginInfo *userInfo;
@property (nonatomic,strong) NSMutableArray *arrayOfAdress;


@end

@implementation MyAdressCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSDictionary* dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"广州市天河区黄村高德汇11号",@"家庭地址",nil];
//    NSDictionary* dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"广州市天河区黄村高德汇11号",@"家庭地址",nil];
//    NSDictionary* dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"广州市天河区黄村高德汇11号",@"家庭地址",nil];
     self.arrayModel =  [[NSMutableArray alloc] init];
    [self getModel];
    
    //[NSMutableArray arrayWithObjects:dic1,dic2,dic3, nil];
    
    [HKCommen setExtraCellLineHidden:self.tableView];
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    
    //设置编辑模式
    //self.tableView.editing = YES;
    
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
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"changeCarOrAddress" object:nil];
}

- (void)getModel
{
    self.userInfo=[UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.userInfo.user.phone forKey:@"phone"];
    [dic setObject:self.userInfo.sessionId forKey:@"sessionId"];
    
    NSLog(@"地址字典：%@",dic);
    
    [[NetworkManager shareMgr] server_queryUserAddressWithDic:dic completeHandle:^(NSDictionary *response) {
        
        NSLog(@"字典：%@",response);
        
        if ([[[response objectForKey:@"data"] class] isSubclassOfClass:[NSArray class]]) {
            
            self.arrayOfAdress = [NSMutableArray arrayWithArray:[response objectForKey:@"data"]] ;
            
        }else{
            
            self.arrayOfAdress = nil;
        
        }
        

        
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.arrayOfAdress.count;
        
    }else{
        
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 44;
        
    }else{
        
        return 68;
        
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"AdressCell";
    static NSString* cellId2 = @"AddAdressCell";
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if(indexPath.section == 0){
        
        AdressCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        UserAddress *userAddress =  [UserAddress objectWithKeyValues:[self.arrayOfAdress objectAtIndex:indexPath.row]];//[self.arrayOfAdress objectAtIndex:indexPath.row];
        
        
        NSString* strType;
        
        if ([userAddress.type integerValue] == 1) {
            
            strType = @"家庭地址:";
            
        }else if ([userAddress.type integerValue] == 2){
            
            strType = @"工作地址:";
            
        }else{
            
            strType = @"其他地址:";
        }
        
        cell.lblAdressTitel.text= strType;//userAddress.type;
        cell.lblAdressContent.text= [NSString stringWithFormat:@"%@%@%@",userAddress.city,userAddress.area,userAddress.address];
        
        
        if ([userAddress.province containsString:@"天津"] || [userAddress.province containsString:@"北京"] ||[userAddress.province containsString:@"上海"] || [userAddress.province containsString:@"重庆"]) {
            
            
            cell.lblAdressContent.text= [NSString stringWithFormat:@"%@%@%@",userAddress.province,userAddress.city,userAddress.address];
            
        }
        
        return cell;
        
        
    }else{
        
        AddAdressCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            cell.delegate=self;
            
        }
        
      //  cell.showingDeleteConfirmation = NO；
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        UserAddress *userAddress =  [UserAddress objectWithKeyValues:[self.arrayOfAdress objectAtIndex:indexPath.row]];//[self.arrayOfAdress objectAtIndex:indexPath.row];
        
        AddNewAdress *vc=[[AddNewAdress alloc] initWithNibName:@"AddNewAdress" bundle:nil];
        vc.preUserAdress = userAddress;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }


}

-(void)EditMyAdress
{
    AddNewAdress *vc=[[AddNewAdress alloc] initWithNibName:@"AddNewAdress" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"hehe");
    
    if (indexPath.section == 1) {
        
        return;
        
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[_objects removeObjectAtIndex:indexPath.row];

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[[self.arrayOfAdress objectAtIndex:indexPath.row] objectForKey:@"id"] forKey:@"id"];
//        [dic setValue:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
//        [dic setValue:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
        
        [[NetworkManager shareMgr] server_cancelAddressWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            
            if ([[response objectForKey:@"message"] isEqualToString:@"OK"]) {
                [HKCommen addAlertViewWithTitel:@"删除地址成功"];
                
                [self.arrayOfAdress removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
//              [self getModel];
                hud.hidden = YES;
            }
            else
            {
                [HKCommen addAlertViewWithTitel:@"删除地址失败"];
                
                hud.hidden = YES;
            }
        }];
        
        
    } else {
        NSLog(@"Unhandled editing style! %d", editingStyle);
    }
}


@end
