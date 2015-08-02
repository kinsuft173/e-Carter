//
//  CommentCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/8/2.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "CommentCtrl.h"
#import "HKCommen.h"
#import "starView.h"

@interface CommentCtrl ()
@property (strong,nonatomic)starView *starQuality;
@property (strong,nonatomic)starView *starAttitude;
@property (strong,nonatomic)starView *starEffiency;
@end

@implementation CommentCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"发布评论" whichNavigation:self.navigationItem];
    
    self.starQuality=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    [self.starQuality setFrame:CGRectMake(0, 10, 82, 15)];
    [self.starQuality setWhichValue:3.0];
    [self.viewForStarAttitude addSubview:self.starQuality];
    
    self.starAttitude=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    [self.starAttitude setFrame:CGRectMake(0, 10, 82, 15)];
    [self.starAttitude setWhichValue:3.0];
    [self.viewForStarEffiency addSubview:self.starAttitude];
    
    
    self.starEffiency=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    [self.starEffiency setFrame:CGRectMake(0, 10, 82, 15)];
    [self.starEffiency setWhichValue:3.0];
    [self.viewForStarQuality addSubview:self.starEffiency];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
