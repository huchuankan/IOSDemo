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


@interface Person : NSObject


@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self.window makeKeyAndVisible];
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    VoltageMode mode = VoltageModeAC;
    
    NSString *test = NSLocalizedString(@"test1", "just a testing");
    NSLog(@"%@",test);
    [self  addMenuItemShortcuts];
    
    return YES;
}

- (void)addMenuItemShortcuts
{
    if (@available(iOS 12.0, *)) {
        ConnectorDemoIntent *intent = [[ConnectorDemoIntent alloc] init];
        intent.title = @"1";
        intent.name = @"2";
        intent.suggestedInvocationPhrase = NSLocalizedString(@"SIRI_SHORTCUT_CORRECT_WORK", nil);
        [[INVoiceShortcutCenter sharedCenter] setShortcutSuggestions:@[[[INShortcut alloc] initWithIntent:intent]]];
    }
}


@end
