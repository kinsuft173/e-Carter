//
//  SelfGetCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SelfGetCtrl.h"
#import "ShopCell.h"
#import <MJRefresh.h>
#import "Shop.h"
#import "NetworkManager.h"
#import "SelfDetailCtrl.h"



@interface SelfGetCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* arrayModel;
@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation SelfGetCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen addHeadTitle:@"上门服务" whichNavigation:self.navigationItem];

    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [rightButton setFrame:CGRectMake(0, 0, 50, 100)];
    [rightButton setTitle:self.city forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doNothing) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=item;
    
    
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

-(void)doNothing
{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber*)sender {
    
    SelfDetailCtrl* dlg = segue.destinationViewController;
    
    dlg.preDataShopId = sender;
    
}


#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"ShopCell";
    
    if (indexPath.section == 0) {
        
        ShopCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        Shop* shop = [Shop objectWithKeyValues:[self.arrayModel  objectAtIndex:indexPath.row]];
        
        cell.lbl_Adress.text =  shop.storeName;
        
        cell.lbl_Distance.text=  [NSString stringWithFormat:@"%@km",shop.distance];
        
        cell.lbl_Evaluation.text = [NSString stringWithFormat:@"(%@)",shop.storeScore];
        
        [cell initWithDict:[shop.storeScore floatValue]];
        
        [cell.img_Service sd_setImageWithURL:[NSURL URLWithString:shop.storeImg]
                            placeholderImage:[UIImage imageNamed:PlaceHolderImage] options:SDWebImageContinueInBackground];
        
        return cell;
        
        
    }
    
    return nil;
}

#pragma mark - TabelView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Shop* shop = [Shop objectWithKeyValues:[self.arrayModel  objectAtIndex:indexPath.row]];
    
    [self performSegueWithIdentifier:@"goShopDetails" sender:[NSNumber numberWithInteger:[shop.id integerValue]]];
    
}

#pragma mark - Refresh

- (void)addRefresh
{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"style", nil];
        
        [[NetworkManager shareMgr] server_queryStoreListWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSArray* tempArray = [response objectForKey:@"data"];
            
            if (tempArray.count != 0) {
                
                self.arrayModel = [[NSMutableArray alloc] init];
                
                [self.arrayModel addObjectsFromArray:tempArray];
                
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


@end
