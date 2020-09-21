//
//  GoogleMapVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/19.
//  Copyright © 2020 huck. All rights reserved.
//

#import "GoogleMapVC.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <GoogleMapsBase/GoogleMapsBase.h>

#import "WTGetLocation.h"

@interface GoogleMapVC ()<GMSMapViewDelegate>
@property (nonatomic, strong) CLLocation* location;

@property (nonatomic,strong) GMSMapView *mapView;//地图
@property (nonatomic,strong) GMSMarker *marker;//大头针
@property (nonatomic,strong) UITextView *infoView;
@end

@implementation GoogleMapVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, KScreenWidth-40, 60)];
    self.infoView.layer.cornerRadius = 10;
    self.infoView.layer.masksToBounds = YES;
    self.infoView.layer.borderColor = [UIColor grayColor].CGColor;
    self.infoView.layer.borderWidth = 2;
    self.infoView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.infoView.editable = NO;
    [self.viewContent addSubview:self.infoView];
    
    [self refreshLocation];
}

-(void)refreshLocation{
    WS(weakSelf)
    [HUDUtil showWating];
    [[WTGetLocation SharedInstance] startLocation:^(NSInteger errorValue, NSString *cityName, NSString *subCityName) {
        [HUDUtil dismiss];
        if (errorValue == -2) {//不允许定位
            dispatch_async(dispatch_get_main_queue(), ^{
                [Util showTipPopViewTitle:@"提醒"
                                  content:@"您未开启定位信息是否去设置？"
                             leftBtnTitle:@"去设置"
                             leftBtnClick:^{
                                 //无权限 引导去开启
                                 NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                 if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                     [[UIApplication sharedApplication] openURL:url];
                                 }
                             }
                            rightBtnTitle:@"知道了"
                            rightBtnClick:^{
                            }];
            });
        }else if(errorValue == 0){
            self.location = [WTGetLocation SharedInstance] .curLocation;
            [weakSelf initGoogleMap];
            [self refreshCrrentLocationInfo];
        }
    }];
}

-(void)initGoogleMap {
    NSLog(@"%f-%f",self.location.coordinate.latitude,self.location.coordinate.longitude);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.location.coordinate.latitude
                                                            longitude:self.location.coordinate.longitude
                                                                 zoom:3];

    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.mapView.delegate = self; //注册代理属性
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;//显示指南针
    [self.viewContent insertSubview:self.mapView atIndex:0];
    
    CLLocationCoordinate2D position2D = CLLocationCoordinate2DMake(self.location.coordinate.latitude,self.location.coordinate.longitude);
    self.marker = [GMSMarker markerWithPosition:position2D];
    self.marker.map = self.mapView;
}

//点击地图上点回调，设定大头针
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    //点击一次先清除上一次的大头针
    [self.marker.map clear];
    self.marker.map = nil;
    // 通过location  或得到当前位置的经纬度
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.latitude longitude:coordinate.longitude zoom:mapView.camera.zoom];
    CLLocationCoordinate2D position2D = CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude);
//    self.mapView.camera = camera; //移到图中间
    //大头针
    self.marker = [GMSMarker markerWithPosition:position2D];
    self.marker.map = self.mapView;
    self.location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [self refreshCrrentLocationInfo];
}

-(void)refreshCrrentLocationInfo {
    self.infoView.text = [NSString stringWithFormat: @"经度：%f ，纬度：%f",self.location.coordinate.longitude,self.location.coordinate.latitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeWithCLLocation:self.location Block:^(BOOL isError, NSString *cityName, NSString *subCityName) {
//        if (isError == YES) {
//
//            self->_cityName = @"";
//            if (cityName.length) {
//                self->_cityName = cityName;
//            }
//
//            if (subCityName.length) {
//                self->_cityName = [NSString stringWithFormat:@"%@,%@",self->_cityName,subCityName];
//            }
//            cell.subLabel.text = self->_cityName;
//        }else{
//            cell.subLabel.text = @"";
//        }
//    }];
    
        //反地理编码
    [geocoder reverseGeocodeLocation:self.location completionHandler:^(NSArray * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            NSLog(@"error.description:%@",error.description);
            self.infoView.text = [NSString stringWithFormat: @"反编译地理位置错误！当前经度：%f ，纬度：%f",self.location.coordinate.longitude,self.location.coordinate.latitude];;
        }else{
            CLPlacemark *placemark = [placemarks firstObject];
            //赋值详细地址
            NSLog(@"定位结果---路号name:%@-市locality:%@-区subLocality:%@-省administrativeArea:%@-路thoroughfare:%@",placemark.name,placemark.locality,placemark.subLocality,placemark.administrativeArea,placemark.thoroughfare);
            self.infoView.text = [NSString stringWithFormat:@"定位结果---路号name:%@-市locality:%@-区subLocality:%@-省administrativeArea:%@-路thoroughfare:%@",placemark.name,placemark.locality,placemark.subLocality,placemark.administrativeArea,placemark.thoroughfare];
            
        }
    }];
    
    
}


@end
