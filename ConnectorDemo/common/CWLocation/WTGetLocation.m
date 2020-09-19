//
//  WTGetLocation.m
//  WifiRobot
//
//  Created by dooya on 7/18/16.
//  Copyright © 2016 WifiRobot. All rights reserved.
//

#import "WTGetLocation.h"

#define locationCity    @"locationCity"
#define locationSubCity    @"locationSubCity"

@interface WTGetLocation()
{
    LocationBlock locationBlock;
}
@end

@implementation WTGetLocation

+(WTGetLocation*) SharedInstance{
    
    static WTGetLocation * wtGetLocation;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        wtGetLocation = [[self alloc] init];
//        wtGetLocation.curCity = [[NSUserDefaults standardUserDefaults] objectForKey:locationCity];
//        wtGetLocation.curSubCity = [[NSUserDefaults standardUserDefaults] objectForKey:locationSubCity];
    });
    
    return wtGetLocation;
}

-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

+(BOOL)checkLocationServiceOpen {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}

//开始定位
-(void)startLocation:(LocationBlock) result{
    
    if (![WTGetLocation checkLocationServiceOpen]) {
        result(-2,nil,nil);
    }else{//未开启定位
        self.isLocation = NO;
        locationBlock = result;
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc]init];
            [self.locationManager setDelegate:self];
        }
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [self.locationManager requestWhenInUseAuthorization]; //使用中授权
        }
//        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [self.locationManager requestAlwaysAuthorization];
//        }

        [self.locationManager startUpdatingLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [manager stopUpdatingLocation];
    
    __weak typeof(self) weakSelf = self;

    [self.geocoder reverseGeocodeWithCLLocation:newLocation Block:^(BOOL isError, NSString* cityName, NSString* subCityName) {
        weakSelf.isLocation = YES;
        weakSelf.curLocation = newLocation;
        
//        if (cityName) {
//            [[NSUserDefaults standardUserDefaults] setValue:cityName forKey:locationCity];
//        }
//        if (subCityName) {
//            [[NSUserDefaults standardUserDefaults] setValue:subCityName forKey:locationSubCity];
//        }
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        weakSelf.curCity = cityName;
        weakSelf.curSubCity = subCityName;
        
        self->locationBlock(0,cityName,subCityName);
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (kCLAuthorizationStatusDenied == status) {
        self.isLocation = YES;
        locationBlock(-2,nil,nil);
    }
}
@end
