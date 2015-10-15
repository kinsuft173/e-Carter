//
//  MoneyReturnProgressView.m
//  eCarter
//
//  Created by lijingyou on 15/8/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "MoneyReturnProgressView.h"

@implementation MoneyReturnProgressView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self initUI];
}

-(void)initUI
{
    self.arrayLongView=[NSArray arrayWithObjects:self.viewStageOne_Long,self.viewStageTwo_Long,self.viewStageThree_Long,self.viewStageFour_Long,self.viewStageFive_Long,self.viewStageSix_Long, nil];
    
    self.arrayCircle=[NSArray arrayWithObjects:self.circleStageOne,self.circleStageTwo,self.circleStageThree,self.circleStageFour,self.circleStageFive, nil];
    
    self.arrayBrief=[NSArray arrayWithObjects:self.lbl_BriefOne,self.lbl_BriefTwo,self.lbl_BriefThree,self.lbl_BriefFour, self.lbl_BriefFive, nil];
    
    self.arrayDetail=[NSArray arrayWithObjects:self.lbl_DetailOne,self.lbl_DetailTwo,self.lbl_DetailThree,self.lbl_DetailFour, self.lbl_DetailFive, nil];
    
    [self setProgressOfMoneyReturn:self.stageForMoneyReturn];
}

-(void)setProgressOfMoneyReturn:(NSUInteger)stage
{
    for (int i=0; i<5; i++) {
        UIView *viewLong=[self.arrayLongView objectAtIndex:i];
        UIImageView *viewCircle=[self.arrayCircle objectAtIndex:i];
        UILabel *brief=[self.arrayBrief objectAtIndex:i];
        UILabel *detail=[self.arrayDetail objectAtIndex:i];
        
        [viewLong setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:169.0/255.0 blue:220.0/255.0 alpha:1.0]];
        [viewCircle setImage:[UIImage imageNamed:@"Process_now"]];
        
        if (self.arrayModel.count > i) {
            
            NSDictionary* dic = [self.arrayModel objectAtIndex:i];
            
            brief.text = dic[@"name"];
            detail.text = [NSString stringWithFormat:@"%@ 已受理",dic[@"createTime"]];
            
        }

    }
    
    for (int i=(int)stage; i<5; i++) {
        UIView *viewLong=[self.arrayLongView objectAtIndex:i];
        UIImageView *viewCircle=[self.arrayCircle objectAtIndex:i];
        UILabel *brief=[self.arrayBrief objectAtIndex:i];
        UILabel *detail=[self.arrayDetail objectAtIndex:i];
        
        [viewLong setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];
        [viewCircle setImage:[UIImage imageNamed:@"Process_History"]];
        
        viewLong.hidden = YES;
        viewCircle.hidden = YES;
        brief.hidden = YES;
        detail.hidden = YES;

    }
    
    if (stage==5) {
        [self.viewStageSix_Long setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:169.0/255.0 blue:220.0/255.0 alpha:1.0]];
    }
    else
    {
    [self.viewStageSix_Long setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];
    }
}

@end
