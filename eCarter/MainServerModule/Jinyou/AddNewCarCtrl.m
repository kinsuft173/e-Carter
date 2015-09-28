//
//  AddNewCarCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "AddNewCarCtrl.h"
#import "CarNumCell.h"
#import "SelectCarCell.h"
#import "CarDetailCell.h"
#import "ButtonCell.h"
#import "HKCommen.h"
#import "SvGridView.h"
#import "MBProgressHUD.h"
#import "UserDataManager.h"
#import "NetworkManager.h"
#import "SelectProvinceCtrl.h"
#import "HKMapManager.h"


@interface AddNewCarCtrl ()<UITableViewDataSource,UITableViewDelegate,carSelect>

@property BOOL isFirstLoad;

@property (nonatomic, strong) NSArray* arrayOfProvince;
@property (nonatomic, strong) NSArray* arrayOfProvinceFullName;

@property int  index;

@end

@implementation AddNewCarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.arrayOfProvince=[NSArray arrayWithObjects:@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"黔",@"滇",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳",@"台", nil];
    
    self.arrayOfProvinceFullName=[NSArray arrayWithObjects:@"北京市",@"天津市",@"河北省",@"山西省",@"内蒙古自治区",@"辽宁省",@"吉林省",@"黑龙江省",@"上海市",@"江苏省",@"浙江省",@"安徽省",@"福建省",@"江西省",@"山东省",@"河南省",@"湖北省",@"湖南省",@"广东省",@"广西壮族自治区",@"海南省",@"重庆市",@"四川省",@"贵州省",@"云南省",@"西藏自治区",@"陕西省",@"甘肃省",@"青海省",@"宁夏回族自治区",@"新疆维吾尔自治区",@"香港特别行政区",@"澳门特别行政区",@"台湾省", nil];
    
    self.index = 0;
    
    for (int i = 0; i < self.arrayOfProvinceFullName.count; i ++) {
        
        NSString* str = [self.arrayOfProvinceFullName objectAtIndex:i];
        
        if ([str isEqualToString:[HKMapManager shareMgr].strProvince]) {
            
            _index = i;
            
            break;
            
        }
        
    }
    
    NSString* strTitel = @"新增车辆";
    
    if (self.preCar) {
        
        strTitel = @"编辑车辆";
    }
    
    [HKCommen addHeadTitle:strTitel whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    self.arrayOfCar=[NSArray arrayWithObjects:@"请选择品牌／车系",@"请选择年款／排量",@"请选择颜色", nil];
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
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 40)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [rightButton addTarget:self action:@selector(goCommit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
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
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        return 44;
    }
    else if (indexPath.section==1)
    {
        return 44;
    }
    else if (indexPath.section==2)
    {
        return 133;
    }
    return 0;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId1 = @"CarNumCell";
    NSString* cellId2 = @"SelectCarCell";
    NSString* cellId3 = @"CarDetailCell";
    NSString* cellId4 = @"ButtonCell";
    
    if (indexPath.section == 0) {
        
        CarNumCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
            
        }
        [cell.btn_selectProvince addTarget:self action:@selector(goSelectProvince) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
        
    }
    
    else  if(indexPath.section==1){
        
        SelectCarCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
        }
        cell.lbl_KindOfCar.text=[self.arrayOfCar objectAtIndex:indexPath.row];

        return cell;
        
    }
    else  if(indexPath.section==2){
        
        CarDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
        }
        
        return cell;
        
    }

    
    return nil;
    
}

-(void)goSelectProvince
{
    SelectProvinceCtrl *vc=[[SelectProvinceCtrl alloc] initWithNibName:@"SelectProvinceCtrl" bundle:nil];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pickCarProvince:(NSString*)string
{
    CarNumCell *cell=(CarNumCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.lblCarNo.text=string;
    [self.myTable reloadData];
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section==1||section==2) {
        return 12.0;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            vc.JudgeWhereFrom=@"name";
            
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else if (indexPath.row==1) {
            
            if (!self.carId) {
                
                [HKCommen addAlertViewWithTitel:@"请先选择品牌/车系"];
                
                return;
                
            }
            
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            vc.carId=self.carId;
            vc.JudgeWhereFrom=@"series";
            
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        else if (indexPath.row==2) {
            Select_seriesOfCarCtrl *vc=[[Select_seriesOfCarCtrl alloc] initWithNibName:@"Select_seriesOfCarCtrl" bundle:nil];
            
            vc.JudgeWhereFrom=@"color";
            
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.index > -1){
        
        CarNumCell* cellCarNo = (CarNumCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        cellCarNo.lblCarNo.text = [self.arrayOfProvince objectAtIndex:self.index];
        
        self.index = -2;
        
    }
    
    
    if (self.preCar) {
        
        if (self.isFirstLoad == YES) {
            
            return;
            
        }else{
            
            CarNumCell* cellCarNo = (CarNumCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            cellCarNo.lblCarNo.text = [self.preCar.no substringToIndex:1];
            
            cellCarNo.textFiledCarNo.text = [self.preCar.no substringFromIndex:1];
            
            //车系
            
            SelectCarCell* cellSelectCar1 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            
            cellSelectCar1.lbl_KindOfCar.text = self.preCar.brand;
            
            //排量
            
            SelectCarCell* cellSelectCar2 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
            
            cellSelectCar2.lbl_KindOfCar.text = self.preCar.model;
            
            //颜色
            
            SelectCarCell* cellSelectCar3 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
            
            cellSelectCar3.lbl_KindOfCar.text = self.preCar.color;
            
            
           //发动机号
            CarDetailCell* cellCarDetail = (CarDetailCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
            
            cellCarDetail.textFiledFadongji.text = self.preCar.engineNo;
            cellCarDetail.textFiledChejia.text = self.preCar.frameNo;
            
            self.isFirstLoad = YES;
            
            self.carYear  = self.preCar.year;
        
        }
        

    }
    
    

}


- (void)goCommit:(UIButton*)sender
{

    
    
    CarNumCell* cellCarNo = (CarNumCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    NSString* strCarNo = [NSString stringWithFormat:@"%@%@",cellCarNo.lblCarNo.text,cellCarNo.textFiledCarNo.text];
    
    //车系
    
    SelectCarCell* cellSelectCar1 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    NSString* strSelectCar1 = cellSelectCar1.lbl_KindOfCar.text;
    
    //排量
    
    SelectCarCell* cellSelectCar2 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    NSString* strSelectCar2 = cellSelectCar2.lbl_KindOfCar.text;
    
    //颜色
    
    SelectCarCell* cellSelectCar3 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    
    NSString* strSelectCar3 = cellSelectCar3.lbl_KindOfCar.text;
    
    
    CarDetailCell* cellCarDetail = (CarDetailCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    
    NSString* strFadongji = cellCarDetail.textFiledFadongji.text;
    NSString* strChejia   = cellCarDetail.textFiledChejia.text;
    
    if (![HKCommen validateCarNo:cellCarNo.textFiledCarNo.text]) {
        
        [HKCommen addAlertViewWithTitel:@"请输入正确的车牌号"];
     
        return;
        
    }else if ([strSelectCar1 isEqualToString:[self.arrayOfCar objectAtIndex:0]]){
    
        [HKCommen addAlertViewWithTitel:@"请选择车系"];
        
        return;
    
    }else if ([strSelectCar2 isEqualToString:[self.arrayOfCar objectAtIndex:1]]){
        
        [HKCommen addAlertViewWithTitel:@"请选择车款"];
        
        return;
        
    }else if ([strSelectCar3 isEqualToString:[self.arrayOfCar objectAtIndex:2]]){
        
        [HKCommen addAlertViewWithTitel:@"请选择颜色"];
        
        return;
        
    }
    
    if (!([strFadongji isEqualToString:@""] || [strFadongji isEqualToString:@"发动机后六位"] || strFadongji == nil )) {
        
        if (![HKCommen validateSixNumber:strFadongji]) {
            
            [HKCommen addAlertViewWithTitel:@"格式不正确,请输入发动机号后六位"];

            return;
        }
        
    }
    
    if (!([strChejia isEqualToString:@""] || [strChejia isEqualToString:@"车架号的后六位"] || strChejia == nil )) {
        
        if (![HKCommen validateSixNumber:strChejia]) {
            
            [HKCommen addAlertViewWithTitel:@"格式不正确,请输入车架号的后六位"];
            
            return;
        }
        
    }
    
//    else if (![HKCommen validateSixNumber:strFadongji]){
//    
//        [HKCommen addAlertViewWithTitel:@"请输入发动机号后六位"];
//        
//        return;
//    
//    
//    }else if (![HKCommen validateSixNumber:strChejia]){
//        
//        [HKCommen addAlertViewWithTitel:@"请输入车架号后六位"];
//        
//        return;
//        
//        
//    }

    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:[NSString stringWithFormat:@"%@%@",cellCarNo.lblCarNo.text,cellCarNo.textFiledCarNo.text] forKey:@"no"];
    [dic setObject:strSelectCar1 forKey:@"brand"];
    [dic setObject:strSelectCar2 forKey:@"model"];
    [dic setObject:self.carYear forKey:@"year"];
     [dic setObject:strSelectCar3 forKey:@"color"];
     [dic setObject:strSelectCar2 forKey:@"volume"];
    
    if (!([strFadongji isEqualToString:@""] || [strFadongji isEqualToString:@"发动机后六位"] || strFadongji == nil )) {
        
        [dic setObject:strFadongji forKey:@"engineNo"];
        
    }
    
    if (!([strChejia isEqualToString:@""] || [strChejia isEqualToString:@"车架号的后六位"] || strChejia == nil )) {
        

        [dic setObject:strChejia forKey:@"frameNo"];
    }

    
    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    
    if (self.preCar) {
        
        [dic setObject:[NSString stringWithFormat:@"%d",self.preCar.id] forKey:@"id"];
        
        [[NetworkManager shareMgr] server_editCarWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            
            NSString* messege = [response objectForKey:@"message"];
            
            
            if ([messege isEqualToString:@"OK"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCarOrAddress" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            hud.hidden = YES;
            
            
        }];
        
    }else{
        
        [[NetworkManager shareMgr] server_addCarWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            
            NSString* messege = [response objectForKey:@"message"];
            
            
            if ([messege isEqualToString:@"OK"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCarOrAddress" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            hud.hidden = YES;
        
            
        }];
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    

    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0 - SINGLE_LINE_ADJUST_OFFSET, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
    headView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    UIView *underView=[[UIView alloc]initWithFrame:CGRectMake(0, 12.0 - SINGLE_LINE_ADJUST_OFFSET, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
    underView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    [headerView addSubview:headView];
    [headerView addSubview:underView];
    return headerView;
}


- (void)handleCarSlect:(NSDictionary *)dic
{
    NSLog(@"handleCarSlect = %@",dic);
    //车系
    SelectCarCell* cellSelectCar1 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    //排量
    SelectCarCell* cellSelectCar2 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    //颜色
    SelectCarCell* cellSelectCar3 = (SelectCarCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    
    
    if ([dic objectForKey:@"name"]) {
        
        cellSelectCar1.lbl_KindOfCar.text = [dic objectForKey:@"name"];
        cellSelectCar2.lbl_KindOfCar.text = [self.arrayOfCar objectAtIndex:1];
        
        NSLog(@"收到的ID是:%@",[dic objectForKey:@"Id"]);
        self.carId=[dic objectForKey:@"Id"];
        
    }else if ([dic objectForKey:@"series"]) {
        
        cellSelectCar2.lbl_KindOfCar.text = [dic objectForKey:@"series"];
        self.carYear = [dic objectForKey:@"year"];
    
        
    }else if ([dic objectForKey:@"color"]) {
        
        cellSelectCar3.lbl_KindOfCar.text = [dic objectForKey:@"color"];
        
    }else if([dic objectForKey:@"车系"]){
        
        NSLog(@"dic = %@",dic);
    
        cellSelectCar1.lbl_KindOfCar.text = [[dic objectForKey:@"车系"] objectForKey:@"N"];
        cellSelectCar2.lbl_KindOfCar.text = [self.arrayOfCar objectAtIndex:1];
       self.carId =  [[dic objectForKey:@"车系"] objectForKey:@"I"];
        
        NSLog(@"self.carId  = %@",self.carId );
    }


}




@end







