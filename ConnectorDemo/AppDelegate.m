//
//  AppDelegate.m
//  ConnectorDemo
//
//  Created by huck on 2020/8/14.
//  Copyright © 2020 huck. All rights reserved.
//

#import "AppDelegate.h"
#import <Intents/Intents.h>
#import "ConnectorDemoIntent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [self.window makeKeyAndVisible];
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSString *test = NSLocalizedString(@"test1", "just a testing");
    NSLog(@"%@",test);
    
    return YES;
}



// 其他方式唤起app 包括但不限于 通过siri点击后唤起app
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {

    if ([userActivity.activityType containsString:@"ConnectorDemoIntent"]){
        //处理通过 Siri intents 打开的app入口

        
    } else  if ([userActivity.activityType containsString:@"ConnectorDemoActivity"]){
        //处理通过 Siri NsUserActivity 打开的app入口
        
       }
    return YES;
}

@end
