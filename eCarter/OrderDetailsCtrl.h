//
//  OrderDetailsCtrl.h
//  eCarter
//
//  Created by 胡昆1 on 10/10/15.
//  Copyright © 2015 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderSingle.h"

@interface OrderDetailsCtrl : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewForReturnDetail;
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;

@property (nonatomic, strong) OrderSingle* order;

@end
