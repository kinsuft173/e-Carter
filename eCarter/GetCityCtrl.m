//
//  GetCityCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/8/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "GetCityCtrl.h"
#import "HKCommen.h"
#import "ProvinceCell.h"
#import "GetRegionCtrl.h"

@interface GetCityCtrl ()

@end

@implementation GetCityCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HKCommen addHeadTitle:@"选择城市" whichNavigation:self.navigationItem];
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
    return self.arrayOfCity.count;
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
    
    cell.lbl_province.text=[self.arrayOfCity objectAtIndex:indexPath.row];
    return cell;
    
}


- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProvinceCell *cell=(ProvinceCell *)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    
    //self.province=cell.lbl_province.text;
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    for (int i=0; i<self.arrayOfRegion.count; i++) {
        if ([[self.arrayOfRegion objectAtIndex:i] hasPrefix:cell.lbl_province.text]) {
            [array addObject:[self.arrayOfRegion objectAtIndex:i]];
        }
    }
    
    if (array.count==0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAdress" object:cell.lbl_province.text];
        
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3]
                                              animated:YES];
    }
    else
    {
        GetRegionCtrl *vc=[[GetRegionCtrl alloc]initWithNibName:@"GetRegionCtrl" bundle:nil];
        
        vc.arrayOfRegion=array;
        //vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }

    
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
