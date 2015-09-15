//
//  ShopInfoCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"

@interface ShopInfoCell : UITableViewCell

@property (strong,nonatomic) starView *star;
@property (strong,nonatomic) IBOutlet UIView* viewForMask1;

@property (strong, nonatomic) IBOutlet UILabel* lblStoreName;
@property (strong, nonatomic) IBOutlet UILabel* lblStoreScore;
@property (strong, nonatomic) IBOutlet UILabel* lblDistance;
@property (strong, nonatomic) IBOutlet UILabel* lblTimeStartAndEnd;
@property (strong, nonatomic) IBOutlet UILabel* lblAddress;
@property (strong, nonatomic) IBOutlet UILabel* lblServerItems;

@property (strong, nonatomic) IBOutlet UIButton* lblServing;
@end
