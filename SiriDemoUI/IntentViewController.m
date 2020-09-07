//
//  IntentViewController.m
//  ConnectSiriUI
//
//  Created by 赵旭波 on 2018/12/4.
//  Copyright © 2018年 MoorgenSmartHome. All rights reserved.
//

#import "IntentViewController.h"
#import "ConnectorDemoIntent.h"
#import <Intents/Intents.h>
#import <WebKit/WebKit.h>

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

@interface IntentViewController ()

@end

@implementation IntentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - INUIHostedViewControlling


//interaction.intentHandlingStatus  对应系统创建ConnectorDemoIntentResponse中的几个状态，自创的code对应success和failer这两个code
// Prepare your view controller for the interaction to handle.
- (void)configureViewForParameters:(NSSet <INParameter *> *)parameters ofInteraction:(INInteraction *)interaction interactiveBehavior:(INUIInteractiveBehavior)interactiveBehavior context:(INUIHostedViewContext)context completion:(void (^)(BOOL success, NSSet <INParameter *> *configuredParameters, CGSize desiredSize))completion {
    // Do configuration here, including preparing views and calculating a desired size for presentation.
    

    ConnectorDemoIntentResponse *rsp = (ConnectorDemoIntentResponse *) interaction.intentResponse;
    ConnectorDemoIntent *intent = (ConnectorDemoIntent *)interaction.intent;
    
    UIColor *bgColor = [UIColor blackColor];
    //app 设置siri时候传的参数
    NSString *text =  [NSString stringWithFormat:@"%@--%@",intent.name,intent.title];
    
    //不通状态用不用背景色作区分
    if (interaction.intentHandlingStatus == ConnectorDemoIntentResponseCodeReady) {
        //只能从confirmConnectorDemo传过来
        bgColor = [UIColor redColor];
        text = [NSString stringWithFormat:@"%@--%@",rsp.name,rsp.title];
    } else if (interaction.intentHandlingStatus == ConnectorDemoIntentResponseCodeInProgress) {
       if (rsp.code == ConnectorDemoIntentResponseCodeSuccess) {
           //能从confirmConnectorDemo传过来 点按钮后从handleConnectorDemo传过来
           bgColor = [UIColor yellowColor];
           text = [NSString stringWithFormat:@"%@--%@",rsp.name,rsp.title];
       } else if (rsp.code == ConnectorDemoIntentResponseCodeDone) {
           // 只能 点按钮后从handleConnectorDemo传过来
            bgColor = [UIColor blueColor];
            text = [NSString stringWithFormat:@"%@--%@",rsp.name,rsp.title];
        } else if (rsp.code == ConnectorDemoIntentResponseCodeFail) {
            // 只能 点按钮后从handleConnectorDemo传过来
            bgColor = [UIColor greenColor];
            text = [NSString stringWithFormat:@"%@--%@",rsp.name,rsp.title];
        }
    }

    self.view.backgroundColor = bgColor;
    self.siriTitle.text = [NSString stringWithFormat: @"%zi-%zi-%@",interaction.intentHandlingStatus,rsp.code,text];

    CGRect frame = CGRectMake(0, 0, KScreenWidth - 16, 312);

//  如果想画在xib的话
//  xib中拉入UIView.(为什么拉入view呢？因为WKWebView的父类是uiview,而xib不能直接拉入WKWebView) ;
//  自定义一个类myWK，继承自wkwebview。把xib中的view的class改为myWK
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,200,frame.size.width,112)];

    [self.view addSubview:webView];
//    NSString *path;
    NSData *gif;
    if (KScreenWidth == 375) {
        gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"SiriView"ofType:@"gif"]];
//        path = [[NSBundle mainBundle] pathForResource:@"SiriView" ofType:@"gif"];
    }else{
        gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"SiriViewPlus"ofType:@"gif"]];

//        path = [[NSBundle mainBundle] pathForResource:@"SiriViewPlus" ofType:@"gif"];
    }
//    NSURL *url = [NSURL URLWithString:path];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [webView loadData:gif MIMEType:@"image/gif" characterEncodingName:@"UTF-8"  baseURL:nil];
    
    if (completion) {
        completion(YES, parameters, frame.size);
    }
}

- (CGSize)desiredSize {
    return [self extensionContext].hostedViewMaximumAllowedSize;
}

- (IBAction)btnclick:(UIButton *)sender {
}
@end
