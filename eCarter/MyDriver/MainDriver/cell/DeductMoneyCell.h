//
//  DeductMoneyCell.h
//  eCarter
//
//  Created by lijingyou on 15/7/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeductMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Month;
@property (weak, nonatomic) IBOutlet UILabel *lbl_SumOfOrder;
@property (weak, nonatomic) IBOutlet UILabel *lbl_EachOfOrder;
@property (weak, nonatomic) IBOutlet UILabel *lbl_SumOfDeduct;

@end
