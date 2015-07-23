//
//  AddNewAdress.h
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewAdress : UIViewController

@property (strong,nonatomic)NSString *province;
@property (strong,nonatomic)NSString *city;
@property (strong,nonatomic)NSString *place;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Alert;
@property (weak, nonatomic) IBOutlet UILabel *lbl_AdressOfSelect;
@property (weak, nonatomic) IBOutlet UITextView *txt_AdressDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_placeHolder;

@end
