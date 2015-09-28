//
//  AddNewAdress.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "AddNewAdress.h"
#import "HKCommen.h"
#import "HKMapCtrl.h"
#import "HKMapManager.h"
#import "HKMapManager.h"
#import "NetworkManager.h"
#import "UserDataManager.h"
#import "GetProvinceCtrl.h"
#import "HomeTypeSelectedCtrl.h"



@interface AddNewAdress ()<UITextViewDelegate,NSXMLParserDelegate>
@property (nonatomic, strong) NSMutableArray *arrayProvince;
@property (nonatomic, strong) NSMutableArray *arrayCity;
@property (nonatomic, strong) NSMutableArray *arrayRegion;

@property (nonatomic, strong) NSXMLParser *xmlParser;
@end

@implementation AddNewAdress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.province=@"广东省";
//    self.city=@"广州市";
//    self.place=@"天河区";
    self.type = @"1";
    
    if (self.preUserAdress) {
        
        [HKMapManager shareMgr].province = self.preUserAdress.province;
        [HKMapManager shareMgr].city = self.preUserAdress.city;
        [HKMapManager shareMgr].place = self.preUserAdress.area;
        [HKMapManager shareMgr].adressType = self.preUserAdress.type;
        [HKMapManager shareMgr].detail = self.preUserAdress.address;
        
    }
    
    self.arrayProvince=[[NSMutableArray alloc]init];
    self.arrayCity=[[NSMutableArray alloc]init];
    self.arrayRegion=[[NSMutableArray alloc]init];
    
    NSString *strPathXml = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"xml"];
    
    //将xml文件转换成data类型
    NSData *data = [[NSData alloc] initWithContentsOfFile:strPathXml];
    
    self.xmlParser = [[NSXMLParser alloc]initWithData:data];
    
    self.xmlParser.delegate = self;
    [self.xmlParser parse];
    
    [self initUI];
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
    self.lbl_AdressOfSelect.text=@"请选择城市";
    
     [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(fetchAddress) name:@"ReGeocode" object:nil];
    
    
}

-(void)getAdress:(NSNotification*)notify
{
    NSString *string= notify.object;
    self.lbl_AdressOfSelect.text=string;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pickCity:(NSString*)string
{
    NSLog(@"选择了1");
    self.lbl_AdressOfSelect.text=string;
}

-(void)pickAdress:(NSString*)string
{
    NSLog(@"选择了2");
    self.lbl_AdressOfSelect.text=string;
}

- (IBAction)goSelectAdress:(UIButton *)sender {
    GetProvinceCtrl *vc=[[GetProvinceCtrl alloc]initWithNibName:@"GetProvinceCtrl" bundle:nil];
    vc.arrayOfProvince=self.arrayProvince;
    vc.arrayOfCity=self.arrayCity;
    vc.arrayOfRegion=self.arrayRegion;
    
    NSLog(@"self.arrayCity = %@",self.arrayCity);
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    [self fetchAddress];

}

- (void)fetchAddress
{

    if ([HKMapManager shareMgr].address) {
        
        self.lbl_AdressOfSelect.text =  [NSString stringWithFormat:@"%@%@%@",[HKMapManager shareMgr].regeocode.addressComponent.province,[HKMapManager shareMgr].regeocode.addressComponent.city,[HKMapManager shareMgr].regeocode.addressComponent.district];//[HKMapManager shareMgr].address;
        
        NSString* strDetail = [[HKMapManager shareMgr].regeocode.formattedAddress  substringFromIndex:self.lbl_AdressOfSelect.text.length];
        
        self.txt_AdressDetail.text =strDetail;// [NSString stringWithFormat:@"%@%@%@%@%@",[HKMapManager shareMgr].regeocode.addressComponent.township,[HKMapManager shareMgr].regeocode.addressComponent.neighborhood,[HKMapManager shareMgr].regeocode.addressComponent.building,[HKMapManager shareMgr].regeocode.addressComponent.streetNumber.street,[HKMapManager shareMgr].regeocode.addressComponent.streetNumber.number];
        self.lbl_placeHolder.text = @"";
        
        self.province = [HKMapManager shareMgr].regeocode.addressComponent.province;
        self.city = [HKMapManager shareMgr].regeocode.addressComponent.city;
        self.place = [HKMapManager shareMgr].regeocode.addressComponent.district;
        
        [HKMapManager shareMgr].address = nil;
        [HKMapManager shareMgr].regeocode = nil;
    }
    
    if ([HKMapManager shareMgr].place) {
        
        self.province = [HKMapManager shareMgr].province;
        self.city = [HKMapManager shareMgr].city;
        self.place = [HKMapManager shareMgr].place;
    
        
        self.lbl_AdressOfSelect.text =  [NSString stringWithFormat:@"%@%@%@",self.province,self.city ,self.place];
        self.txt_AdressDetail.text = [HKMapManager shareMgr].detail;
        
        self.lbl_placeHolder.text = @"";
        
        [HKMapManager shareMgr].province = nil;
        [HKMapManager shareMgr].city = nil;
        [HKMapManager shareMgr].place = nil;
        [HKMapManager shareMgr].detail = nil;
    }
    
    if ([[HKMapManager shareMgr].adressType isEqualToString:@"1"]) {
        self.type = [HKMapManager shareMgr].adressType;
        [HKMapManager shareMgr].adressType = nil;
        self.lbl_homeType.text = @"家庭地址";
        
    }else if ([[HKMapManager shareMgr].adressType isEqualToString:@"2"]) {
        self.type = [HKMapManager shareMgr].adressType;
        [HKMapManager shareMgr].adressType = nil;
        self.lbl_homeType.text = @"工作地址";
        
    }else if ([[HKMapManager shareMgr].adressType isEqualToString:@"3"]) {
        self.type = [HKMapManager shareMgr].adressType;
        [HKMapManager shareMgr].adressType = nil;
        self.lbl_homeType.text = @"其他地址";
        
    }

}

-(void)initUI
{
    [HKCommen addHeadTitle:@"编辑地址" whichNavigation:self.navigationItem];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [rightButton setFrame:CGRectMake(0, 0, 30, 50)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    //rightButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=item;
    
    self.lbl_Alert.text= @"你选择的位置暂时未提供服务；已反馈给商家，敬请期待";
    self.lbl_Alert.hidden = YES;
    self.lbl_AdressOfSelect.text=[NSString stringWithFormat:@"%@%@%@",self.province,self.city,self.place];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save
{

    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    
    if (!self.province) {
        
        [HKCommen addAlertViewWithTitel:@"请选择省份"];
        
        return;
    }
    
    if (!self.city) {
        
        [HKCommen addAlertViewWithTitel:@"请选择城市"];
        
        return;
    }
    
    if (!self.place) {
        
        [HKCommen addAlertViewWithTitel:@"请选择区域"];
        
        return;
    }
    
    
    [dic setObject:self.type forKey:@"type"];
    [dic setObject:self.province forKey:@"province"];
    [dic setObject:self.city forKey:@"city"];
    [dic setObject:self.place forKey:@"area"];
    
    if (self.txt_AdressDetail.text && (![self.txt_AdressDetail.text isEqualToString:@""])) {
        
        [dic setObject:self.txt_AdressDetail.text forKey:@"detail"];
        
    }else{
    
        [HKCommen addAlertViewWithTitel:@"请输入详细地址"];
        
        
        return;
    
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";

    [dic setObject:[UserDataManager shareManager].userLoginInfo.user.phone forKey:@"phone"];
    [dic setObject:[UserDataManager shareManager].userLoginInfo.sessionId forKey:@"sessionId"];
    
    
    if (self.preUserAdress) {
        
        [dic setObject:self.preUserAdress.id forKey:@"id"];
     
        [[NetworkManager shareMgr] server_editUserAddressWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            
            NSString* messege = [response objectForKey:@"message"];
            
            
            if ([messege isEqualToString:@"OK"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCarOrAddress" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            hud.hidden = YES;
            
        }];
        
        
    }else{
    
        [[NetworkManager shareMgr] server_addUserAddressWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            
            NSString* messege = [response objectForKey:@"message"];
            
            
            if ([messege isEqualToString:@"OK"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCarOrAddress" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            hud.hidden = YES;
            
        }];
        
    }
    

}

- (IBAction)goMapCtrl:(id)sender
{
    HKMapCtrl* vc  = [[HKMapCtrl alloc]  initWithNibName:@"HKMapCtrl" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        
        self.lbl_placeHolder.text = @"请输入详细地址";
        
    }else{
    
        self.lbl_placeHolder.text = @"";
    
    }

}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    
    
    
}

/* 当解析器对象遇到xml的开始标记时，调用这个方法开始解析该节点 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"Province"])
    {
        
        [self.arrayProvince addObject:[attributeDict objectForKey:@"FullName"]];
        
    }
    else if([elementName isEqualToString:@"City"])
    {
        [self.arrayCity addObject:[attributeDict objectForKey:@"FullName"]];
    }
    else if([elementName isEqualToString:@"Region"])
    {
        [self.arrayRegion addObject:[attributeDict objectForKey:@"FullName"]];
    }
}

/* 当解析器找到开始标记和结束标记之间的字符时，调用这个方法解析当前节点的所有字符 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
}

/* 当解析器对象遇到xml的结束标记时，调用这个方法完成解析该节点 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

/* 解析xml出错的处理方法 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
}

/* 解析xml文件结束 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}


- (IBAction)goSelectHomeType:(id)sender
{
    HomeTypeSelectedCtrl* vc  = [[HomeTypeSelectedCtrl alloc]  initWithNibName:@"HomeTypeSelectedCtrl" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];

}


@end
