//
//  CLGeocoder+custom.h
//
//
//  Created by apple  on 16/7/18.
//  Copyright (c) 2015年 WifiRobot. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLGeocoder (custom)


/**
 *  反编译GPS坐标点 判断坐标点位置是否在中国境内
 *
 *  @param location GPS坐标点
 *  @param block    isError 是否出错 /  cityName 城市名
 */
- (void)reverseGeocodeWithCLLocation:(CLLocation *)location Block:(void (^)(BOOL isSuccess, NSString* cityName, NSString* subCityName))block;

@end
