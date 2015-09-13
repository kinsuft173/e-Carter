//
//  starView.m
//  eCarter
//
//  Created by lijingyou on 15/7/4.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "starView.h"

@implementation starView


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self initUI];
}

-(void)initUI
{
    [self.btn_image1 setTag:1];
    [self.btn_image2 setTag:2];
    [self.btn_image3 setTag:3];
    [self.btn_image4 setTag:4];
    [self.btn_image5 setTag:5];
    
    self.array_Star=[NSArray arrayWithObjects:self.img_star1,self.img_star2,self.img_star3,self.img_star4,self.img_star5, nil];
    
    [self setStarForValue:self.whichValue];
    
}

-(void)setStarForValue:(CGFloat)value
{

    
    if (self.array_Star.count == 0) {
        
        [self initUI];
    }
    self.whichValue = value;

    for (int i=0; i<self.array_Star.count; i++) {
        UIImageView *imageView=[self.array_Star objectAtIndex:i];
        
        if (i<=(value-1)) {
            [imageView setImage:[UIImage imageNamed:star_1]];
        }
        else if((value - 1 + 0.5 ) >= i)
        {
            imageView.image=[UIImage imageNamed:star_half];
            
        }else{
        
        imageView.image=[UIImage imageNamed:star_0];
        
        }
        
        
       
    }
    
//    if (value>value) {
//        UIImageView *imageView=[self.array_Star objectAtIndex:(int)value];
//        
//        [imageView setImage:[UIImage imageNamed:star_half]];
//    }
}

          
@end






