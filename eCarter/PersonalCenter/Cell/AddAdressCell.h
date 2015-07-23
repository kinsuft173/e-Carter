//
//  AddAdressCell.h
//  eCarter
//
//  Created by kinsuft173 on 15/6/28.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addAdress <NSObject>

-(void)EditMyAdress;

@end


@interface AddAdressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_commit;
@property(nonatomic,weak) id<addAdress> delegate;
@end
