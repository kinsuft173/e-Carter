//
//  EventInfoCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventInfoCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton* btnGoWebsite;
@property (weak, nonatomic) IBOutlet UITextView *txt_Details;


@end
