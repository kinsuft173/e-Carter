//
//  MyOrderCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MyOrderCtrl.h"
#import "OrderCell.h"
#import "PlaceHolderCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "CommentCtrl.h"
#import "MoneyReturnDetailCtrl.h"
#import "OrderDetail.h"

@interface MyOrderCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property NSInteger numOfSelected;

@property (nonatomic, strong) UIView* slideView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIView* selectView;
@property (nonatomic, strong) NSArray* arrayAllOrder;
@property (nonatomic, strong) NSMutableArray* arrayOrderWaitConfirm;
@property (nonatomic, strong) NSMutableArray* arrayOrderProcessing;
@property (nonatomic, strong) NSMutableArray* arrayOrderFinished;
@property (nonatomic, strong) NSMutableArray* arrayOrderAbort;
@property (nonatomic,strong) OrderDetail *myOrder;

@end

@implementation MyOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen addHeadTitle:@"我的订单" whichNavigation:self.navigationItem];
    
    [self initScrollTables:5];
    
    //[self getModel];
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

- (void)getModel
{
    
    [[NetworkManager shareMgr] server_loginWithDic:nil completeHandle:^(NSDictionary *response) {
        
        NSLog(@"订单字典：%@",response);
        NSArray* arrayTemp = [response objectForKey:@"data"];
        
        if (arrayTemp.count != 0) {
            
            self.arrayAllOrder = arrayTemp;
            
            for (int i = 0 ; i < arrayTemp.count; i ++) {
                
                //test
            }
        }
        
        [self.tableView  reloadData];
        
    }];
    
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


- (void)initScrollTables:(NSInteger)tableCount
{
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*tableCount, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.hidden = YES;
    
    for (int i = 0; i < tableCount ; i ++) {
        
        UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH,SCREEN_HEIGHT-64 - 44) style:UITableViewStylePlain];
        
        tableView.tag = i;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.view addSubview:tableView];
        
        if (tableView.tag != 0) {
            
            tableView.hidden = YES;
            
        }
        
        
        [HKCommen setExtraCellLineHidden:tableView];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        NSArray* array = [NSArray arrayWithObjects:@"全部",@"待服务",@"服务中",@"已完成",@"已取消", nil];
        
        UIButton* btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake( (SCREEN_WIDTH/tableCount)*i, 0, SCREEN_WIDTH/tableCount, 44);
        //        btn.backgroundColor = [UIColor blueColor];
        btn.tag = i;
        
        btn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        
        
        
        if (i != 0) {
            
            [btn setTitleColor:[HKCommen getColor:@"999999"]  forState:UIControlStateNormal];
            
        }else{
            
            [btn setTitleColor:[HKCommen getColor:@"68beef"] forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(jumpToTable:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.selectView addSubview:btn];
    }
    
    UIView* divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
    divideView.backgroundColor = [HKCommen getColor:@"aaaaaa" WithAlpha:0.5];
    
    [self.selectView addSubview:divideView];
    
    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH/tableCount, 2)];
    self.slideView.backgroundColor = [HKCommen getColor:@"68beef"];
    
    [self.selectView addSubview:self.slideView];
    
    
}


- (void)jumpToTable:(UIButton*)btn
{
    NSInteger index = btn.tag;
    
    for (UITableView* table in [self.view  subviews]) {
        
        if (![[table class] isSubclassOfClass:[UITableView class]]) {
            
            continue;
        }
        
        if (table.tag == index) {
            
            table.hidden = NO;
            
        }else{
            
            table.hidden = YES;
        }
        
    }
    
    
    for (UIButton* btn  in [self.selectView subviews]) {
        
        if (![[btn class] isSubclassOfClass:[UIButton class]] ) {
            
            continue;
        }
        
        
        if (btn.tag == index) {
            
            [btn setTitleColor:[HKCommen getColor:@"68beef"] forState:UIControlStateNormal];
            
        }else{
            
            [btn setTitleColor:[HKCommen getColor:@"999999"] forState:UIControlStateNormal];
            
        }
        
        
    }
    
    [UIView beginAnimations:@"slider" context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.slideView.frame = CGRectMake(btn.tag*(SCREEN_WIDTH/5), 42, SCREEN_WIDTH/5, 2);
    
    
    [UIView commitAnimations];
    
    //    [self.scrollView scrollRectToVisible:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) animated:YES];
}




#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 5;
        
    }else if(indexPath.row%2 == 0){
        
        return 284;
        
    }else{
        
        return 394;
        
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"OrderCell";
    static NSString* cellHolderId = @"PlaceHolderCell";
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.row == 0) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            cell.contentView.backgroundColor = [HKCommen  getColor:@"aaaaaa" WithAlpha:0.2];
            
        }
        
        return cell;
        
        
    }else if(indexPath.row%2 == 0){
        
        OrderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:0];
            
            UIView* viewDivide1 = [[UIView alloc] initWithFrame:CGRectMake(0, 35 , SCREEN_WIDTH, 0.5)];
            UIView* viewDivide2 = [[UIView alloc] initWithFrame:CGRectMake(10, 170 , SCREEN_WIDTH - 10, 0.5)];
            UIView* viewDivide3 = [[UIView alloc] initWithFrame:CGRectMake(0, 230, SCREEN_WIDTH, 0.5)];
            
            viewDivide1.backgroundColor = [HKCommen getColor:@"ccccccc"];
            viewDivide2.backgroundColor = [HKCommen getColor:@"e0e0e0"];
            viewDivide3.backgroundColor = [HKCommen getColor:@"ccccccc"];
            
            
            [cell.viewMask1 addSubview:viewDivide1];
            [cell.viewMask1 addSubview:viewDivide2];
            [cell.viewMask1 addSubview:viewDivide3];
        }
        
        cell.judgeWhichStatus=0;
        if (cell.judgeWhichStatus==0) {
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"待评价" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goCommentPage) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (cell.judgeWhichStatus==1)
        {
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"退款详情" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goMoneyReturnPage) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.btnGoCommentPage.hidden=YES;
        }
        
        return cell;
        
    }else{
        
        OrderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil] objectAtIndex:1];
            
            UIView* viewDivide1 = [[UIView alloc] initWithFrame:CGRectMake(0, 35 , SCREEN_WIDTH, 0.5)];
            UIView* viewDivide2 = [[UIView alloc] initWithFrame:CGRectMake(10, 170 , SCREEN_WIDTH - 10, 0.5)];
            UIView* viewDivide3 = [[UIView alloc] initWithFrame:CGRectMake(0, 230, SCREEN_WIDTH, 0.5)];
            UIView* viewDivide4 = [[UIView alloc] initWithFrame:CGRectMake(0, 340, SCREEN_WIDTH, 0.5)];
            
            viewDivide1.backgroundColor = [HKCommen getColor:@"ccccccc"];
            viewDivide2.backgroundColor = [HKCommen getColor:@"e0e0e0"];
            viewDivide3.backgroundColor = [HKCommen getColor:@"ccccccc"];
            viewDivide4.backgroundColor = [HKCommen getColor:@"ccccccc"];
            
            [cell.viewMask1 addSubview:viewDivide1];
            [cell.viewMask1 addSubview:viewDivide2];
            [cell.viewMask1 addSubview:viewDivide3];
            [cell.viewMask1 addSubview:viewDivide4];
        }
        
        cell.judgeWhichStatus = 1;
        
        if (cell.judgeWhichStatus==0) {
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"待评价" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goCommentPage) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (cell.judgeWhichStatus==1)
        {
            NSLog(@"hehhe");
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"退款详情" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goMoneyReturnPage) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.btnGoCommentPage.hidden=YES;
        }
        
        
        
        return cell;
    }
}

-(void)goCommentPage
{
    CommentCtrl *vc=[[CommentCtrl alloc]initWithNibName:@"CommentCtrl" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)goMoneyReturnPage
{
    MoneyReturnDetailCtrl *vc=[[MoneyReturnDetailCtrl alloc]initWithNibName:@"MoneyReturnDetailCtrl" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
