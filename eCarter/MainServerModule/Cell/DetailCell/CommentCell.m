//
//  CommentCell.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "CommentCell.h"
#import "HKCommen.h"

@implementation CommentCell

- (void)awakeFromNib {
    
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    [self.star setFrame:CGRectMake(0, 0, 82, 15)];
    [self.viewForMask1 addSubview:self.star];
    
    [self.star setWhichValue:3.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
