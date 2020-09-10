//
//  ActivityAddVC.h
//  ConnectorDemo
//
//  Created by huck on 2020/9/8.
//  Copyright © 2020 huck. All rights reserved.
//
// 

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "SiriAddVC.h"

NS_ASSUME_NONNULL_BEGIN

//NSUserActivity 区别Intents的就是activity设置完成后，siri识别后自动打开App，
//而intents会有自己的展示页面可以操作，无需打开app即可完成操作
@interface NSUserActivity (sport)
- (instancetype)initWithActivityType:(NSString *)activityType title:(NSString *)title suggestedPhrase:(NSString *)phtase;
@end

@interface ActivityAddVC :SiriAddVC

@end

NS_ASSUME_NONNULL_END
