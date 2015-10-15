//
//  MoneyReturnProgressView.h
//  eCarter
//
//  Created by lijingyou on 15/8/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyReturnProgressView : UIView

@property (assign)NSUInteger stageForMoneyReturn;

@property (strong,nonatomic)NSArray *arrayLongView;
@property (strong,nonatomic)NSArray *arrayCircle;
@property (strong,nonatomic)NSArray *arrayBrief;
@property (strong,nonatomic)NSArray *arrayDetail;

@property (weak, nonatomic) IBOutlet UIView *viewStageOne_Long;
@property (weak, nonatomic) IBOutlet UIView *viewStageTwo_Long;
@property (weak, nonatomic) IBOutlet UIView *viewStageThree_Long;
@property (weak, nonatomic) IBOutlet UIView *viewStageFour_Long;
@property (weak, nonatomic) IBOutlet UIView *viewStageFive_Long;
@property (weak, nonatomic) IBOutlet UIView *viewStageSix_Long;

@property (weak, nonatomic) IBOutlet UIImageView *circleStageOne;
@property (weak, nonatomic) IBOutlet UIImageView *circleStageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *circleStageThree;
@property (weak, nonatomic) IBOutlet UIImageView *circleStageFour;
@property (weak, nonatomic) IBOutlet UIImageView *circleStageFive;


@property (weak, nonatomic) IBOutlet UILabel *lbl_BriefOne;
@property (weak, nonatomic) IBOutlet UILabel *lbl_BriefTwo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_BriefThree;
@property (weak, nonatomic) IBOutlet UILabel *lbl_BriefFour;
@property (weak, nonatomic) IBOutlet UILabel *lbl_BriefFive;

@property (weak, nonatomic) IBOutlet UILabel *lbl_DetailOne;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DetailTwo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DetailThree;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DetailFour;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DetailFive;

@property (nonatomic, strong) NSArray* arrayModel;

@end
