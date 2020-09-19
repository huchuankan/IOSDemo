//
//  BaseVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/10.
//  Copyright © 2020 huck. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

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
    self.viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, KStatusNavBarHeight, KScreenWidth, ContentHeight)];
    self.viewContent.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.viewContent atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
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
