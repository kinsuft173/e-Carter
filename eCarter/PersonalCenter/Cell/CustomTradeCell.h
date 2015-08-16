//
//  CustomTradeCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/29.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTradeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_money;
@property (weak, nonatomic) IBOutlet UILabel *lbl_wayOfPay;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_merchant;


@end
