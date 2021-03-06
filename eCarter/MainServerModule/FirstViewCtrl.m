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
#import "HYActivityView.h"
#import "SetTransactionPassworsCtrl.h"
#import "TransactionCtrl.h"
#import "EventBanerCtrl.h"

#import <ShareSDK/ShareSDK.h>

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

@property (nonatomic, strong) HYActivityView *activityView;
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
    [dicWeather setObject:@"25760ee0793948ce91483dcf412e916e" forKey:@"key"];
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
        
        cell.lbl_weather.text =  self.dic_weather[@"weather"];
        cell.lbl_temperature.text = [NSString stringWithFormat:@"%@℃",self.dic_weather[@"temperature"]];
        
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
        
        [self performSegueWithIdentifier:@"goSelfGet" sender:nil];
        
        /*
        NSString *check=[[NSUserDefaults standardUserDefaults] objectForKey:@"checkUser"];
        
        if ([check isEqualToString:@"yes"]) {
            
            [self performSegueWithIdentifier:@"goSelfGet" sender:nil];
            
        }else{
            [HKCommen addAlertViewWithTitel:@"尚未登陆"];
        }
        */
        
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
    
    /*
    NSLog(@"goPersonalCenter");
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
    
    UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"PersonalCenter"];
    
    [self.navigationController pushViewController:vc animated:YES];
    */
    
    
    
    
    
    /*
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv = [[ButtonView alloc]initWithText:@"QQ好友" image:[UIImage imageNamed:@"Share_qq"] handler:^(ButtonView *buttonView){
            NSLog(@"点击QQ");
            [self shareQQ];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信好友" image:[UIImage imageNamed:@"share_WeChat"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
            [self shareWeixinFriend];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"朋友圈" image:[UIImage imageNamed:@"share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            [self shareWeixinCircle];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"新浪微博" image:[UIImage imageNamed:@"Share_sina"] handler:^(ButtonView *buttonView){
            NSLog(@"点击新浪微博");
            [self shareSina];
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
     */
}

-(void)shareQQ
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK clientShareContent:publishContent //内容对象
                            type:ShareTypeQQ //平台类型
                   statusBarTips:YES
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {//返回事件
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                              }
                              else if (state == SSPublishContentStateFail)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
                              }
                          }];
}

-(void)shareSina
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK clientShareContent:publishContent //内容对象
                            type:ShareTypeSinaWeibo //平台类型
                   statusBarTips:YES
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {//返回事件
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                              }
                              else if (state == SSPublishContentStateFail)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
                              }
                          }];
}

-(void)shareWeixinFriend
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK clientShareContent:publishContent //内容对象
                            type:ShareTypeWeixiSession //平台类型
                   statusBarTips:YES
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {//返回事件
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                              }
                              else if (state == SSPublishContentStateFail)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
                              }
                          }];
}

-(void)shareWeixinCircle
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK clientShareContent:publishContent //内容对象
                            type:ShareTypeWeixiTimeline //平台类型
                   statusBarTips:YES
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {//返回事件
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                              }
                              else if (state == SSPublishContentStateFail)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
                              }
                          }];
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
    
   NSDictionary* dic  =  [self.array_advertisement objectAtIndex:row];
    
    if ([[dic objectForKey:@"state"] integerValue] == 1) {
        
         [self performSegueWithIdentifier:@"goGuanggao" sender:nil];
        
    }else if ([[dic objectForKey:@"state"] integerValue] == 2){
    
        [self performSegueWithIdentifier:@"goCoupon" sender:nil];
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
