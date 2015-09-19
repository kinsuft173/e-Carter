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
#import "UserDataManager.h"
#import "PhotoBroswerVC.h"
#import "SIAlertView.h"
#import "OrderSingle.h"
#import "ConsulationManager.h"
#import "NewCommentCtrl.h"
//#import "Shop.h"
#import "ShopDetailCtrl.h"

@interface MyOrderCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property NSInteger numOfSelected;

@property (nonatomic, strong) UIView* slideView;
//@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIView* selectView;
@property (nonatomic, strong) NSArray* arrayAllOrder;
@property (nonatomic, strong) NSMutableArray* arrayOrderWaitConfirm;
@property (nonatomic, strong) NSMutableArray* arrayOrderProcessing;
@property (nonatomic, strong) NSMutableArray* arrayOrderFinished;
@property (nonatomic, strong) NSMutableArray* arrayOrderAbort;
@property (nonatomic,strong) OrderDetail *myOrder;
@property (nonatomic, strong) UserLoginInfo* userLoginInfo;
@property (nonatomic,strong) NSMutableArray *arrayOfOrder;
@property (nonatomic,strong) NSMutableArray *arrayOfTables;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *networkImages;
@property (nonatomic,strong)NSMutableArray *arrayOfState;

@property (nonatomic,strong)NSMutableArray *arrayOfWaiting;
@property (nonatomic,strong)NSMutableArray *arrayOfServicing;
@property (nonatomic,strong)NSMutableArray *arrayOfComplete;
@property (nonatomic,strong)NSMutableArray *arrayOfCancel;

@property (nonatomic,strong)NSMutableArray *arrayOfShow;
@property     NSInteger index;
@property     BOOL isAnimations;
@end

@implementation MyOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HKCommen addHeadTitle:@"我的订单" whichNavigation:self.navigationItem];
    
    self.arrayOfOrder=[[NSMutableArray alloc] init];
    self.arrayOfTables=[[NSMutableArray alloc]init];
    self.networkImages=[[NSMutableArray alloc]init];
    
    self.arrayOfWaiting=[[NSMutableArray alloc]init];
    self.arrayOfServicing=[[NSMutableArray alloc]init];
    self.arrayOfComplete=[[NSMutableArray alloc]init];
    self.arrayOfCancel=[[NSMutableArray alloc]init];

    self.arrayOfShow=[[NSMutableArray alloc]init];

    
    [self getModel];
    [self initScrollTables:5];
    
    UIPanGestureRecognizer* swipeGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
//    swipeGes.direction = UISwipeGestureRecognizerDirectionLeft;
//    swipeGes.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:swipeGes];
    
    UIPanGestureRecognizer* swipeGes1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
//    swipeGes1.direction = UISwipeGestureRecognizerDirectionRight;
//    swipeGes1.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:swipeGes1];
    
//
//    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setFrame:CGRectMake(0, 0, 40, 40)];
//    [leftButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
//    
//    
//    
//    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                           target:nil action:nil];
//        negativeSpacer.width = -17;
//        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
//    }else
//    {
//        self.navigationItem.leftBarButtonItem=leftItem;
//    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableMy) name:@"reloadOrder" object:nil];
}

- (void)swipeLeft:(UIPanGestureRecognizer*)ges
{
    CGPoint point = [ges translationInView:self.view];
    NSLog(@"%f,%f",point.x,point.y);
    
    if (point.x > 50) {
        
        if (self.isAnimations == NO) {
            
            if (self.index == 0) {
                
                return;
                
            }else{
                
                UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                btn.tag = self.index - 1;
                
                [self jumpToTable:btn];
                
            }
            
            
        }
        

        
        
    }else if (point.x < -50){
        
        
        if (self.isAnimations == NO) {
            
            if (self.index == 4) {
                
                return;
                
            }else{
                
                UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                btn.tag = self.index + 1;
                
                [self jumpToTable:btn];
                
            }
            
        }
        
    }


}


- (void)swipeRight:(UIPanGestureRecognizer*)ges
{
    if (self.index == 4) {
        
        return;
        
    }else{
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = self.index + 1;
        
        [self jumpToTable:btn];
        
    }
    
}


- (void)reloadTableMy
{
    

}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getModel
{
    
    self.userLoginInfo= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:self.userLoginInfo.user.phone forKey:@"phone"];
    [dic setValue:self.userLoginInfo.sessionId forKey:@"sessionId"];
    [dic setValue:[NSString stringWithFormat:@"%d",self.arrayAllOrder.count/20 + 1] forKey:@"pageNum"];
    [dic setValue:@"20" forKey:@"pageSize"];
    
    NSLog(@"上传字典:%@",dic);
    
    [[NetworkManager shareMgr] server_queryOrderListWithDic:dic completeHandle:^(NSDictionary *response) {
        
        if ([response objectForKey:@"data"]) {
            
            self.arrayOfOrder= [response objectForKey:@"data"];
            
            self.arrayOfShow=self.arrayOfOrder;
            
            NSLog(@"订单结果：%@",response);
            
            for (int i=0; i<self.arrayOfOrder.count; i++) {
                
                int state= [[[self.arrayOfOrder objectAtIndex:i] objectForKey:@"state"] intValue];
                
                if (state==1) {
                    [self.arrayOfWaiting addObject:[self.arrayOfOrder objectAtIndex:i]];
                }
                else if (state==2)
                {
                    [self.arrayOfWaiting addObject:[self.arrayOfOrder objectAtIndex:i]];
                }
                else if (state==3)
                {
                    [self.arrayOfServicing addObject:[self.arrayOfOrder objectAtIndex:i]];
                }
                else if (state==4)
                {
                    [self.arrayOfWaiting addObject:[self.arrayOfOrder objectAtIndex:i]];
                }
                else if (state==5)
                {
                    [self.arrayOfComplete addObject:[self.arrayOfOrder objectAtIndex:i]];
                }
                
                else if (state==6||state == 7 || state == 8)
                {
                    [self.arrayOfCancel addObject:[self.arrayOfOrder objectAtIndex:i]];
                }
            }
            
            for (int i=0; i<self.arrayOfTables.count; i++) {
                UITableView *table=[self.arrayOfTables objectAtIndex:i];
                [table  reloadData];
            }
            
            
            
        }
        

    }];
    
}

- (void)cancelOrderModel:(NSString*)orderId TableRow:(NSUInteger)row
{
    self.userLoginInfo= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:orderId forKey:@"orderId"];
    [dic setValue:self.userLoginInfo.user.phone forKey:@"phone"];
    [dic setValue:self.userLoginInfo.sessionId forKey:@"sessionId"];
    
    [[NetworkManager shareMgr] server_cancelOrderWithDic:dic completeHandle:^(NSDictionary *response) {
        
     
        
        if ([[response objectForKey:@"message"] isEqualToString:@"OK"]) {
            [HKCommen addAlertViewWithTitel:@"退款申请成功"];
            
            UITableView *table=[self.arrayOfTables objectAtIndex:self.index];
            OrderCell *cell=(OrderCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:1]];

            cell.lblStatusOfOrder.text=@"提交退款申请";
            [cell.btnGoCommentPage setTitle:@"退款中" forState:UIControlStateNormal];
            [cell.btnGoCommentPage removeTarget:self action:@selector(CancelOrder:) forControlEvents:UIControlEventTouchUpInside];

            [self getModel];
        }
        else
        {
            [HKCommen addAlertViewWithTitel:@"退款失败"];
        }
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
        
        [self.arrayOfTables addObject:tableView];
        
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
    self. index = btn.tag;
    
    for (UITableView* table in [self.view  subviews]) {
        
        if (![[table class] isSubclassOfClass:[UITableView class]]) {
            
            continue;
        }
        
        if (table.tag == self. index) {
            
            if (self. index==0) {
                self.arrayOfShow=self.arrayOfOrder;
                [table reloadData];
            }
            else if (self. index==1)
            {
                self.arrayOfShow=self.arrayOfWaiting;
                [table reloadData];
            }
            else if (self. index==2)
            {
                self.arrayOfShow=self.arrayOfServicing;
                [table reloadData];
            }
            else if (self. index==3)
            {
                self.arrayOfShow=self.arrayOfComplete;
                [table reloadData];
            }
            else if (self. index==4)
            {
                self.arrayOfShow=self.arrayOfCancel;
                [table reloadData];
            }
            
            table.hidden = NO;
            
        }else{
            
            table.hidden = YES;
        }
        
    }
    
    
    for (UIButton* btn  in [self.selectView subviews]) {
        
        if (![[btn class] isSubclassOfClass:[UIButton class]] ) {
            
            continue;
        }
        
        
        if (btn.tag == self. index) {
            
            [btn setTitleColor:[HKCommen getColor:@"68beef"] forState:UIControlStateNormal];
            
        }else{
            
            [btn setTitleColor:[HKCommen getColor:@"999999"] forState:UIControlStateNormal];
            
        }
        
        
    }
    
//    [UIView beginAnimations:@"slider" context:nil];
//    [UIView setAnimationDuration:0.5];
    
//    self.slideView.frame = CGRectMake(btn.tag*(SCREEN_WIDTH/5), 42, SCREEN_WIDTH/5, 2);
    
    
    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.isAnimations = YES;
    self.slideView.frame = CGRectMake(btn.tag*(SCREEN_WIDTH/5), 42, SCREEN_WIDTH/5, 2);
        
        
    } completion:^(BOOL finished) {
        
        self.isAnimations = NO;
        
    }];
    
    //    [self.scrollView scrollRectToVisible:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) animated:YES];
}




#pragma  mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }

    NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
    
    NSArray* arrayModel = [arrayModels objectAtIndex:tableView.tag];

    return arrayModel.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 5;
        
    }else{
        
        NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
        
        NSArray* arrayModel = [arrayModels objectAtIndex:tableView.tag];
        
        NSDictionary *dict = [arrayModel objectAtIndex:indexPath.row];
        
        OrderSingle* order = [OrderSingle objectWithKeyValues:dict];
        
        
        if (order.orderImageList.count==0) {
            return 284;
        }
        else
        {
            return 394;
        }
        
        
        
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"OrderCell";
    static NSString* cellId2 = @"OrderCell2";
    static NSString* cellHolderId = @"PlaceHolderCell";
    //    static NSString* cellHolderId = @"PlaceHolderCell";
    
    if (indexPath.section == 0) {
        
        PlaceHolderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellHolderId];
        
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellHolderId owner:self options:nil];
            
            cell = [topLevelObjects objectAtIndex:0];
            
            cell.contentView.backgroundColor = [HKCommen  getColor:@"aaaaaa" WithAlpha:0.2];
            
        }
        
        return cell;
        
        
    }else{
        
        NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
        
        NSArray* arrayModel = [arrayModels objectAtIndex:tableView.tag];
        
        NSDictionary *dict = [arrayModel objectAtIndex:indexPath.row];
        
        OrderSingle* order = [OrderSingle objectWithKeyValues:dict];
        
        OrderCell* cell;
        
        if (order.orderImageList.count  == 0) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
            
        }else{
        
            cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
            
        }
        
        if (!cell) {
            
            if (order.orderImageList.count  == 0) {
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
            else
            {
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
                
                cell.delegate=self;
            }
            
                [cell.btnGoShop addTarget:self action:@selector(goShop:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        
        
        
        cell.row=indexPath.row;
        
        [cell.btn_image1 setTag:0];
        [cell.btn_image2 setTag:1];
        [cell.btn_image3 setTag:2];
        
        
        
        //清除重用的事件
        [cell.btnGoCommentPage removeTarget:self action:@selector(CancelOrder:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnGoCommentPage removeTarget:self action:@selector(goCommentPage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnGoCommentPage removeTarget:self action:@selector(goMoneyReturnPage:) forControlEvents:UIControlEventTouchUpInside];
        

        
        NSUInteger row=indexPath.row;
        
        
        NSLog(@"序号：%@",[self.arrayOfShow objectAtIndex:row]);
        

        
        
        int state= [[dict objectForKey:@"state"] intValue];
        
        float realPay = [[dict objectForKey:@"pay"] floatValue] - [[dict objectForKey:@"pointCost"] floatValue];
        
        cell.lblServiceCompany.text=[dict objectForKey:@"storeName"];
        cell.orderId.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        cell.lblGetOrder.text=[dict objectForKey:@"orderTime"];
        cell.lblMobile.text=[dict objectForKey:@"phone"];
        cell.price.text=[NSString stringWithFormat:@"￥%.2f",[[dict objectForKey:@"amount"] floatValue]] ;
        cell.lblServiceContent.text=[dict objectForKey:@"items"];
        cell.lblCarNum.text=[dict objectForKey:@"carnum"];
        
        
        NSString* price = [NSString stringWithFormat:@"已优惠:￥%.2f",([[dict objectForKey:@"amount"] floatValue] - [[dict objectForKey:@"pay"] floatValue])];
        
        cell.lblCheap.text= price;//[NSString stringWithFormat:@"优惠:￥%@",[dict objectForKey:@"pointCost"]];
        
        cell.lblPayment.text=[NSString stringWithFormat:@"实付款:￥%@",[dict objectForKey:@"pay"]];
        
        
//        [cell.image1 setImage:[UIImage imageNamed:@"bg0"]];
//        [cell.image2 setImage:[UIImage imageNamed:@"bg1"]];
//        [cell.image3 setImage:[UIImage imageNamed:@"bg2"]];
        cell.btnGoShop.tag = (indexPath.row +1)*10 + tableView.tag;
        
        
        if (order.orderImageList.count != 0) {
            
            
            NSArray* arrayImageViews = [NSArray arrayWithObjects:cell.image1,cell.image2,cell.image3, nil];
            
            
            int num = order.orderImageList.count>=3?3:order.orderImageList.count;
            
            cell.arrayImageViews = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < num; i++) {
                

                UIImageView* imageView = [arrayImageViews objectAtIndex:i];
                Orderimagelist* imageList = [order.orderImageList objectAtIndex:i];
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageList.imageUrl]
                               placeholderImage:[UIImage imageNamed:PlaceHolderImage] options:SDWebImageContinueInBackground];
                
                
                [cell.arrayImageViews addObject:imageView];
               
                
            }
            
            for (int i = 3; i < order.orderImageList.count; i ++) {
                
                Orderimagelist* imageList = [order.orderImageList objectAtIndex:i];
                
                UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(1000, 140, 90, 90)];
                
                [imgView sd_setImageWithURL:[NSURL URLWithString:imageList.imageUrl]
                             placeholderImage:[UIImage imageNamed:PlaceHolderImage] options:SDWebImageContinueInBackground];
                
                [cell.arrayImageViews addObject:imgView];
                
                [cell.contentView addSubview:imgView];
                
                
            }
            
            cell.btnGoImages.tag = (indexPath.row +1)*10 + tableView.tag;
            
            cell.btnGoShop.tag = (indexPath.row +1)*10 + tableView.tag;
            
            [cell.btnGoImages addTarget:self action:@selector(goTapAction:) forControlEvents:UIControlEventTouchUpInside];
            
//            for (int i = num; i < 3; i ++) {
//                
//                UIImageView* imageView = [arrayImageViews objectAtIndex:i];
//                
//                imageView.image = nil;
//            }
            

            
        }
        
        
        
       if (state==1)
        {
            cell.lblStatusOfOrder.text=@"待受理";
            
            cell.btnGoCommentPage.hidden=NO;
            
            [cell.btnGoCommentPage setTag:indexPath.row];
            [cell.btnGoCommentPage setTitle:@"取消订单" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(CancelOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (state==5)
        {
            cell.lblStatusOfOrder.text=@"已完成";
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"待评价" forState:UIControlStateNormal];
            [cell.btnGoCommentPage setTag:[[dict objectForKey:@"id"] intValue]];
            
            if ([[ConsulationManager shareMgr] isCommented:order.id]) {
                
                [cell.btnGoCommentPage setTitle:@"已评价" forState:UIControlStateNormal];
                
            }else{
            
            [cell.btnGoCommentPage addTarget:self action:@selector(goCommentPage:) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }
        else if (state==6)
        {
            
            cell.lblStatusOfOrder.text=@"提交退款申请";
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"退款中" forState:UIControlStateNormal];
            
        }
        else if (state==8)
        {
            cell.lblStatusOfOrder.text=@"退款成功";
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"退款详情" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goMoneyReturnPage:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (state==7){
        
            cell.lblStatusOfOrder.text=@"商家审批通过";
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"退款详情" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goMoneyReturnPage) forControlEvents:UIControlEventTouchUpInside];
        
        }
        else{
            cell.btnGoCommentPage.hidden=YES;
            
            //1、待受理  2、待接车 3、服务中 4、待还车  5、已完成 6、提交退款申请 7、商家审批通过 8、退款成功
            
            if (state==1) {
                cell.lblStatusOfOrder.text=@"待受理";
            }
            else if (state==2) {
                cell.lblStatusOfOrder.text=@"待接车";
            }
            else if (state==3) {
                cell.lblStatusOfOrder.text=@"服务中";
            }
            else if (state==4) {
                cell.lblStatusOfOrder.text=@"待还车";
            }
            else if (state==6)
            {
                cell.lblStatusOfOrder.text=@"提交退款申请";
            }
            else
            {
                cell.lblStatusOfOrder.text=@"商家审批通过";
            }
        }
        
        cell.btnGoCommentPage.tag = (indexPath.row +1)*10 + tableView.tag;
        
        return cell;
    }
}

- (void)goShop:(UIButton*)btn
{
    NSInteger tag = btn.tag;
    
    int tableNum = tag%10;
    
    int row = (tag/10) - 1;
    
    NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
    
    NSArray* arrayModel = [arrayModels objectAtIndex:tableNum];
    
    NSDictionary *dict = [arrayModel objectAtIndex:row];
    OrderSingle* order = [OrderSingle objectWithKeyValues:dict];
    
//    ShopDetailCtrl
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ShopDetailCtrl* dlg = [storyBoard instantiateViewControllerWithIdentifier:@"ShopDetailCtrl"];
    
    dlg.preDataShopId =  [NSNumber numberWithInteger:order.storeId.integerValue];
    
    [self.navigationController pushViewController:dlg animated:YES];
    
     

}

-(void)CancelOrder:(UIButton*)btn
{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消订单" message:@"是否取消订单？" preferredStyle:UIAlertControllerStyleAlert];
//
//
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:
//                               ^(UIAlertAction *action) {
//                                   NSUInteger row=button.tag;
//                                   
//                                   UITableView *table=[self.arrayOfTables objectAtIndex:0];
//                                   OrderCell *cell=(OrderCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
//                                   
//                                   
//                                   
//                                   [self cancelOrderModel:cell.orderId.text TableRow:row];
//                               }
//                               ];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
//    
//    [alertController addAction:okAction];
//    [alertController addAction:cancelAction];
//    
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"是否取消订单？"];
    [alertView addButtonWithTitle:@"确认"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              
                              
                              NSInteger tag = btn.tag;
                              
                              int tableNum = tag%10;
                              
                              int row = (tag/10) - 1;
                              
                              NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
                              
                              NSArray* arrayModel = [arrayModels objectAtIndex:tableNum];
                              
                              NSDictionary *dict = [arrayModel objectAtIndex:row];
                              
                              
                              UITableView* tableView = [self.arrayOfTables objectAtIndex:tableNum];
                              
                              OrderCell* cell = (OrderCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:1]];
                              
                              
                              
                              [self cancelOrderModel:cell.orderId.text TableRow:row];
                          }];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler3", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler3", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler3", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler3", alertView);
    };
    
    [alertView show];
    
    
}



/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index TableRow:(NSUInteger)row{
    
    
    UITableView *table=[self.arrayOfTables objectAtIndex:0];
    OrderCell *cell=(OrderCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:1]];
    
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        NSArray *localImages = weakSelf.images;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image = localImages[i];
            
            if (index==0) {
                pbModel.sourceImageView = cell.image1;
            }
            else if (index==1)
            {
                pbModel.sourceImageView = cell.image2;
            }
            else
            {
                pbModel.sourceImageView = cell.image3;
            }
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}

/*
 *  展示网络图片
 */
-(void)networkImageShow:(NSUInteger)index TableRow:(NSUInteger)row
{
    
    
    UITableView *table=[self.arrayOfTables objectAtIndex:0];
    OrderCell *cell=(OrderCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    //避免循环引用
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        
        
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:weakSelf.networkImages.count];
        for (NSUInteger i = 0; i< weakSelf.networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = weakSelf.networkImages[i];
            
            //源frame
            if (index==0) {
                pbModel.sourceImageView = cell.image1;
            }
            else if (index==1)
            {
                pbModel.sourceImageView = cell.image2;
            }
            else
            {
                pbModel.sourceImageView = cell.image3;
            }
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}

-(void)doNothing
{}



-(void)goCommentPage:(UIButton*)btn
{
    NSInteger tag = btn.tag;
    
    int tableNum = tag%10;
    
    int row = (tag/10) - 1;
    
    NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
    
    NSArray* arrayModel = [arrayModels objectAtIndex:tableNum];
    
    NSDictionary *dict = [arrayModel objectAtIndex:row];
    
    OrderSingle* order = [OrderSingle objectWithKeyValues:dict];
    
    NSLog(@"heh");
    
    //[self performSegueWithIdentifier:@"go2" sender:order.id];
     CommentCtrl *vc= [[CommentCtrl alloc]initWithNibName:@"CommentCtrl" bundle:nil];
    vc.orderId=  order.id;

    [self.navigationController pushViewController:vc animated:YES];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"go2"]) {
        
//        CommentCtrl* vc = segue.destinationViewController;
//        
//        NSString* str = sender;
//        
//        vc.orderId=  str;
        
        
    }

}

-(void)goMoneyReturnPage:(UIButton*)btn
{
    NSInteger tag = btn.tag;
    
    int tableNum = tag%10;
    
    int row = (tag/10) - 1;
    
    NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
    
    NSArray* arrayModel = [arrayModels objectAtIndex:tableNum];
    
    NSDictionary *dict = [arrayModel objectAtIndex:row];
    OrderSingle* order = [OrderSingle objectWithKeyValues:dict];
    
    
    MoneyReturnDetailCtrl *vc=[[MoneyReturnDetailCtrl alloc]
                               initWithNibName:@"MoneyReturnDetailCtrl" bundle:nil];
    
    vc.order = order;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goTapAction:(UIButton*)btn
{
    NSLog(@"sdad");
    
    NSInteger tag = btn.tag;
    
    int tableNum = tag%10;
    
    int row = (tag/10) - 1;
    
    NSArray* arrayModels = [NSArray arrayWithObjects:self.arrayOfOrder,self.arrayOfWaiting ,self.arrayOfServicing,self.arrayOfComplete, self.arrayOfCancel,nil];
    
    NSArray* arrayModel = [arrayModels objectAtIndex:tableNum];
    
    NSDictionary *dict = [arrayModel objectAtIndex:row];
    
    OrderSingle* order = [OrderSingle objectWithKeyValues:dict];
    
    UITableView* tableView = [self.arrayOfTables objectAtIndex:tableNum];
    
    OrderCell* cell = (OrderCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:1]];
    
    __weak OrderCell* weakCell = cell;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:0 photoModelBlock:^NSArray *{
        
        
        NSMutableArray *localImages = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < weakCell.arrayImageViews.count; i ++) {
            
            UIImageView* imgView = [weakCell.arrayImageViews objectAtIndex:i];

            [localImages addObject:imgView.image];
        }
        

        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image = localImages[i];
            
            pbModel.sourceImageView = weakCell.image1;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
    
    


}


@end
