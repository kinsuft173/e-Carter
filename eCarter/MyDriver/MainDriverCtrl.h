//
//  MainDriverCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/1.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainDriverCell.h"
#import "mainListCell.h"
#import "HKCommen.h"

@interface MainDriverCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong,nonatomic) NSArray *arrayOfImg;
@property (strong,nonatomic) NSArray *arrayOfList;

@end
