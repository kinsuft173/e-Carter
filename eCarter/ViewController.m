//
//  ViewController.m
//  eCarter
//
//  Created by kinsuft173 on 15/6/21.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "ViewController.h"
#import "HKCommen.h"

#define PageNumberOfScrollView 3

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray* arrayImageView;

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) UIButton* btnStart;

@property (nonatomic, strong) UIViewController* firstMainFlowCtrl;
@property (nonatomic, strong) UIPageControl* pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* strFlag = [NSString stringWithFormat:@"isFirstStartWithVersion_%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:strFlag] isEqualToString:@"YES"]) {
        
        [self goToMainUI];
        
    }else{
        
        NSLog(@"test");
        
        [self addImages];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:strFlag];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addImages
{

    UIStoryboard* storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.firstMainFlowCtrl = [storyboardMain instantiateViewControllerWithIdentifier:@"firstMainFlowCtrl"];
    self.firstMainFlowCtrl.view.userInteractionEnabled = YES;
    [self.view addSubview:self.firstMainFlowCtrl.view];
    
    self.arrayImageView = [[NSMutableArray alloc] init];
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    CGSize scrollSize;
    
    scrollSize.height = self.view.frame.size.height;
    scrollSize.width  = PageNumberOfScrollView*self.view.frame.size.width;
    
    self.scrollView.contentSize =  scrollSize;
    self.scrollView.bounces = NO;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.5*(self.view.frame.size.width -120),self.view.frame.size.height - 60, 120, 30)];
    self.pageControl.numberOfPages = 3;
    [self.pageControl addTarget:self action:@selector(goPage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.pageControl];
    
    
    for (int i = 0; i < PageNumberOfScrollView; i++) {
        
        NSLog(@"11");
        
        
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"bg%d.png",i]];
        
        
        UIImageView*  imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width,0,self.view.frame.size.width,self.view.frame.size.height)];
        
        
        imageView.image = image;
        
        NSLog(@"imageView = %@",NSStringFromCGRect(imageView.frame));
        
        [self.scrollView addSubview:imageView];
        
        [self.arrayImageView addObject:imageView];
        
        
        if (i == PageNumberOfScrollView - 1) {
            
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.backgroundColor = [UIColor redColor];
            [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            
            btn.frame = CGRectMake(self.view.frame.size.width*0.5 - 30, self.view.frame.size.height*0.8 - 25, 60, 50);
            
            
            btn.userInteractionEnabled = YES;
            [btn addTarget:self action:@selector(goMain:) forControlEvents:UIControlEventTouchUpInside ];
            
            [imageView addSubview:btn];
            
            
            self.btnStart = btn;
            
            [imageView addSubview:btn];
            
            imageView.userInteractionEnabled = YES;
        }
        
        
        
    }
    

}

- (void)goToMainUI
{
    UIStoryboard* storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.firstMainFlowCtrl = [storyboardMain instantiateViewControllerWithIdentifier:@"firstMainFlowCtrl"];
    self.firstMainFlowCtrl.view.userInteractionEnabled = YES;
    
    [self.view addSubview:self.firstMainFlowCtrl.view];

}


- (void)goMain:(UIButton*)btn
{
    NSLog(@"2sda");
    
    [UIView animateWithDuration:1  delay:0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         //                         self.scrollView.hidden = YES;
                         //                         [self.scrollView removeFromSuperview];
                         self.scrollView.alpha = 0.0;
                         [self.pageControl removeFromSuperview];
                         
                         //                         [self.view addSubview:tab.view];
                         
                    } completion:^(BOOL finished){}];
    
}


#pragma scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        
        self.pageControl.currentPage = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
        
    }

}


- (void)goPage:(UIPageControl*)pageCtrl
{
    [self.scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width*pageCtrl.currentPage, 0, self.scrollView.frame.size.height, self.scrollView.frame.size.height) animated:YES];

}


@end
