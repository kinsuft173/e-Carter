//
//  ShopCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"

@interface ShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *showStarView;
@property (weak, nonatomic) IBOutlet UIView *viewMask;
@property (strong,nonatomic) starView *star;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Evaluation;
@property (weak, nonatomic) IBOutlet UIImageView *img_Service;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Adress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Distance;
@property (weak, nonatomic) IBOutlet UIView *viewForStar;


-(void)initWithDict:(CGFloat)value;
@end
