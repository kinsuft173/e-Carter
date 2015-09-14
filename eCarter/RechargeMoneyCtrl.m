//
//  RechargeMoneyCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "RechargeMoneyCtrl.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Order.h"
#import <Foundation/Foundation.h>

#import "WXApiObject.h"
#import "WXApi.h"

#import "AppDelegate.h"
#import "NetworkManager.h"
#import "UserDataManager.h"

#import "PaymentRequest.h"

@interface RechargeMoneyCtrl ()

@property BOOL isWx;

@property (nonatomic, strong) IBOutlet UIButton* btnWx;
@property (nonatomic, strong) IBOutlet UIButton* btnAli;

@property NSString* tranId;

@property (nonatomic, strong) PaymentRequest* paymentRequest;

@end

@implementation RechargeMoneyCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [HKCommen addHeadTitle:@"充值" whichNavigation:self.navigationItem];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.payCtrl  = nil;
    appDelegate.reCtrl = self;

    self.lbl_balance.text=self.balance;
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
- (IBAction)commitReCharge:(UIButton *)sender {
    
    if ([self.txt_amount.text isEqualToString:@"请输入充值金额"]||[self.txt_amount.text  isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请输入充值金额"];
        
        return;
        
    }
    
    
    if (self.isWx == NO) {
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在加载";
        
        
        NSDictionary* dicNew = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.uid,@"customerId",@"0.01",@"amount" ,nil];
        
        
        
        [[NetworkManager shareMgr] server_getRechangePreId:dicNew completeHandle:^(NSDictionary *responese) {
            
            if (responese == nil) {
                
                
                hud.hidden = YES;
            }
            
            
            hud.hidden = YES;
            
            NSDictionary* dic = [responese objectForKey:@"data"];
            
            
            self.tranId = [NSString stringWithFormat:@"%@",[responese objectForKey:@"tranId"]] ;
            
            NSLog(@"dicNew = %@",dicNew);
            NSLog(@"tranId = %@",self.tranId);
            [self payAliAction];
            
        }];
        

        
    }else{
    
        [self StartWxPayment];
    
    }
    
    
}

- (PaymentRequest*)paymentRequest
{
    if (!_paymentRequest) {
        
        _paymentRequest = [[PaymentRequest alloc] init];
        _paymentRequest.wxPayParames = [[WxPayParams alloc] init];
        _paymentRequest.aliPayParames = [[AliPayParames alloc] init];
        
    }
    
    return _paymentRequest;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ali:(id)sender
{
    self.isWx = NO;
    

        
        
        [self.btnWx setImage:[UIImage imageNamed:@"but_Unchecked.png"] forState:UIControlStateNormal];
        [self.btnAli setImage:[UIImage imageNamed:@"but_checked"] forState:UIControlStateNormal];
        


}

- (IBAction)wx:(id)sender
{
    
    self.isWx = YES;

        
        
    [self.btnWx setImage:[UIImage imageNamed:@"but_checked"] forState:UIControlStateNormal];
    [self.btnAli setImage:[UIImage imageNamed:@"but_Unchecked.png"] forState:UIControlStateNormal];
   
 
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
    order.tradeNO = self.tranId;//[self generateTradeNO];//[NSString stringWithFormat:@"%@",[self.orderResult objectForKey:@"id"]];
    
    
    order.productName =  @"E车夫服务";///[self generateTradeNO];
    
    order.productDescription = @"test";
    
    
    order.amount = @"0.01";//self.txt_amount.text;//[NSString stringWithFormat:self.txt_amount.text];
    
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    order.notifyURL = [NSString stringWithFormat:@"%@/recharge/notify/alipay/%@",SERVER,self.tranId];
    
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
                
//                [[NetworkManager shareMgr] server_aliRechargeNotify:self.tranId withDic:[NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.uid,@"customerId",self.txt_amount.text,@"amount" ,nil] completeHandle:^(NSDictionary *response) {
//                    
//                    //                [self paySucceed];
//                    
//                    NSLog(@"支付宝充值支付的回调,%@",response);
//                    
//                }];
                
                [self paySucceed];
                
                
            }
            else {
                
                
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


- (void)paySucceed
{

    ReChargeSuccessCtrl *vc=[[ReChargeSuccessCtrl alloc] initWithNibName:@"ReChargeSuccessCtrl" bundle:nil];
    vc.judgeRefillOrGetReal=@"refill";
    
    vc.amout = self.txt_amount.text;
    [self.navigationController pushViewController:vc animated:YES];
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
    
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    //
    //        NSDictionary* dic; /// = [[NetworkManager shareMgr] serve :param];
    //
    //        NSLog(@"dic counsel_order_id=  %@",dic);
    //
    //        []
    //
    //        self.paymentRequest.wxPayParames.prepayid = [dic[@"payment"] objectForKey:@"prepay_id"];//[@"prepay_id"];
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //
    //
    //            [hud setHidden:YES];
    //            [self payWexin];
    //
    //        });
    //    });
    
    NSDictionary* dicNew = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.uid,@"customerId",@"0.01",@"amount" ,nil];
    

    
    [[NetworkManager shareMgr] server_getRechangePreId:dicNew completeHandle:^(NSDictionary *responese) {
        
        if (responese == nil) {
            
            
            hud.hidden = YES;
        }
        
        
        hud.hidden = YES;
        
        NSDictionary* dic = [responese objectForKey:@"xml"];
        
        
        self.tranId = [NSString stringWithFormat:@"%@",[responese objectForKey:@"tranId"]] ;
        
            NSLog(@"dicNew = %@",dicNew);
        NSLog(@"tranId = %@",self.tranId);
        [self payWexin:dic];
        
    }];
    
}

- (void)payWexin:(NSDictionary*)dic
{
    PayReq* req             = [[PayReq alloc] init];
    
    //test数据
    //self.paymentRequest.wxPayParames.timestamp = @"1439974597";
    //self.paymentRequest.wxPayParames.prepayid = @"wx20150819164931377b75bdb00179201367";
    //self.paymentRequest.wxPayParames.noncestr = @"9f655cc8884fda7ad6d8a6fb15cc001e";
    
    req.openID              =  @"wx14658f9874c6c7af";//dic[@"appid"];
    req.partnerId           =   @"1266652601";//dic[@"mch_id"];
    req.prepayId            = dic[@"prepay_id"];
    
    
    req.nonceStr            =  self.paymentRequest.wxPayParames.noncestr;//dic[@"nonce_str"];
    req.timeStamp           = [NSString stringWithFormat:@"%ld",time(NULL)].integerValue;
    req.package             = self.paymentRequest.wxPayParames.package;
    
    
    self.paymentRequest.wxPayParames.appId = req.openID;
    self.paymentRequest.wxPayParames.partnerid = req.partnerId;
    self.paymentRequest.wxPayParames.prepayid = req.prepayId;
    self.paymentRequest.wxPayParames.noncestr = req.nonceStr;
    self.paymentRequest.wxPayParames.timestamp = [NSString stringWithFormat:@"%u",(unsigned int)req.timeStamp];//req.timeStamp;
    
    
    req.sign                = self.paymentRequest.wxPayParames.sign;
    
    
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    [WXApi sendReq:req];
}


-(void)onResp:(BaseResp*)resp{
    
    if ([resp isKindOfClass:[PayResp class]]){
        
        PayResp*response=(PayResp*)resp;
        
        if (response.errCode == WXSuccess) {
            
//            [[NetworkManager shareMgr] server_wxRechargeNotify:self.tranId withDic:[NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.uid,@"customerId",self.txt_amount.text,@"amount" ,nil] completeHandle:^(NSDictionary *response) {
//                
//      
//                
//                NSLog(@"微信充值支付的回调,%@",response);
//                
//            }];
            
            [self paySucceed];
            
        }else{
            
            NSLog(@"response = %d",response.errCode);
            
            
            [HKCommen addAlertViewWithTitel:@"微信支付失败"];
        }
        
        
    }
}



@end
