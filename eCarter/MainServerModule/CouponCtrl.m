//
//  CouponCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "CouponCtrl.h"
#import "CouponExtraInfoCell.h"
#import "CouponMainInfoCell.h"

@interface CouponCtrl()

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* arrayModel;
@property (nonatomic, strong) NSMutableArray* arrayIndex;

@end

@implementation CouponCtrl


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arrayModel = [NSArray arrayWithObjects:@"1",@"2", nil];
    self.arrayIndex = [NSMutableArray arrayWithObjects:@0,@0, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayModel.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSNumber* isExpand = [self.arrayIndex objectAtIndex:section];
    
    if (isExpand.boolValue == YES) {
        
        return 2;
        
    }else{
    
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"CouponMainInfoCell";
    static NSString* cellId2 = @"CouponExtraInfoCell";
    
    if (indexPath.row == 0) {
        
        CouponMainInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
            [cell.btnExpand addTarget:self action:@selector(expandEventHandle:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnExpand.tag = indexPath.section;
            
        }
        
        
        return cell;
        
        
    }else if (indexPath.row == 1){
        
        CouponExtraInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            
        }
        
        
        return cell;
        
    }
    
    
    return nil;
}

- (void)expandEventHandle:(UIButton*)btn
{
    NSInteger index = btn.tag;
    
    NSNumber* isExpand = [self.arrayIndex objectAtIndex:index];
    
    isExpand = [NSNumber numberWithBool:!(isExpand.boolValue)];
    
    [self.arrayIndex replaceObjectAtIndex:index withObject:isExpand];
    
    
    [self.tableView beginUpdates];
    
    if (isExpand.boolValue == YES) {
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:index];
        
        NSArray* array = [NSArray arrayWithObjects:indexPath, nil];
        
        [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [btn setTitle:@"收起" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Coupons_buts_top.png"] forState:UIControlStateNormal];
        
    }else{
    
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:index];
        
        NSArray* array = [NSArray arrayWithObjects:indexPath, nil];
    
        [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [btn setTitle:@"展开" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Coupons_but_more.png"] forState:UIControlStateNormal];
    }
    
    
    [self. tableView endUpdates];
    
}


@end
