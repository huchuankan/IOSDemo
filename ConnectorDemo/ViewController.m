//
//  ViewController.m
//  ConnectorDemo
//
//  Created by huck on 2020/8/14.
//  Copyright © 2020 huck. All rights reserved.
//

#import "ViewController.h"
#import "SiriAddVC.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleList = @[@"Siri Shortcuts 集成",@"其他功能"];
    self.dataList = @[
        @[@"通过Intents",@"通过NSUserActivity"],
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
            
        default:
            break;
    }
    
}




@end
