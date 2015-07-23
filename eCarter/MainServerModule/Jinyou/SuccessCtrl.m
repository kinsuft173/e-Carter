//
//  SuccessCtrl.m
//  eCarter
//
//  Created by lijingyou on 15/7/5.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "SuccessCtrl.h"

@interface SuccessCtrl ()

@end

@implementation SuccessCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lbl_Information.text=@"您已预约成功，广州赏下汽车服务中心很高兴为您服务，稍后会有接车员与您联系，请您保持手机畅通。";
    
    [HKCommen addHeadTitle:@"预约成功" whichNavigation:self.navigationItem];
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
