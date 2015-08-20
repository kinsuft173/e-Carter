//
//  CouponMainInfoCell.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "CouponMainInfoCell.h"

@implementation CouponMainInfoCell

- (void)awakeFromNib {
    // Initialization code
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
    
}

- (IBAction)getMyTicket:(UIButton *)sender {
    
    [self.delegate getTicket:self.couponId StoreNum:self.storeId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
