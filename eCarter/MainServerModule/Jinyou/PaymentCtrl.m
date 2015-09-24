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
#import "TransactionCtrl.h"
//APP端签名相关头文件

//服务端签名只需要用到下面一个头文件
#import <QuartzCore/QuartzCore.h>
#import "NetworkManager.h"
#import "UserDataManager.h"

#import "AppDelegate.h"
#import "SuccessCtrl.h"


@interface PaymentCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PaymentCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"付款" whichNavigation:self.navigationItem];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.payCtrl  = self;
    appDelegate.reCtrl = nil;
    
    self.howMuch= [NSString stringWithFormat:@"%.2f元",[self.strTotalMount floatValue]];
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
    
    [self getModel];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"money" object:nil];


}

- (void)getModel
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userLoginInfo.user.uid,@"customerId", nil];
    
    [[NetworkManager shareMgr] server_queryUserAccountWithDic:dic completeHandle:^(NSDictionary *response) {
        
        if (response[@"data"]) {
            
            self.BalanceMoney = [response[@"data"] floatValue];
            
            [self.myTable reloadData];
            
        }
        
        
    }];

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
        
        vc.strTotalMount = self.strTotalMount;
        vc.strShopName = self.strShopName;
        vc.strSeviceItem = self.strSeviceItem;
        vc.BalanceMoney = self.BalanceMoney;
        vc.dicPreParams = self.dicPreParams;
        

        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
        [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
        [[NetworkManager shareMgr] server_userHasPsdWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSLog(@"交易密码获取;%@",response);
            
            if (response == nil) {
                
                hud.hidden = YES;
                [HKCommen addAlertViewWithTitel:@"网络连接问题，请重试"];
                
                return ;
            }
            
            
            NSString* messege = [response objectForKey:@"message"];
            
            
            if (!([messege integerValue] == 1 ) ) {
                
                
                TransactionCtrl *vc=[[TransactionCtrl alloc] initWithNibName:@"TransactionCtrl" bundle:nil];
                vc.judgeLoginOrPassword=@"password";
                [self.navigationController pushViewController:vc animated:YES];
                
                hud.hidden = YES;
                return;
                
            }else{
            
                hud.hidden = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            
            }
        }];
        

        
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
    
    
    [[NetworkManager shareMgr] server_getOrderPreId:self.dicPreParams[@"orderId"] completeHandle:^(NSDictionary *responese) {
        
        if (responese == nil) {
            
            
            hud.hidden = YES;
        }
        
        
        hud.hidden = YES;
        
        NSDictionary* dic = [responese objectForKey:@"xml"];
        
    
        
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


//- (NSString*)sign
//{
//    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.appId,@"appid",self.partnerid,@"partnerid",self.prepayid,@"prepayid",self.package,@"package",
//                         
//                         self.noncestr,@"noncestr",self.timestamp,@"timestamp",nil];
//    
//    
//    NSString* tempStr = [self translateDicIntoSignString:dic];
//    
//    return [self md5:tempStr].uppercaseString;
//    
//}
//
//- (NSString*)translateDicIntoSignString:(NSDictionary*)dic
//{
//    NSArray* array           = [dic allKeys];
//    NSArray* paramSortAarray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return  [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    
//    NSString* stringForSign = [[NSString alloc] init];
//    for (int i = 0; i < [array count] ; i++) {
//        
//        NSString* tempKey       = [paramSortAarray objectAtIndex:i];
//        NSString* tempContent   = [dic objectForKey:tempKey];
//        
//        if ((((NSString*)tempContent).length == 0) ||
//            (id)tempContent == [NSNull null] ) {
//            
//            continue;
//        }
//        
//        if ( i == [array count] - 1) {
//            
//            NSString* appendString = [NSString stringWithFormat:@"%@=%@",tempKey,tempContent];
//            stringForSign = [stringForSign stringByAppendingString:appendString];
//            
//        }else{
//            
//            NSString* appendString = [NSString stringWithFormat:@"%@=%@&",tempKey,tempContent];
//            stringForSign = [stringForSign stringByAppendingString:appendString];
//            
//        }
//        
//    }
//    
//    
////    stringForSign = [stringForSign stringByAppendingString:[NSString stringWithFormat:@"&key=%@",WX_API_KEY]];
//    
//    NSLog(@"stringForSign = %@",stringForSign);
//    
//    return stringForSign;
//}
//

//- (NSString *)md5:(NSString *)str
//{
//    const char *cStr = [str UTF8String];
//    unsigned char result[16];
//    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
//    
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
//}


-(void)onResp:(BaseResp*)resp{
    
    if ([resp isKindOfClass:[PayResp class]]){
        
        PayResp*response=(PayResp*)resp;
        
        if (response.errCode == WXSuccess) {
            
            [[NetworkManager shareMgr] server_wxPayNotify:[self.dicPreParams objectForKey:@"orderId"] completeHandle:^(NSDictionary *response) {
                
//                [self paySucceed];
                
            }];
            
                [self paySucceed];
            
        }else{
        
        
            [HKCommen addAlertViewWithTitel:@"微信支付失败"];
        }
        

    }
}


- (void)paySucceed
{
    SuccessCtrl *vc=[[SuccessCtrl alloc] initWithNibName:@"SuccessCtrl" bundle:nil];
    vc.strName = self.strShopName;
    [self.navigationController pushViewController:vc animated:YES];

}



@end
