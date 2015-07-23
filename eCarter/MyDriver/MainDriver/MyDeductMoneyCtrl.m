//
//  MyDeductMoneyCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/3.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyDeductMoneyCtrl.h"
#import "HKCommen.h"

@interface MyDeductMoneyCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *dataOfDeductOrder;
@end

@implementation MyDeductMoneyCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HKCommen setExtraCellLineHidden:self.myTable];

    self.dataOfDeductOrder=[NSArray arrayWithObjects:@"100",@"160",@"160", nil];
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    title.text=@"我的提成";
    [title setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView * )tableView
 numberOfRowsInSection:(NSInteger)section
{
    
    
    return 1;
}

- (UITableViewCell * )tableView:(UITableView * )tableView cellForRowAtIndexPath:(NSIndexPath * )indexPath
{
   
        static NSString *deductMoneyCell=@"DeductMoneyCell";
        DeductMoneyCell *cell=[tableView dequeueReusableCellWithIdentifier:deductMoneyCell];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:deductMoneyCell owner:self options:nil][0];
        }
    ;
    cell.lbl_SumOfOrder.text=[NSString stringWithFormat:@"订单总数（笔） %@",[self.dataOfDeductOrder objectAtIndex:0]];
    
    cell.lbl_EachOfOrder.text=[NSString stringWithFormat:@"每笔提成（元） %@",[self.dataOfDeductOrder objectAtIndex:1]];
    
    cell.lbl_SumOfDeduct.text=[NSString stringWithFormat:@"总提成（元）  %@",[self.dataOfDeductOrder objectAtIndex:2]];
    
        return cell;

    
}

- (CGFloat)tableView:(UITableView * )tableView
heightForRowAtIndexPath:(NSIndexPath * )indexPath
{
    
    return 134.0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}



@end
