//
//  HKMapManager.m
//  eCarter
//
//  Created by kinsuft173 on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "HKMapManager.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "HKCommen.h"

//#import <CoreLocation/CoreLocation.h>

@interface HKMapManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSString* preUserCurrentLongitude;
@property (nonatomic, strong) NSString* preUserCurrentLatitude;

@end

@implementation HKMapManager

+ (HKMapManager*)shareMgr
{
    static HKMapManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[HKMapManager alloc] init];
        
        [instance locate];

    });
    
    return instance;
}


- (BOOL)openAMAPWihStartCoordinate:(CLLocationCoordinate2D)startCoordinate
                  AndEndCoordinate:(CLLocationCoordinate2D)endCoordinate
{

    
    MARouteConfig *config = [MARouteConfig new];
    config.appName = [self getApplicationName];
    config.appScheme = [self getApplicationScheme];
    config.startCoordinate = startCoordinate;
    config.destinationCoordinate = endCoordinate;
    config.routeType = MARouteSearchTypeDriving;
    
    if ([MAMapURLSearch openAMapRouteSearch:config]) {
        
        return YES;
    }
    
    return NO;


}

- (void)openAPPLEMAPWihStartCoordinate:(CLLocationCoordinate2D)startCoordinate
                  AndEndCoordinate:(CLLocationCoordinate2D)endCoordinate
{
    
    //起点
    
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:startCoordinate addressDictionary:nil]];
    
    //目的地的位置
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoordinate addressDictionary:nil]];
    
    toLocation.name = @"目的地";
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES }; //打开苹果自身地图应用，并呈现特定的item
    
    [MKMapItem openMapsWithItems:items launchOptions:options];
    
}



#pragma mark - Handle URL Scheme

- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
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
    
    return scheme;
}

#pragma mark - location
//Location

- (void)locate
{
    
    if([CLLocationManager locationServicesEnabled]) {
        
        
        self.locationManager = [[CLLocationManager alloc] init] ;
        
        //要求CLLocationManager对象返回全部结果
        [_locationManager setDistanceFilter:kCLDistanceFilterNone];
        
        //要求CLLocationManager对象的返回结果尽可能的精准
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        self.locationManager.delegate = self;
        
    }else {
        
        //提示用户无法进行定位操作
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
    }
    
    // 开始定位
    
    if (IOS8) {
        
        [self.locationManager  requestAlwaysAuthorization];
        
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 5.0)
    {
        [manager stopUpdatingLocation];
        
        printf("latitude %+.6f, longitude %+.6f\n",
               newLocation.coordinate.latitude,
               newLocation.coordinate.longitude);
    }
    // else skip the event and process the next one.
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    
    CLLocation *currentLocation = [locations lastObject];
    
    self.currentLocation = currentLocation;
    
   self.userCurrentLongitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    self.userCurrentLatitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    
    self.preUserCurrentLongitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    self.preUserCurrentLatitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    
    // 获取当前所在的城市名
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //根据经纬度反向地理编译出地址信息
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     
     {
         
         NSLog(@"有没执行地理");
         
         if (array.count > 0)
             
         {
             
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //将获得的所有信息显示到label上
             
             NSLog(@"城市信息%@",placemark.name);
             
             //获取城市
             NSString *city = placemark.locality;
             
             if (!city) {
                 
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 
                 city = placemark.administrativeArea;
                 
             }
             
             self.strProvince = placemark.administrativeArea;
             
            NSLog(@"省份信息%@",self.strProvince);
             
             self.strCity = city;
             
             if (self.strCity.length > 2) {
                 
                 self.strCity = [self.strCity substringToIndex:2];
             }
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"hehe" object:nil];
             
         }
         
         else if (error == nil && [array count] == 0)
             
         {
             
             NSLog(@"No results were returned.");
             
         }
         
         else if (error != nil)
             
         {
             
             NSLog(@"An error occurred = %@", error);
             
         }
         
         
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    
    [manager stopUpdatingLocation];
    
}


- (void)locationManager:(CLLocationManager *)manager

       didFailWithError:(NSError *)error {
    
    
    
    if (error.code == kCLErrorDenied) {
        
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        
    }
    
}

- (void)recover
{
    self.userCurrentLatitude = self.preUserCurrentLatitude;
    self.userCurrentLongitude = self.preUserCurrentLongitude;

}




@end
