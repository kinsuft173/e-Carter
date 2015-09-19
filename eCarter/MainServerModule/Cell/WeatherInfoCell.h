//
//  WeatherInfoCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/21.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherInfoCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* imgChuqing;
@property (nonatomic, strong) IBOutlet UIImageView* imgWeather;
@property (nonatomic, strong) IBOutlet UILabel* lbl_temperature;
@property (nonatomic, strong) IBOutlet UILabel* lbl_weather;

@property (nonatomic, strong) IBOutlet UIImageView* imgNoYi;

@end
