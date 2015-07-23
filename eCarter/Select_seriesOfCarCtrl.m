//
//  Select_seriesOfCarCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "Select_seriesOfCarCtrl.h"
#import "HKCommen.h"

@interface Select_seriesOfCarCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation Select_seriesOfCarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void)initUI
{
    if ([self.JudgeWhereFrom isEqualToString:@"series"])
    {
        [HKCommen addHeadTitle:@"选择车系" whichNavigation:self.navigationItem];
        
        self.array_showArray=[NSArray arrayWithObjects:@"2014款 2.0L",@"2014款 2.0L",@"2014款 2.0L", nil];
    }
    else if ([self.JudgeWhereFrom isEqualToString:@"name"])
    {
        
        [HKCommen addHeadTitle:@"奥迪" whichNavigation:self.navigationItem];
        self.array_showArray=[NSArray arrayWithObjects:@"奥迪A6L",@"奥迪Q5",@"奥迪R8", nil];
    }
    else if ([self.JudgeWhereFrom isEqualToString:@"color"])
    {
        [HKCommen addHeadTitle:@"选择颜色" whichNavigation:self.navigationItem];
       self.array_showArray=[NSArray arrayWithObjects:@"银色",@"黑色",@"白色",@"红色",@"灰色",@"蓝色",@"棕色",@"深蓝色",@"香槟金",@"其他", nil];
        
        self.array_color=[NSArray arrayWithObjects:@"Silver",@"Black",@"White",@"red",@"Grey",@"blue",@"Brown",@"Navy_Blue",@"Champagne_gold",@"Other", nil];
    }
    
    
    
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [rightButton setFrame:CGRectMake(0, 0, 30, 100)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=item;
    
    [HKCommen setExtraCellLineHidden:self.myTable];
}

-(void)commit
{}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array_showArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId = @"SeriesCarCell";

        
        SeriesCarCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            
        }
    
    if ([self.JudgeWhereFrom isEqualToString:@"color"]) {
        cell.imgOfColor.hidden=NO;
        [cell.imgOfColor setImage:[UIImage imageNamed:[self.array_color objectAtIndex:indexPath.row]]];
    }
    else
    {
        cell.imgOfColor.hidden=YES;
    }
    
    cell.lbl_seriesOfCar.text=[self.array_showArray objectAtIndex:indexPath.row];
        
        return cell;

}


@end
