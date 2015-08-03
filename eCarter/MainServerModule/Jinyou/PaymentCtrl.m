//
//  PaymentCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "PaymentCtrl.h"
#import "BalanceMoneyCell.h"
#import "OtherPaymentCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Order.h"
#import <Foundation/Foundation.h>

#import "WXApiObject.h"
#import "WXApi.h"
//APP端签名相关头文件
#import "payRequsestHandler.h"

//服务端签名只需要用到下面一个头文件
#import "ApiXml.h"
#import <QuartzCore/QuartzCore.h>


@interface PaymentCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PaymentCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"付款" whichNavigation:self.navigationItem];
    
    self.howMuch=@"39.00元";
    self.BalanceMoney=100.0;
    self.arrayOfPayment=[NSArray arrayWithObjects:@"支付宝付款",@"微信付款", nil];
    
    self.lbl_howMuch.text=self.howMuch;
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
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId1 = @"BalanceMoneyCell";
    NSString* cellId2 = @"OtherPaymentCell";

    
    if (indexPath.row == 0) {
        
        BalanceMoneyCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        cell.lbl_BalanceMoney.text=[NSString stringWithFormat:@"可用余额%g元",self.BalanceMoney];
        
        return cell;
        
        
    }
    
    else {
        
        OtherPaymentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
        }
        cell.lbl_OtherWayForPay.text=[self.arrayOfPayment objectAtIndex:indexPath.row-1];
        if (indexPath.row==1) {
            [cell.img_Payment setImage:[UIImage imageNamed:@"icon_alipay_"]];
        }
        else if (indexPath.row==2)
        {
        [cell.img_Payment setImage:[UIImage imageNamed:@"icon_WeChatpay"]];
    }
        
        
        
        
        
        
        return cell;
        
    }

    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        BalanceMoneyCtrl *vc=[[BalanceMoneyCtrl alloc] initWithNibName:@"BalanceMoneyCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 1){
    
        [self payAliAction];
        
    }else if (indexPath.row == 2){
    
        [self sendWinxinPay];
    
    }
}

- (void)payAliAction
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088612117404563";
    NSString *seller = @"info@kswiki.com";
    NSString *privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAJoDAQHVkOxP0sscLyWTL8IlOKWMq75+lvIXmJTGZJ3NsoMV2lNMX7vklOazvlPrZN7BZHkHkYIzjwxNWE1u+QS+i6vCslzmnRMoO/hFiZ7fHPkyifklXfmb/efhc2p06w3nzwtoVceASInTh6iHibGMaCjifpKlV6sl17lvoT79AgMBAAECgYB1v7ozZs8ofVcShvfc6I1pCAApQkXEnRBXA4dap9whcjT7V+fWK9w90WOuhtoLWzuBu6ZPimPLghPqOfA7M48ay9gv7HMhVt9dWVIgf0DmmtNeCEEu0S5ex9x82d2t36PRbcAtBVTBQK4OJKSQ3V1sAxylZS6TZ1CgcSTksyHdgQJBAMiWSwPjRlWE6c0VHyb/J0F1zAtS3zdCHrDDoK+54D3wNIvrkIvG9p+YwL3MUETnQIXxKBBuAfz9imBLDhQoQ1ECQQDEjtvH9Y0RnfWWInnBNa0cN64CIwwkypGHkmr3ghi2hDqo/4kZJL8hnhVHiubzErars8ThdCPIJCK0QNRk3t3tAkAG4WDhWUJoXI7Ighj3dXkbPbcqDEWr15DF72/rlyyh80NaKVJj+Qcsoki6Oe/m7SfBcGw3ZA6dZvUAKJLrDhaBAkAn+q61YzqIRMq4+NYu+E33mVOpV5uWuCUVoDBlm26PYSHVUfR+yrydh9voK1aCRmIlVnFLMiY9BSyR4UXSJoqZAkAhBxGmwYu4dI1sbMbkFeFShNNLpFUoic1xo5kFQLlWCNkcRue9zxQQp2jQTbLjSnibclptWxxk/53+ZuSUVZE6";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO =  @"000000000000001";//[self generateTradeNO];//[NSString stringWithFormat:@"%@",[self.orderResult objectForKey:@"id"]];
    
    
    order.productName = [self generateTradeNO];

    order.productDescription = @"test";
    
    
    order.amount = [NSString stringWithFormat:@"0.01"];

    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"eCarter";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSString *resultStatus =  [resultDic objectForKey:@"resultStatus"];
            
            NSLog(@"resultDic = %@",resultDic);
            
            if (resultStatus.integerValue == 9000) {
                
                
                
                SuccessCtrl *vc=[[SuccessCtrl alloc] initWithNibName:@"SuccessCtrl" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            else {
                
                NSString *mStr = [resultDic objectForKey:@"memo"];
                
                if (mStr != nil && ![mStr isEqualToString:@""]) {
//                    [CTCommon addAlertWithTitle:[resultDic objectForKey:@"memo"]];
                }
                
            }
            
        }];
        
    }
    
    
}

#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


#pragma mark - 微信支付

//============================================================
// V3&V4支付流程实现
// 注意:参数配置请查看服务器端Demo
// 更新时间：2015年3月3日
// 负责人：李启波（marcyli）
//============================================================
- (void)sendWinxinPay
{
    //从服务器获取支付参数，服务端自定义处理逻辑和格式
    //订单标题
    NSString *ORDER_NAME    = @"Ios服务器端签名支付 测试";
    //订单金额，单位（元）
    NSString *ORDER_PRICE   = @"0.01";
    
    //根据服务器端编码确定是否转码
    NSStringEncoding enc;
    //if UTF8编码
    //enc = NSUTF8StringEncoding;
    //if GBK编码
    enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *urlString = [NSString stringWithFormat:@"%@?plat=ios&order_no=%@&product_name=%@&order_price=%@",
                           SP_URL,
                           [[NSString stringWithFormat:@"%ld",time(0)] stringByAddingPercentEscapesUsingEncoding:enc],
                           [ORDER_NAME stringByAddingPercentEscapesUsingEncoding:enc],
                           ORDER_PRICE];
    
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.openID              = [dict objectForKey:@"appid"];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }else{
//                [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
            }
        }else{
//            [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
        }
    }else{
//        [self alert:@"提示信息" msg:@"服务器返回错误"];
    }
}


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}



//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

@end
