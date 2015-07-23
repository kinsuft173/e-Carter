//
//  EventBanerCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "EventBanerCtrl.h"
#import "EventInfoCell.h"
#import "EventBannerCell.h"
#import "HKWebViewCtrl.h"
#import "global.h"

@interface EventBanerCtrl ()

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* arrayBanners;

@end

@implementation EventBanerCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arrayBanners = [NSArray arrayWithObjects:@"1",@"2", nil];
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
    return 2;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.arrayBanners.count;
        
    }else{
        
        return 1;
    
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 200;
        
    }else if(indexPath.section == 1){
        
        return 200;
        
    }
    return 0;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"EventBannerCell";
    static NSString* cellId2 = @"EventInfoCell";
    
    if (indexPath.section == 0) {
        
        EventBannerCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
            
            
        }
        
        
        return cell;
        
        
    }else if (indexPath.section == 1){
        
        EventInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            
            
            [cell.btnGoWebsite addTarget:self action:@selector(goWeb:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        return cell;
        
    }
    
    
    return nil;
}

- (void)goWeb:(UIButton*)btn
{
    HKWebViewCtrl* vc = [[HKWebViewCtrl alloc] initWithNibName:@"HKWebViewCtrl" bundle:nil];
    
    vc.strUrl = BannerInfoWebUrl;
    
    vc.navigationItem.title = @"活动详情";
    
    [self.navigationController pushViewController:vc animated:YES];

}


@end
