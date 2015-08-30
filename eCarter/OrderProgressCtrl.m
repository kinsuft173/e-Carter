//
//  OrderProgressCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/8/30.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "OrderProgressCtrl.h"
#import "HKCommen.h"
#import "MoneyReturnProgressView.h"

@interface OrderProgressCtrl ()
@property (strong,nonatomic) MoneyReturnProgressView *progressView;
@property (strong,nonatomic) NSMutableArray *arrayOfProgress;
@end

@implementation OrderProgressCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"订单进程" whichNavigation:self.navigationItem];
    
    self.progressView=[[NSBundle mainBundle]loadNibNamed:@"MoneyReturnProgressView" owner:self options:nil][0];
    [self.progressView setFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.progressView.lbl_BriefOne.text=@"还车时间";
    self.progressView.lbl_BriefTwo.text=@"到店时间";
    self.progressView.lbl_BriefThree.text=@"接车时间";
    self.progressView.lbl_BriefFour.text=@"下单时间";
    
    self.progressView.stageForMoneyReturn=2.0;
    [self.myView addSubview:self.progressView];
    
    self.arrayOfProgress=[[NSMutableArray alloc]initWithObjects:@"还车时间",@"到店时间",@"接车时间",@"下单时间", nil];
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
