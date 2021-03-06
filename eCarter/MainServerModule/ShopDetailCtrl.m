//
//  ShopDetailCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ShopDetailCtrl.h"

//detailCell
#import "BannerCell.h"
#import "ShopInfoCell.h"
#import "ServerListCell.h"
#import "TellCell.h"
#import "MapCell.h"
#import "CommentCell.h"
#import "ServiceCommentinfoCell.h"
#import "HKMapManager.h"
#import "HKCommen.h"
#import "ShopDetail.h"
#import "NetworkManager.h"

@interface ShopDetailCtrl ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) ShopDetail* shopDetail;
@property (nonatomic, strong) UIActionSheet *asheet;
@property (assign) BOOL checkService;

@end

@implementation ShopDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
//    }
    self.checkService=NO;
    [HKCommen setExtraCellLineHidden:self.tableView];
    
    [HKCommen addHeadTitle:@"商家详情" whichNavigation:self.navigationItem];
    
    [self addRefresh];
    
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

- (void)addRefresh
{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.preDataShopId,@"storeId", nil];
        
        [[NetworkManager shareMgr] server_queryStoreDetailWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSDictionary* dic = [response objectForKey:@"data"];
            
            if (dic) {
                
                self.shopDetail = [ShopDetail objectWithKeyValues:dic];
                
            }
            
            
            [self.tableView.header endRefreshing];
            
            [self.tableView reloadData];
            
        }];
        
    }];
    
    
    [self.tableView.header beginRefreshing];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.shopDetail) {
        
        return 0;
        
    }
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1){
    
        return 1;
        
    }else if (section == 2){
    
        return self.shopDetail.serviceItemList.count;
        
    }else if (section == 3){
    
        return 2;
    
    }else if (section == 4){
    
        return self.shopDetail.reviewsList.count + 1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 150;
        
    }else if (indexPath.section == 1){
    
        return 148;

    }else if (indexPath.section == 2){
    
        return 34;
        
    }else if(indexPath.section == 3){
    
        return 44;
        
    }else if (indexPath.section == 4){
        
        if (indexPath.row == 0) {
            
            return 40;
            
        }
    
        return 80;
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"BannerCell";
    static NSString* cellId2 = @"ShopInfoCell";
    static NSString* cellId3 = @"ServerListCell";
    static NSString* cellId4 = @"TellCell";
    static NSString* cellId5 = @"MapCell";
    static NSString* cellId6 = @"CommentCell";
    static NSString* cellId7 = @"ServiceCommentinfoCell";
    
    if (indexPath.section == 0) {
        
        BannerCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        [cell.img sd_setImageWithURL:[NSURL URLWithString:self.shopDetail.storeImg]
                    placeholderImage:[UIImage imageNamed:PlaceHolderImage] options:SDWebImageContinueInBackground];
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        ShopInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(10, 85, SCREEN_WIDTH - 10, 0.5)];
            
            divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView];
            
            UIView* divideView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 146.5, SCREEN_WIDTH, 0.5)];
            
            divideView1.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView1];
            
        }
        
        cell.lblAddress.text = self.shopDetail.address;
        cell.lblDistance.text = [NSString stringWithFormat:@"%.1fkm",[self.shopDetail.distance floatValue]];
        cell.lblStoreName.text = self.shopDetail.storeName;
        cell.lblStoreScore.text = [NSString stringWithFormat:@"(%.1f)",[self.shopDetail.storeScore floatValue]];
        cell.lblTimeStartAndEnd.text = [NSString stringWithFormat:@"营业时间:%@ - %@",self.shopDetail.startBusinessTime,self.shopDetail.endBusinessTime];
        [cell.star setStarForValue:[self.shopDetail.storeScore floatValue]];

        
        NSString* strServerItems = @"";
        for (int i = 0; i < self.shopDetail.serviceItemList.count; i++ ) {
            
            Serviceitemlist* item = [self.shopDetail.serviceItemList objectAtIndex:i];
            
            if (i == 0) {
                
                strServerItems = [strServerItems stringByAppendingString:[NSString stringWithFormat:@"%@",item.serviceItemName]];
                
            }else{
            
                strServerItems = [strServerItems stringByAppendingString:[NSString stringWithFormat:@"/%@",item.serviceItemName]];
            
            }
            
            
        }
        
        cell.lblServerItems.text = strServerItems;
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        ServerListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
            
            if (indexPath.row == 0) {
                
                UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
                
                divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
                
                [cell.contentView addSubview:divideView];
                
            }else if (indexPath.row == (self.shopDetail.serviceItemList.count -1)){
            
                UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 33.5, SCREEN_WIDTH, 0.5)];
                
                divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
                
                [cell.contentView addSubview:divideView];
            
            }
            
            
            Serviceitemlist* item = [self.shopDetail.serviceItemList objectAtIndex:indexPath.row];
            
            cell.img_Button.hidden = YES;
            cell.lblServerPrice.text = [NSString stringWithFormat:@"¥%@",item.amount];
            cell.lblSeverName.text = item.serviceItemName;
            
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == 0) {
        
        TellCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId4];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId4 owner:self options:nil] objectAtIndex:0];
            
            UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView];
            
        }
        
        cell.lblPhone.text = self.shopDetail.mobile;
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == 1) {
        
        MapCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId5];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId5 owner:self options:nil] objectAtIndex:0];
            
            UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
            
            divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView];
            
        }
        
        cell.lblAdress.text = self.shopDetail.address;
        
        return cell;
        
    }else if (indexPath.section == 4 && indexPath.row != 0) {
        
        CommentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId6];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId6 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }else if(indexPath.section == 4 && indexPath.row == 0){
    
    
        ServiceCommentinfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId7];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId7 owner:self options:nil] objectAtIndex:0];
            
            UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView];
            
        }
        
        return cell;
    
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        
        return 0;
        
    }
    
    return 10 ; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:0xf1/256.0 green:0xf1/256.0 blue:0xf1/256.0 alpha:1.0];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3 && indexPath.row == 1) {
        
        CLLocationCoordinate2D startPoint ;
        startPoint.latitude = [HKMapManager shareMgr].currentLocation.coordinate.latitude;
        startPoint.longitude = [HKMapManager shareMgr].currentLocation.coordinate.longitude;
        //    self.startCoordinate = point ;
        
        CLLocationCoordinate2D desPoint ;
        desPoint.latitude =   23.137888;
        desPoint.longitude = 113.329231;
        //    self.destinationCoordinate = pointD ;
        
        if (![[HKMapManager shareMgr] openAMAPWihStartCoordinate:startPoint AndEndCoordinate:desPoint]) {
            
            [[HKMapManager shareMgr] openAPPLEMAPWihStartCoordinate:startPoint AndEndCoordinate:desPoint];
            
        }
        
    }
    else if (indexPath.section==2)
    {
        ServerListCell *cell=(ServerListCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:2]];
        
        if (self.checkService) {
            [cell.img_Button setImage:[UIImage imageNamed:@"but_checked"]];

        }
        else
        {
            [cell.img_Button setImage:[UIImage imageNamed:@"but_Unchecked"]];
            
        }
        self.checkService=!self.checkService;
    }
    
    else if (indexPath.section == 3 && indexPath.row == 0){
    
        
        self.asheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:[NSString stringWithFormat:@"致电 %@",self.shopDetail.mobile], nil];
        
        //sheet.tag = 300;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            
            [self.asheet showInView:self.view];
            
        }else{
            
            [self.asheet showFromRect:CGRectMake(600, 0, 100, 80) inView:self.view animated:YES];
        
        }
    
    
    }


}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet == self.asheet) {
        
        switch (buttonIndex)
        {
                
            case 0:
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.shopDetail.mobile]]];
                
                break;
                
            case 1:
                
                break;
        }
    }
    
    return;
    
}



@end
