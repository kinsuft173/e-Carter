//
//  PamentWaySlectedCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/26.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "PamentWaySlectedCtrl.h"
#import "AliPayCell.h"
#import "TotolPayCell.h"
#import "WeixinPayCell.h"
#import "CountPayCell.h"

@interface PamentWaySlectedCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation PamentWaySlectedCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
        
        return 50;
        
    }else{
        
        return 80;
        
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"TotolPayCell";
    static NSString* cellId2 = @"CountPayCell";
    static NSString* cellId3 = @"AliPayCell";
    static NSString* cellId4 = @"WeixinPayCell";
    
    if (indexPath.row == 0) {
        
        TotolPayCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }else if (indexPath.row == 1){
        
        CountPayCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
        
        
    }else if (indexPath.row == 2){
        
        
        AliPayCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId3 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }else if (indexPath.row == 3){
        
        
        WeixinPayCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId4];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId4 owner:self options:nil] objectAtIndex:0];
            
        }
        
        return cell;
        
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        return;
        
    }else{

        [self performSegueWithIdentifier:@"goPaySuccess" sender:nil];
    }
}


@end
