//
//  MyTradeCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/29.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyTradeCtrl.h"
#import "CustomTradeCell.h"
#import "HKCommen.h"
#import "PlaceHolderCell.h"

@interface MyTradeCtrl ()

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation MyTradeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [HKCommen getColor:@"aaaaaa" WithAlpha:0.2];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 5;
        
    }else if (indexPath.row == 3){
    
        return 97;
    
    }
    
    return 167;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"CustomTradeCell";
    static NSString* cellId2 = @"PlaceHolderCell";
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if(indexPath.row  == 1 || indexPath.row == 2){
        
        CustomTradeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }else if(indexPath.row == 3){
        
        CustomTradeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:1];
            
        }
        
        return cell;
        
    }else{
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            cell.contentView.backgroundColor = [HKCommen  getColor:@"aaaaaa" WithAlpha:0.2];
        }
        
        return cell;
        
    }
    
    //    return nil;
}


@end
