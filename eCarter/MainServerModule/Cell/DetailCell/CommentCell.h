//
//  CommentCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"

@interface CommentCell : UITableViewCell

@property (strong,nonatomic) starView *star;
@property (strong,nonatomic) IBOutlet UIView* viewForMask1;
@property (strong,nonatomic) IBOutlet UILabel* lblPhone;
@property (strong,nonatomic) IBOutlet UILabel* lblContent;
@property (strong,nonatomic) IBOutlet UILabel* lblServerItems;
@property (strong,nonatomic) IBOutlet UILabel* lblTime;
@end
