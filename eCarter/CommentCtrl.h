//
//  CommentCtrl.h
//  eCarter
//
//  Created by lijingyou on 15/8/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewForStarQuality;
@property (weak, nonatomic) IBOutlet UIView *viewForStarAttitude;
@property (weak, nonatomic) IBOutlet UIView *viewForStarEffiency;
@property (weak, nonatomic) IBOutlet UILabel *lbl_tintInformation;
@property (weak, nonatomic) IBOutlet UITextView *txt_comment;

@property (strong,nonatomic)NSString *valueQuality;
@property (strong,nonatomic)NSString *valueAttitude;
@property (strong,nonatomic)NSString *valueEfficiency;


@property (strong,nonatomic) NSString *orderId;

@end
