//
//  MyAdressCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyAdressCtrl.h"
#import "AdressCell.h"
#import "AddAdressCell.h"
#import "HKCommen.h"

@interface MyAdressCtrl ()

@property (nonatomic, strong) NSMutableArray* arrayModel;
@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation MyAdressCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary* dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"广州市天河区黄村高德汇11号",@"家庭地址",nil];
    NSDictionary* dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"广州市天河区黄村高德汇11号",@"家庭地址",nil];
    NSDictionary* dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"广州市天河区黄村高德汇11号",@"家庭地址",nil];
    
    self.arrayModel = [NSMutableArray arrayWithObjects:dic1,dic2,dic3, nil];
    
    [HKCommen setExtraCellLineHidden:self.tableView];
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
        
        return self.arrayModel.count;
        
    }else{
        
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 44;
        
    }else{
        
        return 68;
        
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"AdressCell";
    static NSString* cellId2 = @"AddAdressCell";
//    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if(indexPath.section == 0){
        
        AdressCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
        }
        
        cell.lblAdressTitel.text = [[[self.arrayModel objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
        cell.lblAdressContent.text = [[[self.arrayModel objectAtIndex:indexPath.row] allObjects] objectAtIndex:0];
        
        return cell;
        
        
    }else{
        
        AddAdressCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId2 owner:self options:nil] objectAtIndex:0];
            cell.delegate=self;
            
        }
        
        return cell;
        
    }
}

-(void)EditMyAdress
{
    AddNewAdress *vc=[[AddNewAdress alloc] initWithNibName:@"AddNewAdress" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
