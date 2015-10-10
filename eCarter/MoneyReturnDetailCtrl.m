//
//  MoneyReturnDetailCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/8/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MoneyReturnDetailCtrl.h"
#import "MoneyReturnProgressView.h"
#import "HKCommen.h"
#import "UserDataManager.h"
#import "NetworkManager.h"

@interface MoneyReturnDetailCtrl ()
@property (strong,nonatomic) MoneyReturnProgressView *progressView;
@property (strong,nonatomic) IBOutlet UILabel* lblDescripTotal;
@property (strong,nonatomic) IBOutlet UILabel* lblDescripDetail;

@end

@implementation MoneyReturnDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.myScroll setContentSize:CGSizeMake(0, 700)];

    if ([self.strType isEqualToString:@"订单详情"]) {
        
        [HKCommen addHeadTitle:@"订单详情" whichNavigation:self.
         navigationItem];
        
    }else{
    
        [HKCommen addHeadTitle:@"退款详情" whichNavigation:self.
         navigationItem];
        
    }

    
    self.lblDescripTotal.text = [NSString stringWithFormat:@"退款金额：￥%.2f",self.order.pay.floatValue];
    self.lblDescripDetail.text = [NSString stringWithFormat:@"%.2f元已成功退至您的账户余额",self.order.pay.floatValue];
    [self getModel];
    
 
    
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

- (void)getModel
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:self.order.id forKey:@"orderId"];
    //    [dic setValue:@"1" forKey:@"accountType"];
    
    NSLog(@"账户字典：%@",dic);
    
    [[NetworkManager shareMgr] server_queryOrderLogDetailWithDic:dic completeHandle:^(NSDictionary *response) {
        
        if (response) {
            
            NSLog(@"交易记录：%@",response);
            
            NSArray* array = [response objectForKey:@"data"];
            
            if (array.count != 0) {
                
                self.progressView=[[NSBundle mainBundle]loadNibNamed:@"MoneyReturnProgressView" owner:self options:nil][0];
                
             
                
                if ([self.strType isEqualToString:@"订单详情"]) {
                    
                     [self.progressView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400)];
                    
                       self.progressView.backgroundColor = [UIColor clearColor];
                    
                }else{
                
                    [self.progressView setFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 400)];
                    
                }
                
                
                self.progressView.stageForMoneyReturn= array.count + 0.1;
                self.progressView.arrayModel = array;
        
                [self.viewForReturnDetail addSubview:self.progressView];
                
            }
            
            

        }
        
        
    }];


}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
