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

@interface MoneyReturnDetailCtrl ()
@property (strong,nonatomic) MoneyReturnProgressView *progressView;
@end

@implementation MoneyReturnDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.myScroll setContentSize:CGSizeMake(0, 700)];
    
    [HKCommen addHeadTitle:@"退款详情" whichNavigation:self.navigationItem];
    
    self.progressView=[[NSBundle mainBundle]loadNibNamed:@"MoneyReturnProgressView" owner:self options:nil][0];
    [self.progressView setFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 400)];
    self.progressView.stageForMoneyReturn=2.0;
    [self.viewForReturnDetail addSubview:self.progressView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
