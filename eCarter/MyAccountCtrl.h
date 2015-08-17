//
//  MyAccountCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_mobile;
@property (weak, nonatomic) IBOutlet UITextField *txt_name;
@property (weak, nonatomic) IBOutlet UIButton *btn_boy;
@property (weak, nonatomic) IBOutlet UIButton *btn_girl;
@property (assign,nonatomic)BOOL judgeSex;

@end
