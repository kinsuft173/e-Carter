//
//  PlaceHolderCell.m
//  ksbk
//
//  Created by 胡昆1 on 12/29/14.
//  Copyright (c) 2014 cn.chutong. All rights reserved.
//

#import "PlaceHolderCell.h"

@implementation PlaceHolderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goRefresh:(id)sender
{
    NSLog(@"执行了没1");
    
    [self.delegate refresh];

}

@end
