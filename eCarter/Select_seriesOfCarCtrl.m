//
//  Select_seriesOfCarCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "Select_seriesOfCarCtrl.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "CarBrand.h"
#import "CarSeries.h"

@interface Select_seriesOfCarCtrl ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *arrayOfCarBrand;
@property (nonatomic,strong)NSArray *arrayOfYear;
@end

@implementation Select_seriesOfCarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
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

-(void)initUI
{
    if ([self.JudgeWhereFrom isEqualToString:@"name"])
    {

        [HKCommen addHeadTitle:@"选择车系" whichNavigation:self.navigationItem];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"4d771c854bd34b8fae77241bd49889d8" forKey:@"key"];
        
        [[NetworkManager shareMgr] server_queryCarLists:dic completeHandle:^(NSDictionary *response) {
            
            NSLog(@"获得字典：%@",response);
            self.arrayOfCarBrand = [response objectForKey:@"result"];
            
            [self.myTable reloadData];
            
        }];
        
        
    }else if ([self.JudgeWhereFrom isEqualToString:@"series"])
    {
        [HKCommen addHeadTitle:@"年款排量" whichNavigation:self.navigationItem];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"4d771c854bd34b8fae77241bd49889d8" forKey:@"key"];
        
        [dic setObject:self.carId forKey:@"id"];
        
        [[NetworkManager shareMgr] server_queryCarDetails:dic completeHandle:^(NSDictionary *response) {
            
            NSLog(@"未初始化的字典:%@",[response objectForKey:@"result"]);
            
            self.arrayOfYear=[[response objectForKey:@"result"] objectForKey:@"List"];
            
            NSLog(@"获得年款字典：%@",[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"]);
            
            [self.myTable reloadData];
            
        }];
    }else if ([self.JudgeWhereFrom isEqualToString:@"color"])
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
    if([self.JudgeWhereFrom isEqualToString:@"name"]){
        return self.arrayOfCarBrand.count;
    }
    else
    {
        return 1;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([self.JudgeWhereFrom isEqualToString:@"name"]){
        
        return 1;
    }
    
    if([self.JudgeWhereFrom isEqualToString:@"series"]){
        
        NSArray *array=[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"];
        NSLog(@"数组个数:%d",array.count);
        return array.count;
    
    }
    else
    {
        return self.array_showArray.count;
    }
    
    
    
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
        cell.lbl_seriesOfCar.text=[self.array_showArray objectAtIndex:indexPath.row];
    }
    else
    {
        cell.imgOfColor.hidden=YES;
    }
    
    if ([self.JudgeWhereFrom isEqualToString:@"series"]) {
        
        //CarSeries* carBrand = [CarSeries objectWithKeyValues:[self.array_showArray objectAtIndex:indexPath.row]] ;
        
        
        NSDictionary *dict=[[[[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"]objectAtIndex:0 ] objectForKey:@"List"] objectAtIndex:0];
        
        cell.lbl_seriesOfCar.text = [dict objectForKey:@"N"];
        
    }else  if([self.JudgeWhereFrom isEqualToString:@"name"]){
    
        
        
        CarBrand* carBrand = [CarBrand objectWithKeyValues:[[self.arrayOfCarBrand objectAtIndex:indexPath.section]objectForKey:@"List"]] ;

        NSDictionary *dic=[[NSDictionary alloc] init];
        NSArray *array=[[NSArray alloc]init];
        
        if ([[[self.arrayOfCarBrand objectAtIndex:indexPath.section]objectForKey:@"List"] isKindOfClass:[NSDictionary class]]) {
            
            NSLog(@"品牌字典:%@",[[self.arrayOfCarBrand objectAtIndex:indexPath.section]objectForKey:@"List"]);
        }
        else if ([[[self.arrayOfCarBrand objectAtIndex:indexPath.section]objectForKey:@"List"] isKindOfClass:[NSArray class]])
        {
            
            array=[[self.arrayOfCarBrand objectAtIndex:indexPath.section]objectForKey:@"List"];
            
            
            cell.lbl_seriesOfCar.text = [[[[array objectAtIndex:0]objectForKey:@"List" ]objectAtIndex:0] objectForKey:@"N"];
        }
    
    }
    //cell.lbl_seriesOfCar.text=[self.array_showArray objectAtIndex:indexPath.row];
        
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* dic;
    
    if ([self.JudgeWhereFrom isEqualToString:@"color"]) {
        
        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[self.array_showArray objectAtIndex:indexPath.row], @"color",nil];
        
        
  
    }else if ([self.JudgeWhereFrom isEqualToString:@"series"]) {
        
        NSDictionary *dict=[[[[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"]objectAtIndex:0 ] objectForKey:@"List"] objectAtIndex:0];

        
        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"N"],@"series", nil];
        
        
    }else  if([self.JudgeWhereFrom isEqualToString:@"name"]){

        
       NSArray *array=[[self.arrayOfCarBrand objectAtIndex:indexPath.section]objectForKey:@"List"];
        
        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[[[array objectAtIndex:0]objectForKey:@"List" ]objectAtIndex:0] objectForKey:@"N"],@"name", nil];
        
        [dic setObject:[[[[array objectAtIndex:0]objectForKey:@"List" ]objectAtIndex:0] objectForKey:@"I"] forKey:@"Id"];
    }
    
    NSLog(@"dic = %@",dic);
    
    [self.delegate handleCarSlect:dic];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
