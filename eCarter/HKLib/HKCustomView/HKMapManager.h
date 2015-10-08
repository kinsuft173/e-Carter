//
//  HKMapManager.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/8.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface HKMapManager : NSObject

@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) CLLocation* currentLocation;
@property (nonatomic, strong) NSString* strCity;
@property (nonatomic, strong) NSString* strProvince;
@property (nonatomic, strong) NSString* userCurrentLongitude;
@property (nonatomic, strong) NSString* userCurrentLatitude;

@property (strong,nonatomic)NSString *province;
@property (strong,nonatomic)NSString *city;
@property (strong,nonatomic)NSString *place;
@property (strong,nonatomic)NSString *detail;
@property (strong,nonatomic)NSString *adressType;

@property(nonatomic, strong) AMapReGeocode *regeocode;

+ (HKMapManager*)shareMgr;

- (BOOL)openAMAPWihStartCoordinate:(CLLocationCoordinate2D)startCoordinate AndEndCoordinate:(CLLocationCoordinate2D)endCoordinate;
- (void)openAPPLEMAPWihStartCoordinate:(CLLocationCoordinate2D)startCoordinate
                      AndEndCoordinate:(CLLocationCoordinate2D)endCoordinate;


- (void)locate;

- (void)recover;

@end
