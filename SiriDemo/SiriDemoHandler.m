//
//  SiriDemoHandler.m
//  SiriDemo
//
//  Created by huck on 2020/9/4.
//  Copyright © 2020 huck. All rights reserved.
//

#import "SiriDemoHandler.h"

@implementation SiriDemoHandler


//猜想：根据intent设置的时候是否勾选 user confirmation required， 展示不同的ui外形(是否带操作按钮，如果没操作就直接进方法，如果有操作，就等操作后进方法)
//下面这个方法是用户对 Intent UI 的操作回调，比如用户点击了图一的“执行”这个按,然后按照rsp类型或打开，或重刷siri界面
- (void)handleConnectorDemo:(ConnectorDemoIntent *)intent completion:(void (^)(ConnectorDemoIntentResponse *response))completion NS_SWIFT_NAME(handle(intent:completion:)) {
   
    //   这个方法能返回以下状态的尝试，点击按钮后
    //   ConnectorDemoIntentResponseCodeUnspecified = 0,  //抱歉出了点问题
    //   ConnectorDemoIntentResponseCodeReady,            // 抱歉出了点问题
    //   ConnectorDemoIntentResponseCodeContinueInApp, =2  //打开应用   --ok
    //   ConnectorDemoIntentResponseCodeInProgress,  //提示打开后报错
    //   ConnectorDemoIntentResponseCodeSuccess, =4   //仅仅刷新界面   --ok
    //   ConnectorDemoIntentResponseCodeFailure,  //抱歉出了点问题
    //   ConnectorDemoIntentResponseCodeFailureRequiringAppLaunch, =6  //打开应用 --ok
    //   ConnectorDemoIntentResponseCodeDone = 100,  //仅仅刷新界面
    //   ConnectorDemoIntentResponseCodeFail    //仅仅刷新界面
    
    //以上只有success 和自定义code会停留代码，且interaction.intentHandlingStatus===ConnectorDemoIntentResponseCodeInProgress
    //             rsp.code才==传过去的对应code
    
    //建议：如果只是界面停留， 在处理这里的逻辑后，根据不同处理结果，指定不同的【自定义“code】，然后在siri界面根据自定义code刷新不同的界面效果
    
    //可以根据条件做一下判断
    BOOL isLogin = YES; //NO
    
    if (@available(iOS 12.0, *)) {
        if (isLogin) {
            //做一下逻辑后按结果返回不通的数据
            ConnectorDemoIntentResponse *rsp = [[ConnectorDemoIntentResponse alloc] initWithCode:ConnectorDemoIntentResponseCodeDone userActivity:nil];
            rsp.name = @"小船来了2222";
            rsp.title = @"终于登录成功啦title22222";
            completion(rsp);
        } else  {
            ConnectorDemoIntentResponse *rsp = [[ConnectorDemoIntentResponse alloc] initWithCode:ConnectorDemoIntentResponseCodeFail userActivity:nil];
            rsp.name = @"佚名错误222";
            rsp.title = @"还没登录title22222";
            completion(rsp);
            
        }
    } else {
        ConnectorDemoIntentResponse *rsp = [[ConnectorDemoIntentResponse alloc] initWithCode:ConnectorDemoIntentResponseCodeFailureRequiringAppLaunch userActivity:nil];
        completion(rsp);
    }
    
}

//   ConnectorDemoIntentResponseCodeUnspecified = 0,  //抱歉出了点问题
//   ConnectorDemoIntentResponseCodeReady,            // 表示一切准备就绪 1-1
//   ConnectorDemoIntentResponseCodeContinueInApp, =2  //识别后直接打开应用
//   ConnectorDemoIntentResponseCodeInProgress,
//   ConnectorDemoIntentResponseCodeSuccess, =4    //3-4
//   ConnectorDemoIntentResponseCodeFailure,  //抱歉出了点问题
//   ConnectorDemoIntentResponseCodeFailureRequiringAppLaunch, =6  //识别后直接打开应用
//   ConnectorDemoIntentResponseCodeDone = 100,
//   ConnectorDemoIntentResponseCodeFail    //添加的时候没有指明是错误code，所以也和其他code一样

// 该方法是在 siri 匹配到相应的 Intent 时候调用。
// 如果用失败的方法初始化ConnectorDemoIntentResponse，在匹siri后就会报错
// 不管用哪个成功的方式，只是初始化参数的值而已，都一样
// 此为第一道拦截，如果code设置为失败或者打开app，那就直接失败/跳走了，连展示界面的机会都没有
// 所以一半这里就直接返回成功，让siri继续往下走，打开界面
// 建议：只用reday和success 这两个code
- (void)confirmConnectorDemo:(ConnectorDemoIntent *)intent completion:(void (^)(ConnectorDemoIntentResponse *response))completion NS_SWIFT_NAME(confirm(intent:completion:)) {
    
    //可以根据条件做一下判断
    BOOL isLogin = YES; //NO
    
    if (@available(iOS 12.0, *)) {
        if (isLogin) {
           
            // ConnectorDemoIntentResponseCodeReady ConnectorDemoIntentResponseCodeSuccess
            // 可以将rsp的值传过去，redaycode不变， （successcode变成3，rsp.code=4）
            ConnectorDemoIntentResponse *rsp = [[ConnectorDemoIntentResponse alloc] initWithCode:ConnectorDemoIntentResponseCodeReady userActivity:nil];
            rsp.name = [self ConnectLocalizedString:@"name"];// @"小船来了111";//多语言测试
            rsp.title = @"终于登录成功啦title111";
            completion(rsp);
        } else  {
            // 自定义的code，可以传rsp值，但是code不能传，会变成为0
            ConnectorDemoIntentResponse *rsp = [[ConnectorDemoIntentResponse alloc] initWithCode:ConnectorDemoIntentResponseCodeFail userActivity:nil];
            rsp.name = @"佚名1111";
            rsp.title = @"还没登录呢只是title11111";
            completion(rsp);
            
        }
    } else {
        ConnectorDemoIntentResponse *rsp = [[ConnectorDemoIntentResponse alloc] initWithCode:ConnectorDemoIntentResponseCodeFailure userActivity:nil];
        completion(rsp);
    }
}


- (NSString *)ConnectLocalizedString:(NSString *)translation_key {
    
    NSString * LocalizableStr = NSLocalizedString(translation_key, nil);
    
    //除了意大利语，其他都变成英语
        if (
            !([[[NSLocale preferredLanguages] objectAtIndex:0] rangeOfString:@"ko"].length >0) &&//韩国语
            !([[[NSLocale preferredLanguages] objectAtIndex:0] rangeOfString:@"it"].length >0)//意大利语
            ) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        
        LocalizableStr = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
        
    }
    
    return LocalizableStr;
}

@end
