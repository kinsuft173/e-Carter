//
//  CarInfoCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_nameOfCar;
@property (weak, nonatomic) IBOutlet UILabel *lbl_numOfCar;
@property (weak, nonatomic) IBOutlet UILabel *lbl_seriesOfCar;
@property (weak, nonatomic) IBOutlet UILabel *lbl_colorOfCar;
@property (weak, nonatomic) IBOutlet UILabel *lbl_numOfFrame;
@property (weak, nonatomic) IBOutlet UILabel *lbl_brand;
@property (weak, nonatomic) IBOutlet UILabel *lbl_year;
@property (weak, nonatomic) IBOutlet UILabel *lbl_volume;
@property (weak, nonatomic) IBOutlet UILabel *lbl_engine;


@end
