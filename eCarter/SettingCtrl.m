//
//  SettingCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SettingCtrl.h"
#import <ShareSDK/ShareSDK.h>
#import "HYActivityView.h"

@interface SettingCtrl ()
@property (nonatomic, strong) HYActivityView *activityView;
@end

@implementation SettingCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"设置" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    self.arrayOfInfo=[NSArray arrayWithObjects:@"设置交易密码",@"关于我们",@"分享",@"版本更新", nil];
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

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        return 68;
    }
    
    return 44;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"SettingCell";
    NSString *address=@"AddAdressCell";

 
    if (indexPath.section==0) {
        SettingCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] objectAtIndex:0];
            
        }
        cell.lbl_info.text=[self.arrayOfInfo objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        AddAdressCell* cell = [tableView dequeueReusableCellWithIdentifier:address];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:address owner:self options:nil] objectAtIndex:0];
            
        }
        
        [cell.btn_commit setTitle:@"退出登录" forState:UIControlStateNormal];
        [cell.btn_commit addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    

    
}

-(void)loginOut
{
    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"checkUser"];
    [self.navigationController popToRootViewControllerAnimated:NO];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"goLogin" object:nil];
    return;
    
    //傻屌 面对对象是啥？
//    TransactionCtrl *vc=[[TransactionCtrl alloc] initWithNibName:@"TransactionCtrl" bundle:nil];
//    vc.judgeLoginOrPassword=@"login";
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"checkUser"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        TransactionCtrl *vc=[[TransactionCtrl alloc] initWithNibName:@"TransactionCtrl" bundle:nil];
        vc.judgeLoginOrPassword=@"password";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==1) {
        AboutUsCtrl *vc=[[AboutUsCtrl alloc] initWithNibName:@"AboutUsCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==2)
    {
        [self share];
    }
}


-(void)share
{
    
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

@end
