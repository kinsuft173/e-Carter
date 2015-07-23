//
//  PersonInfoCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfoCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* imgHead;
@property (nonatomic, strong) IBOutlet UIImageView* imgPhone;
@property (nonatomic, strong) IBOutlet UILabel* lblName;
@property (nonatomic, strong) IBOutlet UILabel* lblPhoneNumber;

@end
