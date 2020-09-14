//
//  NetWorkVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/14.
//  Copyright © 2020 huck. All rights reserved.
//

#import "NetWorkVC.h"

#import <Reachability.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
@interface NetWorkVC ()

@property (nonatomic) Reachability *hostReachability;

@end

@implementation NetWorkVC

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     self = [super initWithNibName:@"BaseInfoShowVC" bundle:nibBundleOrNil];
       if (self) {
       }
       return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBtn1Name:@"获取网络类型"];
    [self setBtn2Name:@"实时信号强度"];
    
    
    //以下代码一般写在AppDelegate中，然后hostReachability设为AppDelegate的属性供调用
    //添加SystemConfiguration.framework框架
    //参考：https://blog.csdn.net/howlaa/article/details/78899221
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [reach startNotifier];
    self.hostReachability = reach;
    WS(weakSelf)
    self.hostReachability.reachableBlock = ^(Reachability * reachability){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络变化回调，当前网络类型：%@",[weakSelf getNetworkName: reachability.currentReachabilityStatus]);
        });
    };
    self.hostReachability.unreachableBlock = ^(Reachability * reachability){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络变化回调，当前网络类型：%@",[weakSelf getNetworkName: reachability.currentReachabilityStatus]);
        });
    };
    
}

- (void)clickBtn1 {
    [self setInfo: [NSString stringWithFormat:@"当前网络类型：%@",[self getNetworkName: self.hostReachability.currentReachabilityStatus]]];
}
    
- (void)clickBtn2 {
    if (self.hostReachability.currentReachabilityStatus == ReachableViaWiFi) {
        [self setInfo: [NSString stringWithFormat:@"当前wifi信号强度：%zi",[self getWifiSignalStrength]]];
    } else {
        [self setInfo: [NSString stringWithFormat:@"当前网络信号类型：%@",[self getNetTypeByStatusBar]]];
    }
}

- (NSString *)getNetworkName:(NetworkStatus)status {
    NSString *net = @"WIFI";
    switch (status) {
        case ReachableViaWiFi:
            net = @"WIFI";
            net = [NSString stringWithFormat:@"WIFI，信号强度:%zi",[self getWifiSignalStrength]];
            break;
        case ReachableViaWWAN:
            net = [NSString stringWithFormat:@"蜂窝数据(运营商卡的类型):%@",[self getNetType ]];
            break;
        case NotReachable:
            net = @"当前无网络连接";
        default:
            break;
    }
    return net;
}

//手机自带网络，可以使用系统自带的获取运营商信息API来判断是2G、3G还是4G，这就要使用到CTTelephonyNetworkInfo这类，记得在工程添加CoreTelephony.framework，并导入头文件、
//这个是通过手机卡服务商的特点决定的，是卡的的固定属性，如果需要获取当前手机的时时蜂窝网络的网络状态，请参考getNetTypeByStatusBar
- (NSString *)getNetType {
    
    NSString *netconnType = @"";
    NSString *currentStatus = @"未知";
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    if (@available(iOS 12, *)) {
        if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
            NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
            if (radioDic.allKeys.count) {
                currentStatus = [radioDic objectForKey:radioDic.allKeys[0]];
            }
        }
    } else {
        currentStatus = [info currentRadioAccessTechnology];
    }

    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
        netconnType = @"GPRS";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        netconnType = @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
        netconnType = @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
        netconnType = @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
        netconnType = @"2G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
        netconnType = @"HRPD";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
        netconnType = @"4G";
    }
    return netconnType;
}



//获取当前手机的网络的信号类型
//兼容ios13
//虽然各种直接获取信号强度的api都被封杀了。但是还有一个另类的黑魔法可以获取到。那就是遍历UIStatusBar了
//参考：https://www.jianshu.com/p/7f80f669b7ba
- (NSString *)getNetTypeByStatusBar{
    UIApplication *app = [UIApplication sharedApplication];
    id statusBar = nil;
//    判断是否是iOS 13
    NSString *network = @"";
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
            UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
            if ([localStatusBar respondsToSelector:@selector(statusBar)]) {
                statusBar = [localStatusBar performSelector:@selector(statusBar)];
            }
        }
#pragma clang diagnostic pop

        if (statusBar) {
//            UIStatusBarDataCellularEntry
            id currentData = [[statusBar valueForKeyPath:@"_statusBar"] valueForKeyPath:@"currentData"];
            id _wifiEntry = [currentData valueForKeyPath:@"wifiEntry"];
            id _cellularEntry = [currentData valueForKeyPath:@"cellularEntry"];
            if (_wifiEntry && [[_wifiEntry valueForKeyPath:@"isEnabled"] boolValue]) {
//                If wifiEntry is enabled, is WiFi.
                network = @"WIFI";
            } else if (_cellularEntry && [[_cellularEntry valueForKeyPath:@"isEnabled"] boolValue]) {
                NSNumber *type = [_cellularEntry valueForKeyPath:@"type"];
                if (type) {
                    switch (type.integerValue) {
                        case 0:
//                            无sim卡
                            network = @"NONE";
                            break;
                        case 1:
                            network = @"1G";
                            break;
                        case 4:
                            network = @"3G";
                            break;
                        case 5:
                            network = @"4G";
                            break;
                        default:
//                            默认WWAN类型
                            network = @"WWAN";
                            break;
                            }
                        }
                    }
                }
    } else {
        statusBar = [app valueForKeyPath:@"statusBar"];

        if ([self isLiuHaiScreen]) {//刘海屏
            id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
            UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
            NSArray *subviews = [[foregroundView subviews][2] subviews];
            
            if (subviews.count == 0) {
                //                    iOS 12
                id currentData = [statusBarView valueForKeyPath:@"currentData"];
                id wifiEntry = [currentData valueForKey:@"wifiEntry"];
                if ([[wifiEntry valueForKey:@"_enabled"] boolValue]) {
                    network = @"WIFI";
                }else {
                    //                    卡1:
                    id cellularEntry = [currentData valueForKey:@"cellularEntry"];
                    //                    卡2:
                    id secondaryCellularEntry = [currentData valueForKey:@"secondaryCellularEntry"];
                    
                    if (([[cellularEntry valueForKey:@"_enabled"] boolValue]|[[secondaryCellularEntry valueForKey:@"_enabled"] boolValue]) == NO) {
                        //                            无卡情况
                        network = @"NONE";
                    }else {
                        //                            判断卡1还是卡2
                        BOOL isCardOne = [[cellularEntry valueForKey:@"_enabled"] boolValue];
                        int networkType = isCardOne ? [[cellularEntry valueForKey:@"type"] intValue] : [[secondaryCellularEntry valueForKey:@"type"] intValue];
                        switch (networkType) {
                            case 0://无服务
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", @"NONE"];
                                break;
                            case 3:
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", @"2G/E"];
                                break;
                            case 4:
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", @"3G"];
                                break;
                            case 5:
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", @"4G"];
                                break;
                            default:
                                break;
                        }
                        
                    }
                }
                
            }else {
                
                for (id subview in subviews) {
                    if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                        network = @"WIFI";
                    }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                        network = [subview valueForKeyPath:@"originalText"];
                    }
                }
            }
            
        }else {
            //                非刘海屏
            UIView *foregroundView = [statusBar valueForKeyPath:@"foregroundView"];
            NSArray *subviews = [foregroundView subviews];
            
            for (id subview in subviews) {
                if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                    int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
                    switch (networkType) {
                        case 0:
                            network = @"NONE";
                            break;
                        case 1:
                            network = @"2G";
                            break;
                        case 2:
                            network = @"3G";
                            break;
                        case 3:
                            network = @"4G";
                            break;
                        case 5:
                            network = @"WIFI";
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }

    if ([network isEqualToString:@""]) {
        network = @"NO DISPLAY";
    }
    return network;
}


//获取当前wifi的信号强度
//兼容ios13
//虽然各种直接获取信号强度的api都被封杀了。但是还有一个另类的黑魔法可以获取到。那就是遍历UIStatusBar了
//参考：https://www.jianshu.com/p/7f80f669b7ba
- (NSInteger) getWifiSignalStrength {
    int signalStrength = 0;
    //    判断类型是否为WIFI
    if (self.hostReachability.currentReachabilityStatus == ReachableViaWiFi) {
        //        判断是否为iOS 13
        if (@available(iOS 13.0, *)) {
            UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager;
            
            id statusBar = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
                UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
                if ([localStatusBar respondsToSelector:@selector(statusBar)]) {
                    statusBar = [localStatusBar performSelector:@selector(statusBar)];
                }
            }
#pragma clang diagnostic pop
            if (statusBar) {
                id currentData = [[statusBar valueForKeyPath:@"_statusBar"] valueForKeyPath:@"currentData"];
                id wifiEntry = [currentData valueForKeyPath:@"wifiEntry"];
                if ([wifiEntry isKindOfClass:NSClassFromString(@"_UIStatusBarDataIntegerEntry")]) {
                    //                    层级：_UIStatusBarDataNetworkEntry、_UIStatusBarDataIntegerEntry、_UIStatusBarDataEntry
                    
                    signalStrength = [[wifiEntry valueForKey:@"displayValue"] intValue];
                }
            }
        }else {
            UIApplication *app = [UIApplication sharedApplication];
            id statusBar = [app valueForKey:@"statusBar"];
            if ([self isLiuHaiScreen]) {
                //                刘海屏
                id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
                UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
                NSArray *subviews = [[foregroundView subviews][2] subviews];
                
                if (subviews.count == 0) {
                    //                    iOS 12
                    id currentData = [statusBarView valueForKeyPath:@"currentData"];
                    id wifiEntry = [currentData valueForKey:@"wifiEntry"];
                    signalStrength = [[wifiEntry valueForKey:@"displayValue"] intValue];
                    //                    dBm
                    //                    int rawValue = [[wifiEntry valueForKey:@"rawValue"] intValue];
                }else {
                    for (id subview in subviews) {
                        if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                            signalStrength = [[subview valueForKey:@"_numberOfActiveBars"] intValue];
                        }
                    }
                }
            }else {
                //                非刘海屏
                UIView *foregroundView = [statusBar valueForKey:@"foregroundView"];
                
                NSArray *subviews = [foregroundView subviews];
                NSString *dataNetworkItemView = nil;
                
                for (id subview in subviews) {
                    if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                        dataNetworkItemView = subview;
                        break;
                    }
                }
                
                signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
                
                return signalStrength;
            }
        }
    }
    return signalStrength;
}

//刘海屏
-(BOOL)isLiuHaiScreen {
    return KiPhoneX;
}

@end
