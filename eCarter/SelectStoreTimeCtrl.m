//
//  SelectStoreTimeCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/8/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SelectStoreTimeCtrl.h"
#import "NetworkManager.h"
#import "HKCommen.h"
#import "ProvinceCell.h"

@interface SelectStoreTimeCtrl ()

@property (nonatomic, strong) NSArray* arrayOfRegion;


@end

@implementation SelectStoreTimeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"选择服务时间" whichNavigation:self.navigationItem];
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
    
    [self getModel];
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
//    if (self.arrayTime.count==0) {
//        return 2;
//    }
    return self.arrayTime.count;
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
    NSLog(@"测试row:%@",[self.arrayTime objectAtIndex:indexPath.row]);
    
    NSDictionary *dic=[self.arrayTime objectAtIndex:indexPath.row];
    
    
    cell.lbl_province.text=[NSString stringWithFormat:@"%@ %@至%@",[dic objectForKey:@"servicedate"],[dic objectForKey:@"timeStart"],[dic objectForKey:@"timeEnd"]];
    
    if ([self isExceedNow:dic]) {
        
        cell.lbl_province.textColor = [UIColor blackColor];
        
    }else{
    
        cell.lbl_province.textColor = [HKCommen getColor:@"aaaaaa"];
    
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
    NSDictionary *dic=[self.arrayTime objectAtIndex:indexPath.row];
    
    if (![self isExceedNow:dic]) {
        
        [HKCommen addAlertViewWithTitel:@"无法选择该时间段"];
        
        return;
        
    }
    
    
    ProvinceCell *cell=(ProvinceCell *)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    
    // self.province=cell.lbl_province.text;
    
    
    [self.delegate pickTime:cell.lbl_province.text];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



-(void)getModel
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.shopDetail.id forKey:@"storeId"];
    
    [[NetworkManager shareMgr] server_queryStoreServiceTimeWithDic:dic completeHandle:^(NSDictionary *response) {
        
        self.arrayTime=[response objectForKey:@"data"];
        
        [self.myTable reloadData];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)isExceedNow:(NSDictionary*)dic
{
    if (![[dic class] isSubclassOfClass:[NSDictionary class]]) {
        
        return NO;
        
    }
    
    if ([dic objectForKey:@"servicedate"] == nil || [dic objectForKey:@"timeStart"] == nil) {
        
        return NO;
        
    }
    
    NSString* str = [NSString stringWithFormat:@"%@%@",dic[@"servicedate"],dic[@"timeStart"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-ddHH:mm"];
    
    NSDate* data1 = [dateFormatter dateFromString:str];
    
 //   NSData* data2 = [NSData data];
    
    NSTimeInterval num = [data1 timeIntervalSinceNow];
    
    return num>0?YES:NO;

}

@end
