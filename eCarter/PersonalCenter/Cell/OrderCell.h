//
//  OrderCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView* viewMask1;
@property (weak, nonatomic) IBOutlet UIButton *btnGoCommentPage;
@property (assign) NSUInteger judgeWhichStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblServiceCompany;
@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UILabel *lblMobile;
@property (weak, nonatomic) IBOutlet UILabel *lblCarNum;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceContent;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *lblGetOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusOfOrder;
@property (weak, nonatomic) IBOutlet UIButton *lblStatusOfComment;
@property (weak, nonatomic) IBOutlet UILabel *lblCheap;
@property (weak, nonatomic) IBOutlet UILabel *lblPayment;

@property (weak, nonatomic) IBOutlet UIImageView *img_OrderPhoto1;
@property (weak, nonatomic) IBOutlet UIImageView *img_OrderPhoto2;
@property (weak, nonatomic) IBOutlet UIImageView *img_OrderPhoto3;


@end
