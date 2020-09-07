//
//  IntentHandler.m
//  SiriDemo
//
//  Created by huck on 2020/9/4.
//  Copyright © 2020 huck. All rights reserved.
//

#import "IntentHandler.h"
#import "SiriDemoHandler.h"
#import "ConnectorDemoIntent.h"

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

@interface IntentHandler ()
@end

@implementation IntentHandler


//是整个 Intents Extension 的入口，当 siri 通过语音指令匹配到对于的 Intent , 该方法就会被执行。这里我 return 我创建一个 SiriDemoHandler 类，该类准守ConnectorDemoIntentHandling协议。 用来处理匹配到 Intent 后的 UI 显示以及后续操
- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    if ([intent isKindOfClass:[ConnectorDemoIntent class]]) {
        return [[SiriDemoHandler alloc] init];
    }
    return intent;
}



@end
