//
//  OrderManagerCell.h
//  eCarter
//
//  Created by lijingyou on 15/7/1.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_IdOfOrder;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Owner;
@property (weak, nonatomic) IBOutlet UILabel *lbl_attributeOfCar;
@property (weak, nonatomic) IBOutlet UILabel *lbl_contentOfService;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_statusOfOrder;

@end






