//
//  OrderCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/27.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getHighPicture <NSObject>

-(void)localImageShow:(NSUInteger)index TableRow:(NSUInteger)row;
-(void)networkImageShow:(NSUInteger)index TableRow:(NSUInteger)row;

@end

@interface OrderCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView* viewMask1;
@property (weak, nonatomic) IBOutlet UIButton *btnGoCommentPage;
@property (weak, nonatomic) IBOutlet UIButton *btnGoOrderDetails;

@property (assign) NSUInteger *row;

@property (weak,nonatomic) id<getHighPicture> delegate;
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

@property (weak, nonatomic) IBOutlet UIButton *btn_image1;
@property (weak, nonatomic) IBOutlet UIButton *btn_image2;
@property (weak, nonatomic) IBOutlet UIButton *btn_image3;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (nonatomic, strong) NSMutableArray* arrayImageViews;
@property (weak, nonatomic) IBOutlet UIButton *btnGoImages;
@property  (weak, nonatomic) IBOutlet UIButton *btnGoShop;
//@property (weak, nonatomic) IBOutlet UIButton *btnGoShop;

@end
