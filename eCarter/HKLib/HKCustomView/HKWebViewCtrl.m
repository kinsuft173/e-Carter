//
//  HKWebViewCtrl.m
//  ksbk
//
//  Created by 胡昆1 on 7/1/15.
//  Copyright (c) 2015 cn.chutong. All rights reserved.
//

#import "HKWebViewCtrl.h"

@interface HKWebViewCtrl ()

@property (nonatomic, strong) IBOutlet UIWebView* webView;

@end

@implementation HKWebViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tabBarController.tabBar.hidden = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strUrl]]];
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
