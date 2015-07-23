//
//  SelectCityCtrl.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/15.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlectCityDelegate <NSObject>

- (void)handleCitySelectedWithDic:(NSDictionary*)dic;

@end


@interface SelectCityCtrl : UIViewController

@property (nonatomic, weak) id<SlectCityDelegate> delegate;

@end
