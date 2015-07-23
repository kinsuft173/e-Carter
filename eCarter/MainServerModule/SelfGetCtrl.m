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




@interface SelfGetCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* arrayModels;
@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation SelfGetCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen addHeadTitle:@"到店服务" whichNavigation:self.navigationItem];
    
//    NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
//    [dict1 setObject:@"广州天河区赏下汽车美容中心" forKey:@"address"];
//    [dict1 setObject:@"4.2" forKey:@"evaluation"];
//    [dict1 setObject:@"0.23km" forKey:@"distance"];
//    
//    NSMutableDictionary *dict2=[[NSMutableDictionary alloc] init];
//    [dict2 setObject:@"广州天河区赏下汽车修理中心" forKey:@"address"];
//    [dict2 setObject:@"2.3" forKey:@"evaluation"];
//    [dict2 setObject:@"5.23km" forKey:@"distance"];
//    
//    
//    self.arrayModels = [[NSMutableArray alloc] initWithObjects:dict1,dict2, nil];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [rightButton setFrame:CGRectMake(0, 0, 50, 100)];
    [rightButton setTitle:self.city forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doNothing) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=item;
    
    
    [self addRefresh];
    
}

-(void)doNothing
{}

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
    return self.arrayModels.count;
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
        
        cell.lbl_Adress.text=[[self.arrayModels objectAtIndex:indexPath.row] objectForKey:@"address"];
        
        cell.lbl_Distance.text=[[self.arrayModels objectAtIndex:indexPath.row] objectForKey:@"distance"];
        
        cell.lbl_Evaluation.text=[NSString stringWithFormat:@"(%@)",[[self.arrayModels objectAtIndex:indexPath.row] objectForKey:@"evaluation"]];
        
        [cell initWithDict:[[[self.arrayModels objectAtIndex:indexPath.row] objectForKey:@"evaluation"] floatValue]];
        
        return cell;
        
    }
    
    return nil;
}

#pragma mark - TabelView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"goShopDetails" sender:nil];
    
}


#pragma mark - Refresh

- (void)addRefresh
{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self.arrayModels = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 20; i++) {
            
            NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
            [dict1 setObject:@"广州天河区赏下汽车美容中心" forKey:@"address"];
            [dict1 setObject:@"4.2" forKey:@"evaluation"];
            [dict1 setObject:[NSString stringWithFormat:@"0.0%dkm",i] forKey:@"distance"];
            
            [self.arrayModels addObject:dict1];
            
        }
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        
        for (int i = 0; i < 20; i++) {
            
            NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
            [dict1 setObject:@"广州天河区赏下汽车美容中心" forKey:@"address"];
            [dict1 setObject:@"4.2" forKey:@"evaluation"];
            [dict1 setObject:[NSString stringWithFormat:@"0.0%dkm",i] forKey:@"distance"];
            
            [self.arrayModels addObject:dict1];
            
        }
        
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
        
    }];
    
    // 设置刷新图片
//    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 设置尾部
    self.tableView.footer = footer;
    
    [self.tableView.header beginRefreshing];
    
}


@end
