//
//  CLGeocoder+custom.m
//
//
//  Created by apple  on 16/7/18.
//  Copyright (c) 2015年 WifiRobot. All rights reserved.
//

#import "CLGeocoder+custom.h"

@implementation CLGeocoder (custom)

- (void)reverseGeocodeWithCLLocation:(CLLocation *)location Block:(void (^)(BOOL isSuccess, NSString* cityName, NSString* subCityName))block {
    
    if (!block) {
        return;
    }

    [self reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error || placemarks.count == 0) {
            block(NO,nil,nil);
        } else {
            CLPlacemark *placemark=[placemarks firstObject];
            block(YES,placemark.locality,placemark.subLocality);
        }
    }];
}

@end
