//
//  CouponMainInfoCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponMainInfoCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton* btnExpand;
@property (weak, nonatomic) IBOutlet UILabel *lbl_company;
@property (weak, nonatomic) IBOutlet UILabel *lbl_price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_number;


@end
