//
//  MainDriverCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/1.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MainDriverCtrl.h"

@interface MainDriverCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MainDriverCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self ClearTableLine];
    self.myTable.delegate=self;
    [self initUI];
}

-(void)initUI
{
    [HKCommen addHeadTitle:@"我是接车员" whichNavigation:self.navigationItem];
    
    self.arrayOfImg=[NSArray arrayWithObjects:@"mine_Ordermanagement",@"mine_Commission",@"mine_Remind", nil];
    self.arrayOfList=[NSArray arrayWithObjects:@"订单管理",@"我的提成",@"订单提醒", nil];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"设置" forState: UIControlStateNormal];
    [rightButton setFrame:CGRectMake(0, 0, 100, 100)];
    [rightButton addTarget:self action:@selector(goSettingCtrl) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}

-(void)goSettingCtrl
{
    [self performSegueWithIdentifier:@"goSetting" sender:nil];
}

-(void)ClearTableLine
{
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.myTable setTableFooterView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView * )tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    
    return 3;
}

- (UITableViewCell * )tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.section==0) {
        static NSString *mainCellIndentifier=@"MainDriverCell";
        MainDriverCell *cell=[tableView dequeueReusableCellWithIdentifier:mainCellIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:mainCellIndentifier owner:self options:nil][0];
        }
        
        cell.img_Driver.image=[UIImage imageNamed:@"Default_picture"];
        cell.lbl_nameDriver.text=@"王女士";
        cell.lbl_mobileDriver.text=@"13265245252";
        
        return cell;
    }
    else
    {
        static NSString *listCellIndentifier=@"mainListCell";
        mainListCell *cell=[tableView dequeueReusableCellWithIdentifier:listCellIndentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:listCellIndentifier owner:self options:nil][0];
        }
        
        
        cell.img_List.image=[UIImage imageNamed:[self.arrayOfImg  objectAtIndex:indexPath.row]];
        cell.lbl_List.text=[self.arrayOfList objectAtIndex:indexPath.row];
        
        
        
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView * )tableView
heightForRowAtIndexPath:(NSIndexPath * )indexPath
{
    
    if (indexPath.section==0) {
        return 99.0;
    }
    else
    {
        return 53.0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (void)tableView:(UITableView * )tableView
didSelectRowAtIndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [self performSegueWithIdentifier:@"goOrderManager" sender:nil];
        }
        
        else if (indexPath.row==1)
        {
            [self performSegueWithIdentifier:@"goDeductMoney" sender:nil];
        }
        else if (indexPath.row==2)
        {
            [self performSegueWithIdentifier:@"goSuccessOrder" sender:nil];
        }
    }
}

@end
























