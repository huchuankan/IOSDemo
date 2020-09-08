//
//  SiriAddVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/4.
//  Copyright © 2020 huck. All rights reserved.
//

#import "ActivityAddVC.h"
#import <Intents/Intents.h>
//#import "CSSearchab"

@interface ActivityAddVC ()

@property (nonatomic, strong) NSUserActivity *userActivity;

@end

@implementation ActivityAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleList = @[@"已经添加的Activity列表"];
    self.tableView.frame = CGRectMake(0, KStatusNavBarHeight + 84, KScreenWidth, ContentHeight - 84 );
    
}

- (void)viewWillAppear:(BOOL)animated {
//    [self refreshSiri];
}
//
//- (void)refreshSiri {
//    if (@available(iOS 12.0, *)) {
//        NSMutableArray *temp = [NSMutableArray array];
//        self.intentArray = [NSMutableArray array];
//        self.dataList = @[];
//
//        [[INVoiceShortcutCenter sharedCenter] getAllVoiceShortcutsWithCompletion:^(NSArray<INVoiceShortcut *> * _Nullable voiceShortcuts, NSError * _Nullable error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                for (INVoiceShortcut *voiceShortcut in voiceShortcuts) {
//                    if ([voiceShortcut.shortcut.intent isKindOfClass:[ConnectorDemoIntent class]]) {
//                        //ConnectorDemoIntent* intentHave = (ConnectorDemoIntent*)voiceShortcut.shortcut.intent;
//                        //[temp addObject:intentHave.suggestedInvocationPhrase];
//                        [temp addObject:voiceShortcut.invocationPhrase];
//                        [self.intentArray addObject:voiceShortcut];
//                    }
//                }
//                if (self.intentArray.count > 0) {
//                    self.dataList = [NSArray arrayWithObject:temp];
//                    [self.tableView reloadData];
//                }
//            });
//        }];
//    }
//    [self.tableView reloadData];
//}

-(void)itemClick:(NSInteger)tag {
//    NSInteger section = (tag - 101) / 100;
//    NSInteger row = (tag - 101) % 100;
//
//    if (@available(iOS 12.0, *)) {
//        if (section == 0) {
//            NSArray *sectionArr = self.dataList[section];
//            if (row >= 0 && row < sectionArr.count && row < self.intentArray.count ) {
//                INVoiceShortcut *intent = self.intentArray[row];
//                INUIEditVoiceShortcutViewController* vc = [[INUIEditVoiceShortcutViewController alloc] initWithVoiceShortcut:intent];
//                vc.delegate = self;
//                [self presentViewController:vc animated:YES completion:nil];
//            }
//        }
//    }
}


- (IBAction)addActivity:(UIButton *)sender {
    
//    if (@available(iOS 12.0, *)) {
//        ConnectorDemoIntent *intent = [[ConnectorDemoIntent alloc] init];
//        intent.name = @"胡船勘";
//        intent.title = @"快来看啊！";
//        intent.suggestedInvocationPhrase = @"打开";
//
//        INShortcut *shortCut = [[INShortcut alloc] initWithIntent:intent];
//        INUIAddVoiceShortcutViewController *vc = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCut];
//        vc.delegate = self;
//        [self presentViewController:vc animated:YES completion:nil];
//
//    }
    self.userActivity = [self donateSportActivity];
}

//此方法返回一个 NSUserActivity 对象。
- (NSUserActivity *)donateSportActivity{
    //根据plist文件的值，创建 UserActivity
    NSUserActivity *checkInActivity = [[NSUserActivity alloc] initWithActivityType:@"com.xxxx.xxxx-sports"];

    //设置 YES，通过系统的搜索，可以搜索到该 UserActivity
    checkInActivity.eligibleForSearch = YES;

    //允许系统预测用户行为，并在合适的时候给出提醒。（搜索界面，屏锁界面等。）
    if (@available(iOS 12.0, *)) {
        checkInActivity.eligibleForPrediction = YES;
    }

    checkInActivity.title = @"人生在于运动";

    //引导用户新建语音引导（具体效果见下图）
    if (@available(iOS 12.0, *)) {
        checkInActivity.suggestedInvocationPhrase = @"做运动";
    }

//    CSSearchableItemAttributeSet * attributes = [[CSSearchableItemAttributeSet alloc] init];
//
//    UIImage *icon = [UIImage imageNamed:@"ic_tool_sport"];
//    attributes.thumbnailData = UIImagePNGRepresentation(icon);
//
//    attributes.contentDescription = @"要坚持哦";
//
//    checkInActivity.contentAttributeSet = attributes;
//
    return checkInActivity;
}


@end
