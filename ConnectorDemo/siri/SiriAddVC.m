//
//  SiriAddVC.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/4.
//  Copyright © 2020 huck. All rights reserved.
//

#import "SiriAddVC.h"
#import "ConnectorDemoIntent.h"
#import <IntentsUI/IntentsUI.h>

@interface SiriAddVC ()<INUIAddVoiceShortcutViewControllerDelegate,INUIEditVoiceShortcutViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray<INVoiceShortcut *> *intentArray API_AVAILABLE(ios(12.0));

@end

@implementation SiriAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleList = @[@"已经添加的siri列表"];
    self.tableView.frame = CGRectMake(0, KStatusNavBarHeight + 84, KScreenWidth, ContentHeight - 84 );
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshSiri];
}

- (void)refreshSiri {
    if (@available(iOS 12.0, *)) {
        NSMutableArray *temp = [NSMutableArray array];
        self.intentArray = [NSMutableArray array];
        self.dataList = @[];
        
        [[INVoiceShortcutCenter sharedCenter] getAllVoiceShortcutsWithCompletion:^(NSArray<INVoiceShortcut *> * _Nullable voiceShortcuts, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (INVoiceShortcut *voiceShortcut in voiceShortcuts) {
                    if ([voiceShortcut.shortcut.intent isKindOfClass:[ConnectorDemoIntent class]]) {
                        //ConnectorDemoIntent* intentHave = (ConnectorDemoIntent*)voiceShortcut.shortcut.intent;
                        //[temp addObject:intentHave.suggestedInvocationPhrase];
                        [temp addObject:voiceShortcut.invocationPhrase];
                        [self.intentArray addObject:voiceShortcut];
                    }
                }
                if (self.intentArray.count > 0) {
                    self.dataList = [NSArray arrayWithObject:temp];
                    [self.tableView reloadData];
                }
            });
        }];
    }
    [self.tableView reloadData];
}

-(void)itemClick:(NSInteger)tag {
    NSInteger section = (tag - 101) / 100;
    NSInteger row = (tag - 101) % 100;
    
    if (@available(iOS 12.0, *)) {
        if (section == 0) {
            NSArray *sectionArr = self.dataList[section];
            if (row >= 0 && row < sectionArr.count && row < self.intentArray.count ) {
                INVoiceShortcut *intent = self.intentArray[row];
                INUIEditVoiceShortcutViewController* vc = [[INUIEditVoiceShortcutViewController alloc] initWithVoiceShortcut:intent];
                vc.delegate = self;
                [self presentViewController:vc animated:YES completion:nil];
            }
        }
    }
}


- (IBAction)addSiri:(UIButton *)sender {
    if (@available(iOS 12.0, *)) {
        ConnectorDemoIntent *intent = [[ConnectorDemoIntent alloc] init];
        intent.name = @"胡船勘";
        intent.title = @"快来看啊！";
        intent.suggestedInvocationPhrase = @"打开";
        
        INShortcut *shortCut = [[INShortcut alloc] initWithIntent:intent];
        INUIAddVoiceShortcutViewController *vc = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCut];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
        
    }
}


#pragma mark - VoiceShortcutViewController 代理-
-(void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
API_AVAILABLE(ios(12.0)){
    [self refreshSiri];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
API_AVAILABLE(ios(12.0)){
    [self refreshSiri];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error  API_AVAILABLE(ios(12.0)){
    [self refreshSiri];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier  API_AVAILABLE(ios(12.0)){
    [self refreshSiri];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller  API_AVAILABLE(ios(12.0)){
    [self refreshSiri];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
