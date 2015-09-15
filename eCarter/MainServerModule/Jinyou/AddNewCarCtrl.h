//
//  AddNewCarCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"
#import "Select_seriesOfCarCtrl.h"
#import "AddNewAdress.h"
#import "Car.h"

@interface AddNewCarCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong,nonatomic)NSArray *arrayOfCar;
@property (strong,nonatomic)NSString *carId;

@property (nonatomic, strong) Car* preCar;
@end
