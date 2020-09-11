//
//  WifiVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/10.
//  Copyright © 2020 huck. All rights reserved.
//

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
    [self hideBtn2:YES];
    [self setBtn1Name:@"获取wifi信息"];
    //获取wifi需要允许开启定位授权
    [self checkLocationAuth];
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

//顺便获取地址玩一下
-(void)refreshLocation {
    
}


- (void)clickBtn1 {
    [self refreshWifiSSID];
}

-(void)refreshWifiSSID{
    NSString *wifiName = [Util getSSID];

    [self setInfo:[NSString stringWithFormat:@"定位状态：%i--获取的信息：%@",[CLLocationManager authorizationStatus],wifiName]];
//    if (self.wifiNameTf.text.length == 0) {
//        [Util showTipPopViewTitle:LocalString(localError) content:LocalString(localPlsChooseWifi)];
//    }
}

/**
 获取当前链接WIFI帐号
 @return WI-FI帐号
 注意 : WiFi信息只有在真机上才能获取下来,在模拟器上为NULL
 1.开发者证书上配置ID支持Access WiFi Information的能力
 2.Xcode配置 : Xcode -> [Project Name] -> Targets -> [Target Name] -> Capabilities -> Access WiFi Information -> ON
 3.出现.entitlements文件,修改为Access WiFi Information为YES
  来源：https://www.jianshu.com/p/1e10b927c2ca
 */
- (NSString *)getSSIDInfo{
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSString *ssid = @"";
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        ssid = info[@"SSID"];
    }
    return ssid;
}



/**
 获取SSID --wifi名称
 */

- (NSString *)getSSID

{

    NSString *ssid = @"";

    CFArrayRef myArray = CNCopySupportedInterfaces();

    if (myArray != nil) {

        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));

        if (myDict != nil) {

            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);

            ssid = [dict valueForKey:@"SSID"];

        }

    }

    return ssid;

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
            [self refreshWifiSSID];
            [self refreshLocation];
//            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            [self refreshWifiSSID];
            [self refreshLocation];
//            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

@end
