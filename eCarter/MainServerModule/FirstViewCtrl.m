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
#import "SetTransactionPassworsCtrl.h"
#import "TransactionCtrl.h"
#import "EventBanerCtrl.h"
#import "PersonalCenterCtrl.h"



#define BANNER_COUNT 3
#define BANNER_RATIO 9/16
#define CELL_HIGHT 78
#define CELL_GapLength 12

@interface FirstViewCtrl ()<UITableViewDataSource,UITableViewDelegate,AdvertiseDelegate,SlectCityDelegate>


//广告部分数据
@property (strong,nonatomic)NSMutableArray *array_advertisement;

//天气数据
@property (strong,nonatomic)NSDictionary *dic_weather;

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UILabel* viewForCustomTitel;
@property (nonatomic, strong) IBOutlet UILabel* lblCity;

@property (nonatomic, strong) IBOutlet UIButton* btnCitySlected;
@property (nonatomic, strong) NSArray* arrayCity;

@property (nonatomic,strong)NSMutableArray *arrayOfWeather;
@property (nonatomic,strong)NSMutableArray *arrayOfWeatherData;
@end

@implementation FirstViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    [self customNaverBarItems];
    
    NSDictionary* dicCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityObject"];
    
    NSLog(@"dicCity = %@",dicCity);
    
    if (dicCity) {
    
        [UserDataManager shareManager].city = dicCity[@"cityName"];
        [UserDataManager shareManager].cityId = dicCity[@"cityId"];
        
        
    }else{
    
        [UserDataManager shareManager].city = @"广州";//dicCity[@"cityName"];
        [UserDataManager shareManager].cityId = @"101280101";//dicCity[@"cityId"];
    
    }
    
    self.lblCity.text = [UserDataManager shareManager ].city;
    
    [self getModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goPersonalCenter:) name:@"goLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goPersonalCenteWithNotify) name:@"goMyOrder" object:nil];
    
    
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
    
    self.arrayOfWeather=[[NSMutableArray alloc]initWithObjects:@"sunny",@"cloudy",@"cloudy",@"light-rain",@"thunder-rain",@"hail",@"sleet",@"light-rain",@"moderate-rain",@"heavy-rain",@"overcast",@"overcast",@"overcast",@"light-snow",@"snow",@"snow",@"snow",@"snowstorm",@"foggy",@"ice-rain",@"sandstorm",@"moderate",@"moderate",@"heavy-rain",@"overcast",@"overcast",@"snow",@"snow",@"snowstorm",@"sand",@"sand",@"tornado",@"foggy", nil];
    
    self.arrayOfWeatherData=[[NSMutableArray alloc]initWithObjects:@"晴",@"多云",@"阴",@"阵雨",@"雷阵雨",@"雷阵雨伴有冰雹",@"雨夹雪",@"小雨",@"中雨",@"大雨",@"暴雨",@"大暴雨",@"特大暴雨",@"阵雪",@"小雪",@"中雪",@"大雪",@"暴雪",@"雾",@"冻雨",@"沙尘暴",@"小雨-中雨",@"中雨-大雨",@"大雨-暴雨",@"暴雨-大暴雨",@"大暴雨-特大暴雨",@"小雪-中雪",@"中雪-大雪",@"大雪-暴雪",@"浮尘",@"扬沙",@"强沙尘暴",@"霾", nil];
}

- (void)getModel
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"2" forKey:@"position"];
    [dic setObject:[UserDataManager shareManager].cityId forKey:@"cityId"];
    
    NSLog(@"上传字典：%@",dic);
    
    [[NetworkManager shareMgr] server_infoWithDic:dic completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"获得的字典：%@",responseBanner);
        self.array_advertisement = [responseBanner objectForKey:@"data"];
        
        [self.tableView reloadData];
        
    }];
    
    NSMutableDictionary *dicWeather=[[NSMutableDictionary alloc]init];
    [dicWeather setObject:@"4e0670a39b0b460eaaf7ea415d87e5e6" forKey:@"key"];
    [dicWeather setObject:[UserDataManager shareManager].city forKey:@"cityname"];
    
    [[NetworkManager shareMgr] server_fetchWeatherWithDic:dicWeather completeHandle:^(NSDictionary *responseBanner) {
        
        NSLog(@"天气数据：%@",responseBanner);
    
        if (![[[responseBanner objectForKey:@"result"] class] isSubclassOfClass:[NSNull class]]) {

            self.dic_weather = [[responseBanner objectForKey:@"result"] objectForKey:@"today"] ;
            
        }
        

        
        [self.tableView reloadData];
        
    }];
    
//    [NetworkManager shareMgr] server_fetW
    
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
    
        return CELL_HIGHT + CELL_GapLength;
        
    
    }else if (indexPath.section == 3){
    
        return CELL_GapLength + CELL_HIGHT;
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
        
        NSLog(@"广告入口:%@",self.array_advertisement);
        [cell customUI:self.array_advertisement];
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        WeatherInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        
        }
        
        NSString *weather=self.dic_weather[@"weather"];
        
        
        cell.lbl_weather.text = weather;
        cell.lbl_temperature.text = [NSString stringWithFormat:@"%@℃",self.dic_weather[@"temperature"]];
        
        
        int index=100;
        
        for (int i=0; i<self.arrayOfWeatherData.count; i++) {
            if ([weather isEqualToString:[self.arrayOfWeatherData objectAtIndex:i]]) {
                index=i;
            }
        }
        
        if (index!=100) {
            [cell.imgWeather setImage:[UIImage imageNamed:[self.arrayOfWeather objectAtIndex:index]]];
        }
        
        if (index<=1) {
            [cell.imgChuqing setImage:[UIImage imageNamed:@"icon_Right"]];
            cell.imgNoYi.hidden = YES;
        }
        else
        {
            [cell.imgChuqing setImage:[UIImage imageNamed:@"icon_unRight"]];
            cell.imgChuqing.hidden = YES;
            cell.imgNoYi.hidden = NO;
        }
        
        return cell;
        
        
    }else if (indexPath.section == 3){
    
        ShopGetCarIndicatorCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
    
    }else if (indexPath.section == 2){
        
        
        SelfGetCarIndicatorCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            
        }
        
        
        return cell;
    }

    
    return nil;
}


#pragma mark - TabelView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        //[self performSegueWithIdentifier:@"goSelfGet" sender:nil];
        
        
        NSString *check=[[NSUserDefaults standardUserDefaults] objectForKey:@"checkUser"];
        
        if ([check isEqualToString:@"yes"]) {
            
            [self performSegueWithIdentifier:@"goSelfGet" sender:nil];
            
        }else{
            [HKCommen addAlertViewWithTitel:@"尚未登陆"];
        }
        
        
    }else if (indexPath.section == 3){

            
        [self performSegueWithIdentifier:@"goShopGet" sender:nil];
        
    }

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSDictionary*)sender {
    
    if ([segue.identifier isEqualToString:@"goGuanggao"]) {
        
        EventBanerCtrl* vc = segue.destinationViewController;
        
        vc.dicModel = sender;
        
    }

}

- (IBAction)goPersonalCenter:(id)sender
{
    
    
    NSString *check=[[NSUserDefaults standardUserDefaults] objectForKey:@"checkUser"];
    
    if ([check isEqualToString:@"yes"]) {
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
        UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"PersonalCenter"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        TransactionCtrl *vc=[[TransactionCtrl alloc] initWithNibName:@"TransactionCtrl" bundle:nil];
        vc.judgeLoginOrPassword=@"login";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)goPersonalCenteWithNotify
{
    NSString *check=[[NSUserDefaults standardUserDefaults] objectForKey:@"checkUser"];
    
    if ([check isEqualToString:@"yes"]) {
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
        PersonalCenterCtrl* vc = [storyBoard instantiateViewControllerWithIdentifier:@"PersonalCenter"];
        [self.navigationController pushViewController:vc animated:NO];
        vc.fromMyOrder2 = 1;
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"goMyOrder2" object:nil];
    }
    else
    {
        TransactionCtrl *vc=[[TransactionCtrl alloc] initWithNibName:@"TransactionCtrl" bundle:nil];
        vc.judgeLoginOrPassword=@"login";
        [self.navigationController pushViewController:vc animated:YES];
    }


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
//    if (row == 0) {
//        
//        [self performSegueWithIdentifier:@"goGuanggao" sender:nil];
//
//        
//    }else if(row == 1){
//    
//        [self performSegueWithIdentifier:@"goCoupon" sender:nil];
//
//    }
    
    NSString *check=[[NSUserDefaults standardUserDefaults] objectForKey:@"checkUser"];
    
    if ([check isEqualToString:@"yes"]) {
        
        NSDictionary* dic  =  [self.array_advertisement objectAtIndex:row];
        
        if ([[dic objectForKey:@"state"] integerValue] == 1) {
            
            [self performSegueWithIdentifier:@"goGuanggao" sender:nil];
            
        }else if ([[dic objectForKey:@"state"] integerValue] == 2){
            
            [self performSegueWithIdentifier:@"goCoupon" sender:nil];
        }
        
        
    }else{
        
        [HKCommen addAlertViewWithTitel:@"尚未登陆"];
    }
    
    


}

#pragma mark - 点击城市处理

- (void)handleCitySelectedWithDic:(NSDictionary *)dic
{
    NSLog(@"cityDic = %@",dic);
    [UserDataManager shareManager].city = dic[@"cityName"];
    self.lblCity.text = dic[@"cityName"];
    [UserDataManager shareManager].cityId = dic[@"cityId"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dic] forKey:@"cityObject"];
    
    [self getModel];
}



@end
