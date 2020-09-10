//
//  BaseViewController.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/10.
//  Copyright © 2020 huck. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *clsName = NSStringFromClass(self.class);
    if (clsName) {
        if([clsName hasSuffix:@"VC"]) {
            clsName = [clsName substringToIndex: clsName.length - 2];
        }
    }
    self.title = clsName;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
