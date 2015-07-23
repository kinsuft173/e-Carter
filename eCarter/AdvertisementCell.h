//
//  AdvertisementCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/11.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"

#define PlaceHolderImage  @"loading-ios"
#define DOCTOR_RECOMMEND_RATIO 9/16

@protocol AdvertiseDelegate <NSObject>

- (void)didSelectAdvertiseAtRow:(NSInteger)row;

@end

@interface AdvertisementCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) id<AdvertiseDelegate> delegate;

-(void)customUI:(NSMutableArray*)array;

@end
