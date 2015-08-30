//
//  HomeTypeSelectedCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/8/31.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "HomeTypeSelectedCtrl.h"
#import "ProvinceCell.h"
#import "HKCommen.h"
#import "HKMapManager.h"

@interface HomeTypeSelectedCtrl ()

@end

@implementation HomeTypeSelectedCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HKCommen addHeadTitle:@"选择地址类型" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    
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
    return 44;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"ProvinceCell";
    
    
    ProvinceCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] objectAtIndex:0];
        
    }
    
    if (indexPath.row == 0) {
        cell.lbl_province.text=@"家庭地址";
    }else if (indexPath.row == 1){
        cell.lbl_province.text=@"工作地址";
    
    }else{
    
        cell.lbl_province.text=@"其他地址";
    }
    

    return cell;
    
}


- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        [HKMapManager shareMgr].adressType = @"1";
        
    }else if(indexPath.row == 1) {
        
        [HKMapManager shareMgr].adressType = @"2";
        
    }else if(indexPath.row == 2) {
        
        [HKMapManager shareMgr].adressType = @"3";
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



@end
