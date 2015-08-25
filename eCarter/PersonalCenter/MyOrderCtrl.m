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
    
    /*
     [self.networkImages addObject:@"http://img5.imgtn.bdimg.com/it/u=2291374817,432518394&fm=21&gp=0.jpg"];
     [self.networkImages addObject:@"http://img5.imgtn.bdimg.com/it/u=2291374817,432518394&fm=21&gp=0.jpg"];
     [self.networkImages addObject:@"http://img5.imgtn.bdimg.com/it/u=2291374817,432518394&fm=21&gp=0.jpg"];
     */
    
    self.images=[[NSMutableArray alloc]init];
    UIImage *image1=[UIImage imageNamed:@"bg0"];
    UIImage *image2=[UIImage imageNamed:@"bg1"];
    UIImage *image3=[UIImage imageNamed:@"bg2"];
    UIImage *image4=[UIImage imageNamed:@"bg3"];
    [self.images addObject:image1];
    [self.images addObject:image2];
    [self.images addObject:image3];
    [self.images addObject:image4];
    
  

    
    [self getModel];
    [self initScrollTables:5];
    
    
    
    
    
    
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
    self.userLoginInfo= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:self.userLoginInfo.user.phone forKey:@"phone"];
    [dic setValue:self.userLoginInfo.sessionId forKey:@"sessionId"];
    [dic setValue:@"1" forKey:@"pageNum"];
    [dic setValue:@"10" forKey:@"pageSize"];
    
    NSLog(@"上传字典:%@",dic);
    
    [[NetworkManager shareMgr] server_queryOrderListWithDic:dic completeHandle:^(NSDictionary *response) {
        
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
        
            else if (state==8)
            {
                [self.arrayOfCancel addObject:[self.arrayOfOrder objectAtIndex:i]];
            }
        }
        
        for (int i=0; i<self.arrayOfTables.count; i++) {
            UITableView *table=[self.arrayOfTables objectAtIndex:i];
            [table  reloadData];
        }
    }];
    
}

- (void)getModel:(NSArray *)state
{
    self.userLoginInfo= [UserDataManager shareManager].userLoginInfo;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];

    [dic setValue:self.userLoginInfo.user.phone forKey:@"phone"];
    [dic setValue:self.userLoginInfo.sessionId forKey:@"sessionId"];
    [dic setValue:@"1" forKey:@"pageNum"];
    [dic setValue:@"10" forKey:@"pageSize"];
    [dic setValue:@[@1, @2, @4] forKey:@"state"];
    
    [[NetworkManager shareMgr] server_queryOrderListWithDic:dic completeHandle:^(NSDictionary *response) {
        
        self.arrayOfOrder= [response objectForKey:@"data"];
        
        NSLog(@"订单结果：%@",response);
        for (int i=0; i<self.arrayOfTables.count; i++) {
            UITableView *table=[self.arrayOfTables objectAtIndex:i];
            [table  reloadData];
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
    NSInteger index = btn.tag;
    
    for (UITableView* table in [self.view  subviews]) {
        
        if (![[table class] isSubclassOfClass:[UITableView class]]) {
            
            continue;
        }
        
        if (table.tag == index) {
            
            if (index==0) {
                self.arrayOfShow=self.arrayOfOrder;
                [table reloadData];
            }
            else if (index==1)
            {
                self.arrayOfShow=self.arrayOfWaiting;
                [table reloadData];
            }
            else if (index==2)
            {
                self.arrayOfShow=self.arrayOfServicing;
                [table reloadData];
            }
            else if (index==3)
            {
                self.arrayOfShow=self.arrayOfComplete;
                [table reloadData];
            }
            else if (index==4)
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
    return self.arrayOfShow.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 5;
        
    }
    
    
    
    else{
        
        NSUInteger row=indexPath.row-1;
        
        NSDictionary *dict=[self.arrayOfShow objectAtIndex:row];
        
        NSArray *orderImageList=[dict objectForKey:@"orderImageList"];
        
        for (int i=0; i<orderImageList.count; i++) {
            [self.networkImages addObject:[[orderImageList objectAtIndex:i] objectForKey:@"imageUrl"]];
        }
        
        
        NSArray *returnImageList=[dict objectForKey:@"returnImageList"];
        for (int i=0; i<returnImageList.count; i++) {
            [self.networkImages addObject:[[returnImageList objectAtIndex:i] objectForKey:@"imageUrl"]];
        }
        
        if (self.networkImages.count==0) {
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
        
        
    }
    /*
     else if(indexPath.row%2 == 0){
     
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
     NSLog(@"每行1的字典：%@",[self.arrayOfOrder objectAtIndex:indexPath.row*0.5]);
     
     
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
     
     }
     */
    else{
        
        
        
        OrderCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        
        if (!cell) {
            
            if (self.networkImages.count==0) {
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
            
            
            
            
        }
        
        cell.row=indexPath.row;
        
        [cell.btn_image1 setTag:0];
        [cell.btn_image2 setTag:1];
        [cell.btn_image3 setTag:2];
        
        
        
        
        
        NSUInteger row=indexPath.row-1;
        
        
        NSLog(@"序号：%@",[self.arrayOfShow objectAtIndex:row]);
        
        NSDictionary *dict=[self.arrayOfShow objectAtIndex:row];
        
        NSArray *orderImageList=[dict objectForKey:@"orderImageList"];
        
        for (int i=0; i<orderImageList.count; i++) {
            [self.networkImages addObject:[[orderImageList objectAtIndex:i] objectForKey:@"imageUrl"]];
        }
        
        
        NSArray *returnImageList=[dict objectForKey:@"returnImageList"];
        for (int i=0; i<returnImageList.count; i++) {
            [self.networkImages addObject:[[returnImageList objectAtIndex:i] objectForKey:@"imageUrl"]];
        }
        
        /*
         [cell.btn_image1 addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
         [cell.btn_image1 setTag:0];
         
         [cell.btn_image2 addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
         [cell.btn_image2 setTag:1];
         
         [cell.btn_image3 addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
         [cell.btn_image3 setTag:2];
         */
        
        int state= [[dict objectForKey:@"state"] intValue];
        
        cell.lblServiceCompany.text=[dict objectForKey:@"storeName"];
        cell.orderId.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        cell.lblGetOrder.text=[dict objectForKey:@"orderTime"];
        cell.lblMobile.text=[dict objectForKey:@"phone"];
        cell.price.text=[NSString stringWithFormat:@"￥%@",[dict objectForKey:@"itemsCost"]];
        cell.lblServiceContent.text=[dict objectForKey:@"items"];
        cell.lblCarNum.text=[dict objectForKey:@"carnum"];
        
        cell.lblCheap.text=[NSString stringWithFormat:@"优惠劵:￥%@",[dict objectForKey:@"pointCost"]];
        
        cell.lblPayment.text=[NSString stringWithFormat:@"实付款:￥%@",[dict objectForKey:@"pay"]];
        
        
        [cell.image1 setImage:[UIImage imageNamed:@"bg0"]];
        [cell.image2 setImage:[UIImage imageNamed:@"bg1"]];
        [cell.image3 setImage:[UIImage imageNamed:@"bg2"]];
        
        if (state==5)
        {
            cell.lblStatusOfOrder.text=@"已完成";
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"待评价" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goCommentPage) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (state==8)
        {
            cell.lblStatusOfOrder.text=@"退款成功";
            
            cell.btnGoCommentPage.hidden=NO;
            [cell.btnGoCommentPage setTitle:@"退款详情" forState:UIControlStateNormal];
            [cell.btnGoCommentPage addTarget:self action:@selector(goMoneyReturnPage) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
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
        
        return cell;
    }
}


/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index TableRow:(NSUInteger)row{
    
    
    UITableView *table=[self.arrayOfTables objectAtIndex:0];
    OrderCell *cell=(OrderCell*)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    
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
