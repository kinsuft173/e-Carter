//
//  DiscountScoreCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountScoreCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* lblDiscount;
@property (nonatomic, strong) IBOutlet UILabel* lblRMBDiscount;
@property (nonatomic, strong) IBOutlet UISwitch* switchCount;
@end
