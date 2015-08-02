//
//  FirstViewCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/21.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "FirstViewCtrl.h"
#import "HKCommen.h"
#import "WeatherInfoCell.h"
#import "SelfGetCarIndicatorCell.h"
#import "ShopGetCarIndicatorCell.h"
#import "AdvertisementCell.h"
#import "NetworkManager.h"
#import "SelectCityCtrl.h"
#import "UserDataManager.h"


#define BANNER_COUNT 3
#define BANNER_RATIO 9/16
#define CELL_HIGHT 78
#define CELL_GapLength 12

@interface FirstViewCtrl ()<UITableViewDataSource,UITableViewDelegate,AdvertiseDelegate,SlectCityDelegate>


//广告部分数据
@property (strong,nonatomic)NSMutableArray *array_advertisement;

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UILabel* viewForCustomTitel;
@property (nonatomic, strong) IBOutlet UILabel* lblCity;

@property (nonatomic, strong) IBOutlet UIButton* btnCitySlected;
@property (nonatomic, strong) NSArray* arrayCity;

@end

@implementation FirstViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    [self customNaverBarItems];
    
    [self getModel];
    
//    [self scrollViewSetImages];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    
  
    [self.navigationController.navigationBar setBarTintColor:[HKCommen getColor:@"68beef"]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes =  [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    NSString* strTitel = @"e车夫";
    NSMutableAttributedString *strAttribute = [[NSMutableAttributedString alloc] initWithString:strTitel];
    [strAttribute addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:24.0] range:NSMakeRange(0, 1)];
    [strAttribute addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:18.0] range:NSMakeRange(1, 2)];
    
    self.viewForCustomTitel.attributedText = strAttribute;
    

    self.tableView.backgroundColor = [HKCommen getColor:@"f1f1f1"];
    self.view.backgroundColor = [HKCommen getColor:@"ededed"];
}

- (void)getModel
{
    [[NetworkManager shareMgr] server_fetchAdvertisementWithDic:nil completeHandle:^(NSDictionary *responseBanner) {
        
        
        
        self.array_advertisement = [[responseBanner objectForKey:@"data"] objectForKey:@"items"];
        
        [self.tableView reloadData];
        
        
    }];
    
    
    
}



#pragma mark - tableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return  SCREEN_WIDTH*BANNER_RATIO;
        
        
    }else  if (indexPath.section == 1) {
        
        return CELL_HIGHT + 1.5*CELL_GapLength;
        
    }else if(indexPath.section == 2){
    
        return CELL_GapLength + CELL_HIGHT;
    
    }else if (indexPath.section == 3){
    
        return CELL_HIGHT + CELL_GapLength;
    }
    
    return 0;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId_first = @"AdvertisementCell";
    static NSString* cellId1 = @"WeatherInfoCell";
    static NSString* cellId2 = @"SelfGetCarIndicatorCell";
    static NSString* cellId3 = @"ShopGetCarIndicatorCell";
    
    if (indexPath.section==0) {
        
        AdvertisementCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId_first];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId_first owner:self options:nil];
            
            cell = [topObjects objectAtIndex:1];
            
            cell.delegate = self;
            
        }
        
        [cell customUI:self.array_advertisement];
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        WeatherInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        
        }
        
        
        return cell;
        
        
    }else if (indexPath.section == 3){
    
        SelfGetCarIndicatorCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            
        }
        
        
        return cell;
    
    }else if (indexPath.section == 2){
        
        ShopGetCarIndicatorCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
    }

    
    return nil;
}


#pragma mark - TabelView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        [self performSegueWithIdentifier:@"goShopGet" sender:nil];
        
    }else if (indexPath.section == 3){
    
//        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        SelfGetCtrl *vc=[story instantiateViewControllerWithIdentifier:@"SelfGetCtrl"];
        
//        vc.city=@"广州市";
//        [self.navigationController pushViewController:vc animated:YES];
        
        [self performSegueWithIdentifier:@"goSelfGet" sender:nil];
    }

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (IBAction)goPersonalCenter:(id)sender
{
    NSLog(@"goPersonalCenter");
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
    
    UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"PersonalCenter"];
    
    [self.navigationController pushViewController:vc animated:YES];

//    UIStoryboard *mainDriverStory=[UIStoryboard storyboardWithName:@"mgDriverStoryboard" bundle:nil];
//    UIViewController *vc=[mainDriverStory instantiateViewControllerWithIdentifier:@"MainDriverCtrl"];
//    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark- 处理选择城市的逻辑部分

- (IBAction)selectCity:(id)sender
{
    SelectCityCtrl* vc = [[SelectCityCtrl alloc] initWithNibName:@"SelectCityCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];



}


#pragma mark - 定制navigationBar

- (void)customNaverBarItems
{
//    UIButton* btnPersonCenter = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [btnPersonCenter setImage:[UIImage imageNamed:@"nav_But_mine"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_But_mine"] style:UIBarButtonItemStylePlain target:self action:@selector(goPersonalCenter:)];
//
//    self.navigationItem.rightBarButtonItem = rightItem;
//    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    self.navigationController.navigationBar setTitleTextAttributes:<#(NSDictionary *)#>

}

#pragma mark - 广告点击处理

- (void)didSelectAdvertiseAtRow:(NSInteger)row
{
    if (row == 0) {
        
        [self performSegueWithIdentifier:@"goGuanggao" sender:nil];

        
    }else if(row == 1){
    
        [self performSegueWithIdentifier:@"goCoupon" sender:nil];

    }


}

#pragma mark - 点击城市处理

- (void)handleCitySelectedWithDic:(NSDictionary *)dic
{
    NSLog(@"cityDic = %@",dic);
    [UserDataManager shareManager].city = dic[@"name"];
    self.lblCity.text = dic[@"name"];
}



@end
