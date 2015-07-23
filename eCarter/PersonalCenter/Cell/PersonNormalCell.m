//
//  PersonNormalCell.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "PersonNormalCell.h"

@implementation PersonNormalCell

- (void)awakeFromNib {
    // Initialization code
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
