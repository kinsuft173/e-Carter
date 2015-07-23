//
//  LocalCell.m
//  GSAPP
//
//  Created by kinsuft173 on 15/7/15.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "LocalCell.h"

@implementation LocalCell

- (void)awakeFromNib {
    
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
