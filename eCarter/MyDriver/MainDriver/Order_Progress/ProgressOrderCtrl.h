//
//  ProgressOrderCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/4.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressOrderCtrl : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view_Progress;

@property (strong,nonatomic)NSArray *arrayLine;
@property (strong,nonatomic)NSArray *arrayCircle;

@property (weak, nonatomic) IBOutlet UIView *view_Line1;
@property (weak, nonatomic) IBOutlet UIView *view_Line2;
@property (weak, nonatomic) IBOutlet UIView *view_Line3;
@property (weak, nonatomic) IBOutlet UIView *view_Line4;
@property (weak, nonatomic) IBOutlet UIView *view_Line5;


@property (weak, nonatomic) IBOutlet UIView *view_Circle1;
@property (weak, nonatomic) IBOutlet UIView *view_Circle2;
@property (weak, nonatomic) IBOutlet UIView *view_Circle3;
@property (weak, nonatomic) IBOutlet UIView *view_Circle4;

@end
