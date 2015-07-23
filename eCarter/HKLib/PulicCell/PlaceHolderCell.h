//
//  PlaceHolderCell.h
//  ksbk
//
//  Created by 胡昆1 on 12/29/14.
//  Copyright (c) 2014 cn.chutong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol placeholderDelegate <NSObject>

- (void)refresh;

@end

@interface PlaceHolderCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* lblText;
@property (nonatomic, weak) id<placeholderDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@end
