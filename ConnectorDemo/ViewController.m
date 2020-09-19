//
//  ViewController.m
//  ConnectorDemo
//
//  Created by huck on 2020/8/14.
//  Copyright © 2020 huck. All rights reserved.
//

#import "ViewController.h"
#import "SiriAddVC.h"
#import "ActivityAddVC.h"
#import "WifiVC.h"
#import "NetWorkVC.h"
//#import "GoogleMapVC.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.titleList = @[
        @"Siri Shortcuts 集成",
        @"wifi和网络信号",
        @"谷歌地图（要翻墙）",
        @"其他功能"
    ];
    self.dataList = @[
        @[@"通过Intents",@"通过NSUserActivity"],
        @[@"获取手机wifi的信息",@"获取手机网络类型和强度"],
        @[@"谷歌地图接入"],//AIzaSyAJ1imjw4IYry_h2jBD_gx5ZZ3AjpRxtFQ
        @[@"其他功能"]
    ];
}


-(void)itemClick:(NSInteger)tag {
    NSLog(@"---%zi----",tag);
    BaseVC *vc = nil;
    switch (tag) {
        case 101:
        {
            vc = [[SiriAddVC alloc] init];
        }
            break;
        case 102:
        {
            vc = [[ActivityAddVC alloc] init];
        }
            break;
        case 201:
        {
            vc = [[WifiVC alloc] init];
        }
            break;
        case 202:
        {
            vc = [[NetWorkVC alloc] init];
        }
            break;
        case 301:
        {
            //打开注释使用谷歌地图，
            //谷歌地图使用，编译报错，去GoogleMapVC.h查看使用方式
//            vc = [[GoogleMapVC alloc] init];
        }
            break;

                       
        default:
            break;
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




@end
