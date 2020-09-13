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

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.titleList = @[
        @"Siri Shortcuts 集成",
        @"wifi",
        @"其他功能"
    ];
    self.dataList = @[
        @[@"通过Intents",@"通过NSUserActivity"],
        @[@"获取手机wifi的信息"],
        @[@"其他功能"]
    ];
}


-(void)itemClick:(NSInteger)tag {
    NSLog(@"---%zi----",tag);
    switch (tag) {
        case 101:
        {
            SiriAddVC *vc = [[SiriAddVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 102:
        {
            ActivityAddVC *vc = [[ActivityAddVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 201:
        {
            WifiVC  *vc = [[WifiVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 301:
        {
  
        }
            break;

                       
        default:
            break;
    }
    
}




@end
