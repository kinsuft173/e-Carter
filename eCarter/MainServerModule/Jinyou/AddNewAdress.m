//
//  AddNewAdress.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "AddNewAdress.h"
#import "HKCommen.h"
#import "HKMapCtrl.h"
#import "HKMapManager.h"
#import "HKMapManager.h"

@interface AddNewAdress ()

@end

@implementation AddNewAdress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.province=@"广东省";
    self.city=@"广州市";
    self.place=@"天河区";
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([HKMapManager shareMgr].address) {
        
        self.lbl_AdressOfSelect.text = [HKMapManager shareMgr].address;
    }

}

-(void)initUI
{
    [HKCommen addHeadTitle:@"编辑地址" whichNavigation:self.navigationItem];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [rightButton setFrame:CGRectMake(0, 0, 30, 100)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=item;
    
    self.lbl_Alert.text=@"你选择的位置暂时未提供服务；已反馈给商家，敬请期待";
    self.lbl_AdressOfSelect.text=[NSString stringWithFormat:@"%@%@%@",self.province,self.city,self.place];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save
{

}

- (IBAction)goMapCtrl:(id)sender
{
    HKMapCtrl* vc  = [[HKMapCtrl alloc]  initWithNibName:@"HKMapCtrl" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
