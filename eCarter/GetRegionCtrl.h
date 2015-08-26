//
//  GetRegionCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/8/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectAdress <NSObject>

-(void)pickAdress:(NSString*)string;

@end

@interface GetRegionCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong,nonatomic) NSMutableArray *arrayOfRegion;

@property (strong,nonatomic) NSString *region;
@property (strong,nonatomic) NSString *totalAdress;
@property (weak,nonatomic) id<selectAdress> delegate;
@end
