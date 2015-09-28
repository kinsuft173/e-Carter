//
//  HKMapCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "HKMapCtrl.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "HKMapManager.h"
#import "MANaviRoute.h"
#import "CommonUtility.h"
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"
#import "HKCommen.h"
#import "MBProgressHUD.h"

#define MapKey @"97661ae00266c9ff0aa32c7178c64457"
const NSString *NavigationViewControllerStartTitle       = @"起点";
const NSString *NavigationViewControllerDestinationTitle = @"终点";


@interface HKMapCtrl ()<MAMapViewDelegate,AMapSearchDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) MAMapView* mapView;
@property (nonatomic, strong) AMapSearchAPI* search;
@property (nonatomic, strong) UIButton* btnLocation;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) MAPointAnnotation *destinationPoint;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) NSArray *pathPolylines;


@property (nonatomic, strong) IBOutlet UIView* viewForTitel;
@property (nonatomic, strong) IBOutlet UIButton* btnCar;
@property (nonatomic, strong) IBOutlet UIButton* btnBus;
@property (nonatomic, strong) IBOutlet UIButton* btnWalk;
@property (nonatomic, strong) NSString* strCity;
@property (nonatomic, strong) MBProgressHUD* hud;


@property (nonatomic, strong) CLLocationManager *locationManager;

/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;

@property (nonatomic) AMapSearchType searchType;
@property (nonatomic, strong) AMapRoute *route;

/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;
/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;

@property (nonatomic, strong) UIBarButtonItem *previousItem;
@property (nonatomic, strong) UIBarButtonItem *nextItem;

/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

@end

@implementation HKMapCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    [self initMap];
//    [self addDefaultAnnotations];
    [self initSearch];
    [self initControls];
    [self initAttributes];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDefaultAnnotations
{
    
    CLLocationCoordinate2D point ;
    point.latitude = 23.134412;
    point.longitude = 113.401149;
    self.startCoordinate = point ;
    
    CLLocationCoordinate2D pointD ;
    pointD.latitude =   23.137888;
    pointD.longitude = 113.329231;
    self.destinationCoordinate = pointD ;
    
    
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = (NSString*)NavigationViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];
    
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = (NSString*)NavigationViewControllerStartTitle;
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    

   
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];

}

- (void)updateTotal
{
    NSUInteger total = 0;
    
    if (self.route != nil)
    {
        switch (self.searchType)
        {
            case AMapSearchType_NaviDrive   :
            case AMapSearchType_NaviWalking : total = self.route.paths.count;    break;
            case AMapSearchType_NaviBus     : total = self.route.transits.count; break;
            default: total = 0; break;
        }
    }
    
    self.totalCourse = total;
}

/* 更新"上一个", "下一个"按钮状态. */
- (void)updateCourseUI
{
    /* 上一个. */
    self.previousItem.enabled = (self.currentCourse > 0);
    
    /* 下一个. */
    self.nextItem.enabled = (self.currentCourse < self.totalCourse - 1);
}

/* 更新"详情"按钮状态. */
- (void)updateDetailUI
{
    self.navigationItem.rightBarButtonItem.enabled = self.route != nil;
}

/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    /* 公交导航. */
    if (self.searchType == AMapSearchType_NaviBus)
    {
        self.naviRoute = [MANaviRoute naviRouteForTransit:self.route.transits[self.currentCourse]];
    }
    /* 步行，驾车导航. */
    else
    {
        MANaviAnnotationType type = self.searchType == AMapSearchType_NaviDrive? MANaviAnnotationTypeDrive : MANaviAnnotationTypeWalking;
        self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type];
    }
    
    //    [self.naviRoute setNaviAnnotationVisibility:NO];
    
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines] animated:YES];
}

/* 清空地图上已有的路线. */
- (void)clear
{
    [self.naviRoute removeFromMapView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - init and config

- (void)initUI
{
//    self.navigationItem.titleView = self.viewForTitel;
    
    [HKCommen addHeadTitle:@"地图选址" whichNavigation:self.navigationItem];
    
    if (self.strType == 1) {
        
        [HKCommen addHeadTitle:@"选择定位地点" whichNavigation:self.navigationItem];
        
    }


    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -17;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
    }else
    {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 40)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [rightButton addTarget:self action:@selector(goCommit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
}

- (void)goCommit
{
    if (self.strType == 1) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mapRefresh" object:nil];
        
    }

    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)back
{
    if (self.strType == 1) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mapRefresh" object:nil];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)initMap
{
    [MAMapServices sharedServices].apiKey = MapKey;
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self.mapView setZoomLevel:16.1 animated:YES];

}

- (void)initSearch
{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:MapKey Delegate:self];
}

- (void)initControls
{
    self.btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnLocation.frame = CGRectMake(20, CGRectGetHeight(_mapView.bounds) - 80, 40, 40);
    self.btnLocation.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.btnLocation.backgroundColor = [UIColor whiteColor];
    self.btnLocation.layer.cornerRadius = 5;
    
    [self.btnLocation addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnLocation setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    
    [self.mapView addSubview:self.btnLocation];

}





#pragma mark - Handle URL Scheme

- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSLog(@"config.appName = %@",[bundleInfo valueForKey:@"CFBundleDisplayName"]);
    return [bundleInfo valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    NSLog(@"config.appScheme = %@",scheme);
    
    return scheme;
}

- (void)locateAction
{
    if (self.mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
}


- (void)pathAction
{
//    if (_  == nil || _currentLocation == nil || _search == nil)
//    {
//        NSLog(@"path search failed");
//        return;
//    }
    
    AMapNavigationSearchRequest *request = [[AMapNavigationSearchRequest alloc] init];
    
    // 设置为步行路径规划
    request.searchType = self.searchType;
    request.city = @"广州";

    
    request.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
    request.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude longitude:self.destinationCoordinate.longitude];
    
    
    [self clear];
    [_search AMapNavigationSearch:request];
}

- (void)initAttributes
{
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _longPressGesture.delegate = self;
    [self.mapView addGestureRecognizer:_longPressGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(goOther) name:@"goDaohang" object:nil];

}


- (void)goOther
{
    NSLog(@"goOther");


}

#pragma mark - MapView Delegate

//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[MAPolyline class]])
//    {
//        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
//        
//        polylineView.lineWidth   = 4;
//        polylineView.strokeColor = [UIColor magentaColor];
//        
//        return polylineView;
//    }
//    
//    return nil;
//}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        
        polylineRenderer.lineWidth   = 6;
        polylineRenderer.strokeColor = [UIColor magentaColor];
        polylineRenderer.lineDashPattern = @[@5, @10];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 8;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation) {
        
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        _currentLocation = [userLocation.location copy];
        
    }

}

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    // 修改定位按钮状态
    if (mode == MAUserTrackingModeNone)
    {
        [self.btnLocation setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnLocation setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    // 选中定位annotation的时候进行逆地理编码查询
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"正在加载";
        
        [self reGeoAction];
    }
}


#pragma mark - AMapSearchDelegate

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    self.hud.hidden = YES;
    
    [HKCommen addAlertViewWithTitel:@"获取当前地址失败"];
    
    NSLog(@"request :%@, error :%@", request, error);
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
    self.hud.hidden = YES;
    
    NSLog(@"response :%@", response);
    
    NSString *title = response.regeocode.addressComponent.city;
    self.strCity = title;
    
    if (title.length == 0)
    {
        // 直辖市的city为空，取province
        title = response.regeocode.addressComponent.province;
    }
    
    // 更新我的位置title
    _mapView.userLocation.title = title;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
 
        
    [HKMapManager shareMgr].address = response.regeocode.formattedAddress;
    
    [HKMapManager shareMgr].regeocode = response.regeocode;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReGeocode" object:[HKMapManager shareMgr].address];
   
    
}


- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    NSLog(@"搜索回调 = %@",response);
    
    if (self.searchType != request.searchType)
    {
        return;
    }
    
    if (response.route == nil)
    {
        return;
    }
    
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    
    [self updateCourseUI];
    [self updateDetailUI];
    
    [self presentCurrentCourse];
    
}




#pragma mark - actions and funcs
- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        
        if (_destinationPoint) {
            
            request.location = [AMapGeoPoint locationWithLatitude: _destinationPoint.coordinate.latitude longitude: _destinationPoint.coordinate.longitude];
           
        }else{
        
            request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        }
        
        [_search AMapReGoecodeSearch:request];
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:[gesture locationInView:_mapView]
                                              toCoordinateFromView:_mapView];
        
        
  
        NSLog(@"坐标＝%f,%f",coordinate.latitude,coordinate.longitude);
        
        // 添加标注
        if (_destinationPoint != nil)
        {
            // 清理
            [_mapView removeAnnotation:_destinationPoint];
            _destinationPoint = nil;
            
            [_mapView removeOverlays:_pathPolylines];
            _pathPolylines = nil;
        }
        
        _destinationPoint = [[MAPointAnnotation alloc] init];
        _destinationPoint.coordinate = coordinate;
        _destinationPoint.title = @"Destination";
        
        
        
        if (self.strType!=1) {
            
        [self reGeoAction];
            
        }else{
        
            [HKMapManager shareMgr].userCurrentLongitude = [NSString stringWithFormat:@"%f",coordinate.latitude];;
            [HKMapManager shareMgr].userCurrentLatitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        }

        
        [_mapView addAnnotation:_destinationPoint];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        [polylines addObject:polyline];
        
        free(coordinates), coordinates = NULL;
    }];
    
    return polylines;
}





- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}


#pragma mark － 切换出行方式
- (IBAction)go:(UIButton*)sender
{
    if (sender == self.btnCar) {
        
        self.searchType = AMapSearchType_NaviDrive;
        
        
    }else if (sender == self.btnBus){
    
        
        self.searchType = AMapSearchType_NaviBus;
    
    
    }else if(sender == self.btnWalk){
    
        
        self.searchType = AMapSearchType_NaviWalking;
    
    }
    
    [self pathAction];

}



@end
