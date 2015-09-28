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
#import "AddNewCarCtrl.h"

@interface Select_seriesOfCarCtrl ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *arrayOfCarBrand;
@property (nonatomic,strong)NSMutableArray *arrayOfYear;
//@property (nonatomic,strong)NSArray *arrayOfSerie;
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

        [HKCommen addHeadTitle:@"选择品牌" whichNavigation:self.navigationItem];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"4d771c854bd34b8fae77241bd49889d8" forKey:@"key"];
        
        [[NetworkManager shareMgr] server_queryCarLists:dic completeHandle:^(NSDictionary *response) {
            
            NSLog(@"获得字典：%@",response);
            if ([[response objectForKey:@"error_code"] integerValue] == 10012) {
                
                
                
            }else{
            
                NSArray* arrayTemp = [response objectForKey:@"result"];
                
                self.arrayOfCarBrand = [[NSMutableArray alloc] init];
                
                for ( int i = 0 ; i < arrayTemp.count; i ++) {
                    
                    NSDictionary* dicList  = [arrayTemp objectAtIndex:i];
                    
                    NSArray* arrayRealList = dicList[@"List"];
                    
                    for (int i = 0 ; i < arrayRealList.count ; i++) {
                        
                        NSDictionary* dic = [arrayRealList objectAtIndex:i];
                        
                        
                        [self.arrayOfCarBrand addObject:dic];
                        
                    }
                    
                }
                
                [self.myTable reloadData];
            }
            

            
        }];
        
        
    }else if ([self.JudgeWhereFrom isEqualToString:@"series"])
    {
        [HKCommen addHeadTitle:@"年款排量" whichNavigation:self.navigationItem];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"4d771c854bd34b8fae77241bd49889d8" forKey:@"key"];
        
        [dic setObject:self.carId forKey:@"id"];
        
        [[NetworkManager shareMgr] server_queryCarDetails:dic completeHandle:^(NSDictionary *response) {
            
            
            if ([[response objectForKey:@"error_code"] integerValue] == 10012) {
                
                
                
            }else{
            
            NSLog(@"未初始化的字典:%@",[response objectForKey:@"result"]);
            
            NSArray* tempArray =[[response objectForKey:@"result"] objectForKey:@"List"];
                
            self.arrayOfYear = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < tempArray.count; i ++) {
                    
                    NSDictionary* dic = [tempArray objectAtIndex:i];
                    
                    NSArray* array = dic[@"List"];
                    
                    for (int i = 0; i < array.count; i ++) {
                        
                        [self.arrayOfYear addObject:[array objectAtIndex:i]];
                        
                    }
                    
                    
                    
                }
            
            //NSLog(@"获得年款字典：%@",[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"]);
            
            [self.myTable reloadData];
                
            }
        
        }];
    }else if ([self.JudgeWhereFrom isEqualToString:@"color"])
    {
        [HKCommen addHeadTitle:@"选择颜色" whichNavigation:self.navigationItem];
        
        self.array_showArray=[NSArray arrayWithObjects:@"银色",@"黑色",@"白色",@"红色",@"灰色",@"蓝色",@"棕色",@"深蓝色",@"香槟金",@"其他", nil];
        self.array_color=[NSArray arrayWithObjects:@"Silver",@"Black",@"White",@"red",@"Grey",@"blue",@"Brown",@"Navy_Blue",@"Champagne_gold",@"Other", nil];
        
    }else if ([self.JudgeWhereFrom isEqualToString:@"车系"])
    {
        [HKCommen addHeadTitle:@"选择车系" whichNavigation:self.navigationItem];
        
        
    }

    
//    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
//    [rightButton setFrame:CGRectMake(0, 0, 30, 100)];
//    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
//    self.navigationItem.rightBarButtonItem=item;
    
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
    if([self.JudgeWhereFrom isEqualToString:@"车系"]){
        return self.arrayOfSerie.count;
    }
    
    if([self.JudgeWhereFrom isEqualToString:@"series"]){
        return self.arrayOfYear.count;
    }
    
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
    
    if([self.JudgeWhereFrom isEqualToString:@"车系"]){
        
        return 1;
    }
    
    if([self.JudgeWhereFrom isEqualToString:@"name"]){
        
        return 1;
    }
    
    if([self.JudgeWhereFrom isEqualToString:@"series"]){
        
//        NSArray *array=[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"];
//        NSLog(@"数组个数:%d",array.count);
//        return array.count;
        NSArray* array = [[self.arrayOfYear objectAtIndex:section] objectForKey:@"List"];
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
        
        
        NSDictionary *dict=  [[[self.arrayOfYear objectAtIndex:indexPath.section] objectForKey:@"List"] objectAtIndex:indexPath.row];//[[[[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"]objectAtIndex:0 ] objectForKey:@"List"] objectAtIndex:0];
        
        cell.lbl_seriesOfCar.text = [dict objectForKey:@"N"];
        
    }else  if([self.JudgeWhereFrom isEqualToString:@"name"]){
    
        
        NSDictionary* dic = [self.arrayOfCarBrand objectAtIndex:indexPath.section];
        
        cell.lbl_seriesOfCar.text = dic[@"N"];
    
    }else  if([self.JudgeWhereFrom isEqualToString:@"车系"]){
        
        
        NSDictionary* dic = [self.arrayOfSerie objectAtIndex:indexPath.section];
        
        cell.lbl_seriesOfCar.text = dic[@"N"];
        
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
        
        NSDictionary *dict=[[[self.arrayOfYear objectAtIndex:indexPath.section] objectForKey:@"List"] objectAtIndex:indexPath.row];//[[[[[self.arrayOfYear objectAtIndex:0] objectForKey:@"List"]objectAtIndex:0 ] objectForKey:@"List"] objectAtIndex:0];

        
        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"N"],@"series",[[self.arrayOfYear objectAtIndex:indexPath.section] objectForKey:@"I"],@"year", nil];
        
        
    }else  if([self.JudgeWhereFrom isEqualToString:@"name"]){

    
        
        Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
//        vc.carId=self.carId;
        vc.arrayOfSerie = [[self.arrayOfCarBrand objectAtIndex:indexPath.section] objectForKey:@"List"];
        vc.JudgeWhereFrom=@"车系";
        
        vc.delegate = self.delegate;
        vc.preHu = [[self.arrayOfCarBrand objectAtIndex:indexPath.section] objectForKey:@"N"];
        
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else  if([self.JudgeWhereFrom isEqualToString:@"车系"]){
        
        dic =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[self.arrayOfSerie objectAtIndex:indexPath.section],@"车系",self.preHu, @"品牌",nil];
        
    }
    
    NSLog(@"dic = %@",dic);
    
    [self.delegate handleCarSlect:dic];
    
    if([self.JudgeWhereFrom isEqualToString:@"车系"]){
        
        NSArray* array = self.navigationController.childViewControllers;
        
        UIViewController* vc = [array objectAtIndex:0];
        
        for (int i = 0; i < array.count; i ++) {
            
            UIViewController* currentVC = [array objectAtIndex:i];
            
            if ([[currentVC class] isSubclassOfClass:[AddNewCarCtrl class]]) {
                
                vc = currentVC;
                
            }
            
        }

        [self.navigationController popToViewController:vc animated:YES];
        
        return;
//        [self.navigationController popViewControllerAnimated:NO];
//            [self.navigationController popViewControllerAnimated:YES];
        
    }else{
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.JudgeWhereFrom isEqualToString:@"series"])
    {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = [HKCommen getColor:@"aaaaaa"];
    
    UILabel* lblYear = [[UILabel alloc] initWithFrame:CGRectMake(15,5, 200, 20)];
    
    lblYear.textColor = [UIColor whiteColor];
    lblYear.text = [NSString stringWithFormat:@"%@",[[self.arrayOfYear objectAtIndex:section] objectForKey:@"I"]];
    
    [view addSubview:lblYear];
    
    return view;
    }
    
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.JudgeWhereFrom isEqualToString:@"series"])
    {
        return 30;

    }

    return 0;
}

@end
