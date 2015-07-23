//
//  ProgressOrderCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/4.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ProgressOrderCtrl.h"

@interface ProgressOrderCtrl ()

@end

@implementation ProgressOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 200)];
    [title setTextColor:[UIColor whiteColor]];
    title.text=@"订单进程";
    self.navigationItem.titleView=title;
    
    self.view_Progress=[[[NSBundle mainBundle] loadNibNamed:@"ProgressOrderView" owner:self options:nil] objectAtIndex:0];
    
    self.arrayLine=[NSArray arrayWithObjects:self.view_Line1,self.view_Line2,self.view_Line3,self.view_Line4, nil];
    self.arrayCircle=[NSArray arrayWithObjects:self.view_Circle1,self.view_Circle2,self.view_Circle3,self.view_Circle4, nil];
    
    
    
    [self progress:1];
    [self.view addSubview:self.view_Progress];
}



-(void)progress:(int)whichProgress
{
  
    for (int i=0; i<self.arrayLine.count; i++) {
        UIView *LineView=[self.arrayLine objectAtIndex:i];
        LineView.backgroundColor=[UIColor grayColor];
    }
    for (int i=0; i<self.arrayCircle.count; i++) {
        UIView *CircleView=[self.arrayCircle objectAtIndex:i];
        CircleView.backgroundColor=[UIColor grayColor];
    }
    
    for (int i=0; i<whichProgress; i++) {
        UIView *LineView=[self.arrayLine objectAtIndex:i];
        LineView.backgroundColor=[UIColor blueColor];
    }
    
    for (int i=0; i<whichProgress; i++) {
        UIView *CircleView=[self.arrayCircle objectAtIndex:i];
        CircleView.backgroundColor=[UIColor blueColor];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
