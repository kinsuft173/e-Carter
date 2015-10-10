//
//  CommentCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/8/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "CommentCtrl.h"
#import "HKCommen.h"
#import "starView.h"
#import "NetworkManager.h"
#import "HKCommen.h"
#import "ConsulationManager.h"

@interface CommentCtrl ()<UITextViewDelegate>
@property (strong,nonatomic)starView *starQuality;
@property (strong,nonatomic)starView *starAttitude;
@property (strong,nonatomic)starView *starEffiency;
@property (strong,nonatomic)UINavigationBar *myNav;
@end

@implementation CommentCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"发布评论" whichNavigation:self.navigationItem];
    
    self.txt_comment.delegate=self;
    
    
    self.valueAttitude=@"";
    self.valueEfficiency=@"";
    self.valueQuality=@"";
    
    self.starQuality=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    [self.starQuality setFrame:CGRectMake(0, 10, 82, 15)];
    [self.starQuality setWhichValue:0.0];
    
    [self.starQuality.btn_image1 addTarget:self action:@selector(setQuality:) forControlEvents:UIControlEventTouchUpInside];
    [self.starQuality.btn_image2 addTarget:self action:@selector(setQuality:) forControlEvents:UIControlEventTouchUpInside];
    [self.starQuality.btn_image3 addTarget:self action:@selector(setQuality:) forControlEvents:UIControlEventTouchUpInside];
    [self.starQuality.btn_image4 addTarget:self action:@selector(setQuality:) forControlEvents:UIControlEventTouchUpInside];
    [self.starQuality.btn_image5 addTarget:self action:@selector(setQuality:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewForStarQuality addSubview:self.starQuality];
    
    self.starAttitude=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    [self.starAttitude setFrame:CGRectMake(0, 10, 82, 15)];
    [self.starAttitude setWhichValue:0.0];
    
    [self.starAttitude.btn_image1 addTarget:self action:@selector(setAttitude:) forControlEvents:UIControlEventTouchUpInside];
    [self.starAttitude.btn_image2 addTarget:self action:@selector(setAttitude:) forControlEvents:UIControlEventTouchUpInside];
    [self.starAttitude.btn_image3 addTarget:self action:@selector(setAttitude:) forControlEvents:UIControlEventTouchUpInside];
    [self.starAttitude.btn_image4 addTarget:self action:@selector(setAttitude:) forControlEvents:UIControlEventTouchUpInside];
    [self.starAttitude.btn_image5 addTarget:self action:@selector(setAttitude:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewForStarAttitude addSubview:self.starAttitude];
    
    
    self.starEffiency=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    [self.starEffiency setFrame:CGRectMake(0, 10, 82, 15)];
    [self.starEffiency setWhichValue:0.0];
    
    [self.starEffiency.btn_image1 addTarget:self action:@selector(setEfficiency:) forControlEvents:UIControlEventTouchUpInside];
    [self.starEffiency.btn_image2 addTarget:self action:@selector(setEfficiency:) forControlEvents:UIControlEventTouchUpInside];
    [self.starEffiency.btn_image3 addTarget:self action:@selector(setEfficiency:) forControlEvents:UIControlEventTouchUpInside];
    [self.starEffiency.btn_image4 addTarget:self action:@selector(setEfficiency:) forControlEvents:UIControlEventTouchUpInside];
    [self.starEffiency.btn_image5 addTarget:self action:@selector(setEfficiency:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewForStarEffiency addSubview:self.starEffiency];
    
    
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
    [self addGesturesTap];
}

-(void)setQuality:(UIButton*)button
{
    self.valueQuality=[NSString stringWithFormat:@"%ld",button.tag];
    [self.starQuality setWhichValue:button.tag];
    [self.starQuality setStarForValue:button.tag];
    self.starQuality.whichValue=button.tag;
 
}

-(void)setAttitude:(UIButton*)button
{
    self.valueAttitude=[NSString stringWithFormat:@"%ld",button.tag];
    [self.starAttitude setWhichValue:button.tag];
    [self.starAttitude setStarForValue:button.tag];
    self.starAttitude.whichValue=button.tag;
 
}

-(void)setEfficiency:(UIButton*)button
{
    self.valueEfficiency=[NSString stringWithFormat:@"%ld",button.tag];
    [self.starEffiency setWhichValue:button.tag];
    [self.starEffiency setStarForValue:button.tag];
    self.starEffiency.whichValue=button.tag;
 
  
}

- (IBAction)submitComment:(UIButton *)sender {
    
    if ([self.txt_comment.text isEqualToString:@""]) {
        [HKCommen addAlertViewWithTitel:@"请输入评论内容"];
        return;
    }
    
    if ([self.valueAttitude isEqualToString:@""]) {
        [HKCommen addAlertViewWithTitel:@"请评价服务态度"];
        return;
    }
    
    if ([self.valueEfficiency isEqualToString:@""]) {
        [HKCommen addAlertViewWithTitel:@"请评价服务效率"];
        return;
    }
    
    if ([self.valueQuality isEqualToString:@""]) {
        [HKCommen addAlertViewWithTitel:@"请评价服务质量"];
        return;
    }
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.orderId forKey:@"orderId"];
    [dic setObject:self.txt_comment.text forKey:@"reviews"];
    [dic setObject:self.valueQuality forKey:@"serviceQualityScore"];
    [dic setObject:self.valueAttitude forKey:@"serviceAttitudeScore"];
    [dic setObject:self.valueEfficiency forKey:@"serviceEfficiencyScore"];
    
    NSLog(@"上传字典：%@",dic);
    
    [[NetworkManager shareMgr] server_submitOrderReviewsWithDic:dic completeHandle:^(NSDictionary *response) {
        
        if ([[response objectForKey:@"message"] isEqualToString:@"OK"]) {
            [HKCommen addAlertViewWithTitel:@"提交成功"];
            self.txt_comment.text=@"";
            [self.starEffiency setStarForValue:0.0];
            [self.starAttitude setStarForValue:0.0];
            [self.starQuality setStarForValue:0.0];
            
           // [[ConsulationManager shareMgr] addHandledComment:self.orderId];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadOrder" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];

        }
        else
        {
            [HKCommen addAlertViewWithTitel:@"提交失败"];
        }
        NSLog(@"获得的字典：%@",response);
        
    }];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)addGesturesTap
{
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
}

-(void)closeKeyBoard
{
    [self.txt_comment resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.lbl_tintInformation.hidden=YES;
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (self.txt_comment.text.length==0) {
        self.lbl_tintInformation.hidden=NO;
    }
    else
    {
        self.lbl_tintInformation.hidden=YES;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.txt_comment.text.length==0) {
        self.lbl_tintInformation.hidden=NO;
    }
    else
    {
        self.lbl_tintInformation.hidden=YES;
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
