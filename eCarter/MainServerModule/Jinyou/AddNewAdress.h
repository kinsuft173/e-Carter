//
//  AddNewAdress.h
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "UserAddress.h"

@interface AddNewAdress : UIViewController

@property (strong,nonatomic)NSString *province;
@property (strong,nonatomic)NSString *city;
@property (strong,nonatomic)NSString *place;
@property (strong,nonatomic)NSString *details;
@property (strong,nonatomic)NSString *type;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Alert;
@property (weak, nonatomic) IBOutlet UILabel *lbl_AdressOfSelect;
@property (weak, nonatomic) IBOutlet UITextView *txt_AdressDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_placeHolder;
@property (weak, nonatomic) IBOutlet UILabel *lbl_homeType;
@property(nonatomic, strong) AMapReGeocode *regeocode;
@property (nonatomic, strong) UserAddress* preUserAdress;

@end
