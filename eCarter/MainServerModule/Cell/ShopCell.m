//
//  ShopCell.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (void)awakeFromNib {
    
    // Initialization code
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }

    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];

    [self.viewMask addSubview:self.star];
//    if ([[UIScreen mainScreen]bounds].size.width==320) {
//        [self.star setFrame:CGRectMake(150, 55, 82, 15)];
//    }
//    else if ([[UIScreen mainScreen]bounds].size.width==375) {
//        [self.star setFrame:CGRectMake(120, 55, 82, 15)];
//    }
//    else if ([[UIScreen mainScreen]bounds].size.width==414) {
//        [self.star setFrame:CGRectMake(110, 55, 82, 15)];
//    }
//    else if ([[UIScreen mainScreen]bounds].size.width==320) {
//        [self.star setFrame:CGRectMake(110, 55, 82, 15)];
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithDict:(CGFloat)value
{
    self.star.whichValue=value;
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.star setFrame:CGRectMake(115, 51, 82, 15)];
    
}

@end
