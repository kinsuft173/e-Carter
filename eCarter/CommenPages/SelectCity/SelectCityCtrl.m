//
//  SelectCityCtrl.m
//  GSAPP
//
//  Created by kinsuft173 on 15/7/15.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "SelectCityCtrl.h"
#import "LocalCell.h"
#import "CityCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "HKMapManager.h"

@interface SelectCityCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet NSArray* arrayModel;

@end

@implementation SelectCityCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self getModel];
    
    [HKCommen addHeadTitle:@"选择城市" whichNavigation:self.navigationItem];

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

- (void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
//    
    [HKCommen setExtraCellLineHidden:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }

}

- (void)getModel
{
    [[NetworkManager shareMgr] server_fetchCityWithDic:nil completeHandle:^(NSDictionary *response) {
        
        NSLog(@"城市数据 =  %@",response);
        
        self.arrayModel = [[NSMutableArray alloc] init];
        
        NSArray* resultArray = [response objectForKey:@"data"];
        
        if (resultArray.count != 0) {
            
            self.arrayModel = resultArray;
            
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

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else{
    
        return self.arrayModel.count;
    
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"LocalCell";
    static NSString* cellId2 = @"CityCell";
    
    if (indexPath.section == 0) {
        
        LocalCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        cell.lblCity.text = [HKMapManager shareMgr].strCity;
        
        return cell;
        
    }else{
    
        CityCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        cell.lblCity.text = [[self.arrayModel objectAtIndex:indexPath.row] objectForKey:@"cityName"];
        
        return cell;
    

    }
    

}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[NSBundle mainBundle] loadNibNamed:@"CityHeadView" owner:self options:nil][section];
    
    CGRect rect = view.frame;
    
    rect.size.width = self.view.frame.size.width;
    
    view.frame = rect;
    
    return view;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 28;
}

#pragma tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
        
    }else{
    
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self.delegate handleCitySelectedWithDic:[self.arrayModel objectAtIndex:indexPath.row]];
    
    }

}



@end
