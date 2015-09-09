//
//  SelectStoreTimeCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/8/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetail.h"

@protocol selectTime <NSObject>

-(void)pickTime:(NSString*)string;

@end

@interface SelectStoreTimeCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong,nonatomic) NSMutableArray *arrayTime;
@property (weak,nonatomic) id<selectTime> delegate;

@property (nonatomic, strong) ShopDetail* shopDetail;

@end
