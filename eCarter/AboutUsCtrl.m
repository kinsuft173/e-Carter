//
//  AboutUsCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/9.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "AboutUsCtrl.h"

@interface AboutUsCtrl ()

@end

@implementation AboutUsCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HKCommen addHeadTitle:@"关于我们" whichNavigation:self.navigationItem];
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
