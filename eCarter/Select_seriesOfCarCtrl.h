//
//  Select_seriesOfCarCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesCarCell.h"

@protocol carSelect <NSObject>

- (void)handleCarSlect:(NSDictionary*)dic;

@end

@interface Select_seriesOfCarCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property (strong,nonatomic)NSArray *array_color;
@property (strong,nonatomic)NSString *JudgeWhereFrom;
@property (strong,nonatomic)NSString *carId;

@property (strong,nonatomic)NSMutableArray *array_showArray;

@property (nonatomic, strong) NSString* preBrand;
@property (nonatomic, strong) id<carSelect> delegate;

@end
