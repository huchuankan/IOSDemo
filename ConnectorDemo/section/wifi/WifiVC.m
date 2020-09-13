//
//  WifiVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/10.
//  Copyright © 2020 huck. All rights reserved.
//

/**
获取当前链接WIFI帐号
注意 : WiFi信息只有在真机上才能获取下来,在模拟器上为NULL
1.开发者证书上配置ID支持Access WiFi Information的能力
2.Xcode配置 : Xcode -> [Project Name] -> Targets -> [Target Name] -> Capabilities -> Access WiFi Information -> ON
3.出现.entitlements文件,修改为Access WiFi Information为YES
来源：https://www.jianshu.com/p/40a917a5484b
*/


#import "WifiVC.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "WTGetLocation.h"
#import <TYAlertController.h>

@interface WifiVC ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager* locationManager;   //用于定位

@end

@implementation WifiVC

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     self = [super initWithNibName:@"BaseInfoShowVC" bundle:nibBundleOrNil];
       if (self) {
       }
       return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBtn1Name:@"获取wifi信息"];
    [self setBtn2Name:@"获取地址"];

    //获取wifi需要允许开启定位授权
    [self checkLocationAuth];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWifiSSID) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)checkLocationAuth {
    if (@available(iOS 13.0, *)) {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {//明确不让定位就提示一下
            [Util showTipPopViewTitle:@"提醒"
                              content:@"需要授权定位信息，才能获取wifi"
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
        }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
                  [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways){
            //已经开启定位功能就不管他了
            [self refreshLocation];
        }else{//其他情况弹弹框让用户授权
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self; // 设置代理
            [self.locationManager requestWhenInUseAuthorization];
        }
    }else{
        [self refreshLocation];
    }
}

//顺便获取地址玩一下(wifi获取只需要授权，不需要获得地址就可以)
-(void)refreshLocation{
    [[WTGetLocation SharedInstance] startLocation:^(NSInteger errorValue, NSString *cityName, NSString *subCityName) {
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
            [self setInfo:[NSString stringWithFormat:@"定位状态：%i--当前位置：%@%@",[CLLocationManager authorizationStatus],cityName,subCityName]];
        }
    }];
}

- (void)clickBtn2 {
    [self refreshLocation];
}

- (void)clickBtn1 {
    [self refreshWifiSSID];
}

-(void)refreshWifiSSID{
    NSString *wifiName = [Util getSSID];
    [self setInfo:[NSString stringWithFormat:@"定位状态：%i--获取的信息：%@",[CLLocationManager authorizationStatus],wifiName]];
}

/** 定位服务状态改变时调用*/
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
//            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
//            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
//                NSLog(@"定位服务开启，被拒绝");
            } else {
//                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
//            [self refreshWifiSSID];
            [self refreshLocation];
//            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
//            [self refreshWifiSSID];
            [self refreshLocation];
//            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

@end
