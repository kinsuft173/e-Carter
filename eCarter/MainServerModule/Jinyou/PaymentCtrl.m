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
#import "NetworkManager.h"
#import "UserDataManager.h"


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
    
        [self StartWxPayment];
    
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
    NSString *partner = @"2088021153079020";
    NSString *seller = @"3193673297@qq.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAPJxlSGDdjWHgivmq+NIE9p08klG+2H0NQX3bbaUyGx2WUhd2Z7dY8XkH+YJf56B/InhC19QdZTfzwWjr4zoVN0JLGvviPpDxW+ps+V9nV2Xq4m/Jy+pmCz/JV0m0cqeMCSbUjtN1E17JaDqCqLRNlDcYUW4htijIGBFV0iSmN2bAgMBAAECgYEA6CBQBRJ1b7MasyXclXRBbfxirj5EGflTey734MR7UT3PJjaVUkHucV6GHB4kDoOuY+UQmmXS7oOLF38taeBYvpv7AIC88wau3BnmBMREmk9bragNoxjPXUUE/Zv9RE4pA1ZsSHIcmQL3g+TjfgIUKXJF7b7AND7klrzQ+XEbyAECQQD/0cUaI27nbqTEewCQzeee+AgXPpPw+uxuJfJCBgPDghtJZfqCDNVjPedDY8UtbAXTolTlOAVYQySD7+8L1oSbAkEA8p1lOzTdcrBO/yDpD5CWrOgRDd/IdWKf//Fr1hSkGLhgbzerQMSAqaqhbnvFamcjqYaOwqNUnB1Dc9K8ybIbAQJAS6MJJOZPFyxWmSVJEIdgsVbihYTiFwEJwLOFglHm8PpZ+QSm4abLvNEDvKAWH4zt2BoKAc/jfKo1dLEPO6/MewJAXEdPfLCD1h6HPXToEHp/RO7TpcJLPZKwpqnNyVR6gciHLWYwJedXxLDYy+wZz3nBT7aVUCTNhr9+q2wpUFIFAQJAGNbGJ/vHqoUo1YzT6MDE3ldKqZ463ak+fjF3sl6Ie3K4FTyb61Bcw3rUIF3sxy/h6uBiTp/tm01uuV3b5ZIsPA==";
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
    order.tradeNO =  self.dicPreParams[@"orderId"];//@"000000000000001";//[self generateTradeNO];//[NSString stringWithFormat:@"%@",[self.orderResult objectForKey:@"id"]];
    
    
    order.productName =  @"E车夫服务";///[self generateTradeNO];

    order.productDescription = @"test";
    
    
    order.amount = [NSString stringWithFormat:@"0.01"];

    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    order.notifyURL = [NSString stringWithFormat:@"%@/order/notify/alipay/%@",SERVER,self.dicPreParams[@"orderId"]];
    
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
                
//                NSString *mStr = [resultDic objectForKey:@"memo"];
//                
//                if (mStr != nil && ![mStr isEqualToString:@""]) {
////                    [CTCommon addAlertWithTitle:[resultDic objectForKey:@"memo"]];
//                }
//                
//                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
//                
//                [dic setObject:[self.dicPreParams objectForKey:@"orderId"] forKey:@"orderId"];
//                [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
//                [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
//                [dic setObject:@"2" forKey:@"payStyle"];
//                
//                [dic setObject:@"0.01" forKey:@"amount"];
//                [dic setObject:@"1" forKey:@"couponId"];
//                [dic setObject:@"0.01" forKey:@"couponAmount"];
//                [dic setObject:@"0.01" forKey:@"payAmount"];
//                
//                [[NetworkManager shareMgr] server_saveOrderPayWithDic:dic completeHandle:^(NSDictionary *response) {
//                    
//                    NSDictionary* dicTmep = [response objectForKey:@"data"];
//                    NSLog(@"保存订单：%@",dicTmep);
//                    
//                    if (dicTmep) {
//                        
//                        
//                
//                        
//                    }
//                    
//                
//                    
//                }];
                
                [HKCommen addAlertViewWithTitel:@"支付失败"];
                
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






//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}





#pragma mark - 微信支付

//============================================================
// V3&V4支付流程实现
// 注意:参数配置请查看 https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=9_12&index=2
// 更新时间：2015年8月18日
// 负责人：HUKUN
//============================================================
- (void)StartWxPayment
{
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSDictionary* dic; /// = [[NetworkManager shareMgr] serve :param];
        
        NSLog(@"dic counsel_order_id=  %@",dic);
        
        self.paymentRequest.wxPayParames.prepayid = [dic[@"payment"] objectForKey:@"prepay_id"];//[@"prepay_id"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [hud setHidden:YES];
            [self payWexin];
            
        });
    });
    
}

- (void)payWexin
{
    PayReq* req             = [[PayReq alloc] init];
    
    //test数据
    //self.paymentRequest.wxPayParames.timestamp = @"1439974597";
    //self.paymentRequest.wxPayParames.prepayid = @"wx20150819164931377b75bdb00179201367";
    //self.paymentRequest.wxPayParames.noncestr = @"9f655cc8884fda7ad6d8a6fb15cc001e";
    
    req.openID              = self.paymentRequest.wxPayParames.appId;
    req.partnerId           = self.paymentRequest.wxPayParames.partnerid;
    req.prepayId            = self.paymentRequest.wxPayParames.prepayid;
    req.nonceStr            = self.paymentRequest.wxPayParames.noncestr;
    req.timeStamp           = self.paymentRequest.wxPayParames.timestamp.integerValue;
    req.package             = self.paymentRequest.wxPayParames.package;
    
    req.sign                = self.paymentRequest.wxPayParames.sign;
    
    
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    [WXApi sendReq:req];
}


@end
