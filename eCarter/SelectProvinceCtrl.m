//
//  SelectProvinceCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/8/18.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SelectProvinceCtrl.h"
#import "ProvinceCell.h"
#import "HKCommen.h"


@interface SelectProvinceCtrl ()
@property (nonatomic,strong) NSArray *arrayOfProvince;
@end

@implementation SelectProvinceCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.arrayOfProvince=[NSArray arrayWithObjects:@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"黔",@"滇",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳",@"台", nil];
    
    [HKCommen addHeadTitle:@"选择省份" whichNavigation:self.navigationItem];
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
    return self.arrayOfProvince.count;
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
    
    cell.lbl_province.text=[self.arrayOfProvince objectAtIndex:indexPath.row];
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
    
    [self.delegate pickCarProvince:cell.lbl_province.text];
    [self.navigationController popViewControllerAnimated:YES];
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
