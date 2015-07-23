//
//  JYCommon.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "JYCommon.h"

@implementation JYCommon

//添加右上按钮
/*
 + (void)addBarButton: (NSString*)string whichItem:(UINavigationItem*)navigaionItem doWhat:@(SEL)
 {
 UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
 rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
 [rightButton setFrame:CGRectMake(0, 0, 50, 100)];
 [rightButton setTitle:string forState:UIControlStateNormal];
 [rightButton addTarget:self action:@selector(doNothing) forControlEvents:UIControlEventTouchUpInside];
 UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
 navigaionItem.rightBarButtonItem=item;
 }
 */

@end
