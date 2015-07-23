//
//  SelfDetailCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SelfDetailCtrl.h"
#import "BannerCell.h"
#import "ShopInfoCell.h"
#import "TimeCell.h"
#import "ServerListCell.h"
#import "CouponSlectedCell.h"
#import "DiscountScoreCell.h"
#import "TotalCountCell.h"
#import "PaymentCell.h"
#import "CommentCell.h"
#import "ServiceCommentinfoCell.h"
#import "PaymentCtrl.h"

@interface SelfDetailCtrl ()

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation SelfDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1){
        
        return 1;
        
    }else if (section == 2){
        
        return 1;
        
    }else if (section == 3){
        
        return 8;
        
    }else if (section == 4){
        
        return 3;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 150;
        
    }else if (indexPath.section == 1){
        
        return 147;
        
    }else if (indexPath.section == 2){
        
        return 44;
        
    }else if(indexPath.section == 3){
        
        if (indexPath.row == 7) {
            
            return 84;
            
        }else if (indexPath.row <=3){
            
            return 34;
        
        }
        
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
    static NSString* cellId3 = @"TimeCell";
    static NSString* cellId4 = @"ServerListCell";
    static NSString* cellId5 = @"CouponSlectedCell";
    static NSString* cellId6 = @"DiscountScoreCell";
    static NSString* cellId7 = @"TotalCountCell";
    static NSString* cellId8 = @"PaymentCell";
    static NSString* cellId9 = @"CommentCell";
    static NSString* cellId10 = @"ServiceCommentinfoCell";
    
    if (indexPath.section == 0) {
        
        BannerCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
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
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        TimeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
            
//            if (indexPath.row == 0) {
            
                UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
                
                divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
                
                [cell.contentView addSubview:divideView];
                
//            }else if (indexPath.row == 2){
                
                UIView* divideView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
                
                divideView1.backgroundColor = [HKCommen getColor:@"cccccc"];
                
                [cell.contentView addSubview:divideView1];
                
//            }
            
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row < 4) {
        
        ServerListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId4];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId4 owner:self options:nil] objectAtIndex:0];
            
            if (indexPath.row == 0) {
            
            UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            divideView.backgroundColor = [HKCommen getColor:@"cccccc"];
            
            [cell.contentView addSubview:divideView];
            
            }
            
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == 4) {
        
        CouponSlectedCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId5];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId5 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == 5) {
        
        DiscountScoreCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId6];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId6 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == 6) {
        
        TotalCountCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId7];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId7 owner:self options:nil] objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == 7) {
        
        PaymentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId8];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId8 owner:self options:nil] objectAtIndex:0];
            
            cell.separatorInset = UIEdgeInsetsZero;
            
            [cell.btnConfirm addTarget:self action:@selector(goToConfirmPage:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
        
    }else if (indexPath.section == 4 && indexPath.row != 0) {
        
        CommentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId6];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId9 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }else if(indexPath.section == 4 && indexPath.row == 0){
        
        
        ServiceCommentinfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId10];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId10 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        
        return 10;
        
    }
    
    return 0 ; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:0xf1/256.0 green:0xf1/256.0 blue:0xf1/256.0 alpha:1.0];
    return headerView;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//    if (indexPath.section == 3 && (indexPath.row >=3 && indexPath.row <=7) ) {
//        NSLog(@"indexPath.row===%d",indexPath.row);
//        cell.separatorInset = UIEdgeInsetsZero;
//    }
//}


#pragma  mark - custom methods
- (void)goToConfirmPage:(UIButton*)btn
{
//    [self performSegueWithIdentifier:@"goToConfirmPage" sender:nil];
        PaymentCtrl *vc=[[PaymentCtrl alloc] initWithNibName:@"PaymentCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
}

@end
