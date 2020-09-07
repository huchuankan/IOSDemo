//
//  SiriDemoHandler.h
//  SiriDemo
//
//  Created by huck on 2020/9/4.
//  Copyright © 2020 huck. All rights reserved.
//

#import <Intents/Intents.h>
#import "ConnectorDemoIntent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SiriDemoHandler : INExtension <ConnectorDemoIntentHandling>

@end

NS_ASSUME_NONNULL_END
