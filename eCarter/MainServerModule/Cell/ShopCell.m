//
//  ShopCell.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ShopCell.h"
#import "HKCommen.h"

@implementation ShopCell

- (void)awakeFromNib {
    
    // Initialization code
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }

    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    
    [self.star setFrame:CGRectMake(0, 11, 82, 15)];

    [self.viewForStar addSubview:self.star];
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
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 12.0 - SINGLE_LINE_ADJUST_OFFSET, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
    headView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    UIView *underView=[[UIView alloc]initWithFrame:CGRectMake(0, 128.0 - SINGLE_LINE_ADJUST_OFFSET, [UIScreen mainScreen].bounds.size.width,SINGLE_LINE_WIDTH)];
    underView.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    [self.contentView addSubview:headView];
    [self.contentView addSubview:underView];
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
    
}

@end
