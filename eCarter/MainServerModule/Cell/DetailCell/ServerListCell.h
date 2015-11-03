//
//  ServerListCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/23.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img_Button;
@property (strong, nonatomic) IBOutlet UILabel* lblSeverName;
@property (strong, nonatomic) IBOutlet UILabel* lblServerPrice;
@property (strong, nonatomic) IBOutlet UILabel* lblSeverOriginPrice;
@property (strong, nonatomic) IBOutlet UILabel* lblSeverLine;

@end
