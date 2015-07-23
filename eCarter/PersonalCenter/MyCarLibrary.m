//
//  MyCarLibrary.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyCarLibrary.h"
#import "AddCarCell.h"
#import "CarInfoCell.h"
#import "PlaceHolderCell.h"
#import "HKCommen.h"


@interface MyCarLibrary ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyCarLibrary

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen addHeadTitle:@"我的车库" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else{
    
        return 4;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 44;
        
    }else if(indexPath.row % 2 == 0){
        
        return 12;
        
    }else{
    
        return 165;
    
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"AddCarCell";
    static NSString* cellId2 = @"CarInfoCell";
    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.row % 2 == 0 && indexPath.section != 0) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            cell.contentView.backgroundColor = [HKCommen  getColor:@"f1f1f1" WithAlpha:1.0];
            
        }
        
        return cell;
        
        
    }else if(indexPath.section == 0){
        
        AddCarCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
        
    }else if(indexPath.row % 2 != 0){
    
        CarInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
    
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
      
            AddNewCarCtrl *vc=[[AddNewCarCtrl alloc] initWithNibName:@"AddNewCarCtrl" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }


@end
