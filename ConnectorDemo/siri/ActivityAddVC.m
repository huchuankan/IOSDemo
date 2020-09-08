//
//  SiriAddVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/4.
//  Copyright © 2020 huck. All rights reserved.
//

#import "ActivityAddVC.h"
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>
#import <CoreSpotlight/CoreSpotlight.h>
//#import "NSUserActivity+sport"

@interface ActivityAddVC()

@end

@implementation ActivityAddVC

//子类继承父类中xib元件
- (instancetype)initWithNibName:(NSString* )nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:@"SiriAddVC" bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleList = @[@"已经添加的Activity列表"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// 父类方法重写
- (BOOL)checkCurrentClass:(INVoiceShortcut*)voiceShortcut API_AVAILABLE(ios(12.0)){
    BOOL flag = [voiceShortcut.shortcut.userActivity isKindOfClass:[NSUserActivity class]];
    return flag;
}

// 父类方法重写
-(INShortcut *)getINShortcut API_AVAILABLE(ios(12.0)){
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"ConnectorDemoActivity" title:@"人生在于运动" suggestedPhrase:@"做运动"];

    // 以下为附带的 在苹果搜索的时候，会搜索处图文信息，可以点击打开，打开时候和打开activity调用同一代码入口，
    // 只是简单代码示例，
    // Spotlight在iOS9上做了一些新的改进, 也就是开放了一些新的API, 通过Core Spotlight Framework你可以在你的app中集成Spotlight。集成Spotlight的App可以在Spotlight中搜索App的内容，并且通过内容打开相关页面。
    CSSearchableItemAttributeSet * attributes = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:CSSearchableItemActionType];
    UIImage *icon = [UIImage imageNamed:@"sport"];
    attributes.thumbnailData = UIImageJPEGRepresentation(icon,0.4);
    attributes.title = @"每日运动";
    attributes.keywords = @[@"每天",@"每日",@"运动",@"坚持"];  // 关键字,NSArray格式
    attributes.contentDescription = @"要坚持哦，身材越来越好，身体也越来越好";  // 描述
    activity.contentAttributeSet = attributes;

    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"123" domainIdentifier:@"domainId" attributeSet:attributes];
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * error) {
        if (error) {
            NSLog(@"indexSearchableItems Error:%@",error.localizedDescription);
            
        }
    }];
       
    return  [[INShortcut alloc] initWithUserActivity:activity];
}


@end





@implementation  NSUserActivity(sport)

- (instancetype)initWithActivityType:(NSString *)activityType title:(NSString *)title suggestedPhrase:(NSString *)phtase {
    self = [self initWithActivityType:activityType];
    if (self) {
        //设置 YES，通过系统的搜索，可以搜索到该 UserActivity
        self.eligibleForSearch = YES;

        //允许系统预测用户行为，并在合适的时候给出提醒。（搜索界面，屏锁界面等。）
        if (@available(iOS 12.0, *)) {
            self.eligibleForPrediction = YES;
        }

        self.title = title;

        //引导用户新建语音引导（具体效果见下图）
        if (phtase) {
            if (@available(iOS 12.0, *)) {
                self.suggestedInvocationPhrase = phtase;
            }
        }
    }
    return  self;
}

@end
