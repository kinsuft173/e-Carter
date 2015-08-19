//
//  SelectProvinceCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/8/18.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectProvince <NSObject>

-(void)pickCarProvince:(NSString*)string;

@end

@interface SelectProvinceCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak,nonatomic) id<selectProvince> delegate;

@end
