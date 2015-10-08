//
//  ShopGetCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ShopGetCtrl.h"
#import "ShopCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "Shop.h"
#import "NetworkManager.h"
#import "Shop.h"
#import "ShopDetailCtrl.h"
#import "HKMapManager.h"
#import "HKMapCtrl.h"
#import "HKCommen.h"

#import "SelectCityCtrl.h"
#import "UserDataManager.h"

#import "PlaceHolderCell.h"

@interface ShopGetCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* arrayModel;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* itemAddress;

@end

@implementation ShopGetCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.arrayModels = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
    
    [[HKMapManager shareMgr] recover];
    
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
    
    self.itemAddress.title = [UserDataManager shareManager].city;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHeadRefresh) name:@"mapRefresh" object:nil];
    
    
    
    //    [self scrollViewSetImages];
    
}

- (void)heihei
{
    self.itemAddress.title = [UserDataManager shareManager].city;

}



- (void)goHeadRefresh
{
    
    [self.tableView.header beginRefreshing];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber*)sender {

    ShopDetailCtrl* dlg = segue.destinationViewController;
    
    dlg.preDataShopId = sender;
    
}


#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.arrayModel.count==0) {
        return 1;
    }

    return self.arrayModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrayModel.count==0) {
        return 44;
    }
    return 127;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"ShopCell";
    
    static NSString* cellHolderId = @"PlaceHolderCell";
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.section == 0 && self.arrayModel.count == 0) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:1];
            
            cell.contentView.backgroundColor = self.tableView.backgroundColor;// [HKCommen  getColor:@"aaaaaa" WithAlpha:0.2];
            
        }
        
        cell.lblText.text = @"附近暂无任何商家";
        
        return cell;
        
    }
    
    if (indexPath.section == 0) {
        
        ShopCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        Shop* shop = [Shop objectWithKeyValues:[self.arrayModel  objectAtIndex:indexPath.row]];
        
        cell.lbl_Adress.text =  shop.storeName;
        
        cell.lbl_Distance.text=  [NSString stringWithFormat:@"%.1fkm",[shop.distance floatValue]];
        
        cell.lbl_Evaluation.text = [NSString stringWithFormat:@"(%.1f)",[shop.storeScore floatValue]];
        
        [cell.star setStarForValue:[shop.storeScore floatValue]];
        
        
        
        [cell.img_Service sd_setImageWithURL: [NSURL URLWithString:shop.storeImg]
                            placeholderImage:[UIImage imageNamed:PlaceHolderImage] options:SDWebImageContinueInBackground];
        
        return cell;
    
        
    }
    
    return nil;
}

#pragma mark - TabelView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrayModel.count==0) {
        return ;
    }
    
    Shop* shop = [Shop objectWithKeyValues:[self.arrayModel  objectAtIndex:indexPath.row]];
    
    if ([shop.distance floatValue] > [shop.serviceScope floatValue]) {
        
        [HKCommen addAlertViewWithTitel:@"不在商家的服务范围,请选择其他商家"];
        
        return;
        
    }
    
    [self performSegueWithIdentifier:@"goShopDetails" sender:[NSNumber numberWithInteger:[shop.id integerValue]]];
    
}

#pragma mark - Refresh

- (void)addRefresh
{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
//        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"page", nil];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"style", nil];
        
//        [dic setObject:@"113.3380580000" forKey:@"dimensions_x"];
//        [dic setObject:@"23.3380580000" forKey:@"dimensions_y"];
        
        [[NetworkManager shareMgr] server_queryStoreListWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSArray* tempArray = [response objectForKey:@"data"];
            
            if (tempArray.count != 0) {
                
                self.arrayModel = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < tempArray.count; i ++) {
                    
                    Shop* shop = [Shop objectWithKeyValues:[tempArray objectAtIndex:i]];
                    
                    if ([shop.distance floatValue] > [shop.serviceScope floatValue]) {
                        
                        
                        
                    }else{
                        
                        [self.arrayModel addObject:[tempArray objectAtIndex:i]];
                        
                        
                    }
                    
                }
                
                //                [self.arrayModel addObjectsFromArray:tempArray];
                
            }
            
            
            [self.tableView.header endRefreshing];
            
            [self.tableView reloadData];
            
        }];
        
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//        
//        
//        for (int i = 0; i < 20; i++) {
//            
//            NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
//            [dict1 setObject:@"广州天河区赏下汽车美容中心" forKey:@"address"];
//            [dict1 setObject:@"4.2" forKey:@"evaluation"];
//            [dict1 setObject:[NSString stringWithFormat:@"0.0%dkm",i] forKey:@"distance"];
//            
//            [self.arrayModel addObject:dict1];
//            
//        }
//        
//        
//        [self.tableView reloadData];
//        
//        [self.tableView.footer endRefreshing];
//        
//    }];
//    
//    
//    // 设置尾部
//    self.tableView.footer = footer;
    
    [self.tableView.header beginRefreshing];
    
}

- (IBAction)goMap:(id)sender
{
//    [HKCommen addAlertViewWithTitel:@"更新定位信息"];
//    
//    [[HKMapManager shareMgr] locate];
//    
//    HKMapCtrl* vc  = [[HKMapCtrl alloc]  initWithNibName:@"HKMapCtrl" bundle:nil];
//    
//    vc.strType = 1;
//    
//    [self.navigationController pushViewController:vc animated:YES];

    [self selectCity:nil];
    
}

- (IBAction)selectCity:(id)sender
{
    SelectCityCtrl* vc = [[SelectCityCtrl alloc] initWithNibName:@"SelectCityCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 点击城市处理

- (void)handleCitySelectedWithDic:(NSDictionary *)dic
{
    NSLog(@"cityDic = %@",dic);
    [UserDataManager shareManager].city = dic[@"cityName"];
    // self.lblCity.text = dic[@"cityName"];
    [UserDataManager shareManager].cityId = dic[@"cityId"];
    
    self.itemAddress.title =   [UserDataManager shareManager].city;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dic] forKey:@"cityObject"];
    
    [self.tableView.header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"zhenligezha" object:nil];
}


@end
