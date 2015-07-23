//
//  Select_seriesOfCarCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesCarCell.h"

@interface Select_seriesOfCarCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property (strong,nonatomic)NSArray *array_color;
@property (strong,nonatomic)NSString *JudgeWhereFrom;

@property (strong,nonatomic)NSArray *array_showArray;
@end
