//
//  MyCouponCtrl.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/29.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectCard <NSObject>

-(void)saveMoney:(NSMutableDictionary*)dic;

@end

@interface MyCouponCtrl : UIViewController
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic,assign) BOOL isCardSelected;
@property (nonatomic, strong) NSMutableDictionary *dictOfCard;
@property (nonatomic, strong) NSMutableArray *arrayOfCard;
@property (nonatomic, weak) id<selectCard> delegate;

@end
