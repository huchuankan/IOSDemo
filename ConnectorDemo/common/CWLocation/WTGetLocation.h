//
//  WTGetLocation.h
//  WifiRobot
//
//  Created by dooya on 7/18/16.
//  Copyright © 2016 WifiRobot. All rights reserved.
//

#import "Constant.h"
#import "CLGeocoder+custom.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void(^LocationBlock)(NSInteger errorValue, NSString* cityName, NSString* subCityName);

@interface WTGetLocation : NSObject<CLLocationManagerDelegate>

//是否定位成功
@property(nonatomic) BOOL isLocation;

//当前定位城市
@property(nonatomic,strong)NSString* curCity;

//当前定位到的区
@property(nonatomic,strong)NSString* curSubCity;

@property(nonatomic,strong)CLGeocoder *geocoder;//定位

@property(nonatomic,strong)CLLocation *curLocation;

@property (nonatomic,strong) CLLocationManager * locationManager;

/**
 *  定位单例
 *
 */
+(WTGetLocation*) SharedInstance;

//开始定位
-(void)startLocation:(LocationBlock) result;

//判断校验条件
+(BOOL)checkLocationServiceOpen;
@end
