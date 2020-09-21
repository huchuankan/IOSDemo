//
//  HUDUtil.m
//  Coulisse
//
//  Created by moorgen on 2017/9/4.
//  Copyright © 2017年 Coulisse. All rights reserved.
//

#import "HUDUtil.h"
#import "SVProgressHUD.h"
#import "TYAlertView+Custom.h"
#import <TYAlertController/TYAlertController.h>


@implementation HUDUtil
/**
 *  显示操作等待
 **/
+(void)showWating{
    [HUDUtil showWithStatus:@"waiting..."];
}

/**
 *  dismiss
 **/
+(void)dismiss{
    [TYAlertView hideHudView];
}

/**
 *  显示等待框
 **/
+(void)showWithStatus:(NSString*) status{
    [TYAlertView hideHudView];
    [TYAlertView showWatingWithTitle:status];
}

/**
 *  错误提示
 **/
+(void)showErrorWithStatus:(NSString*) status{
    [TYAlertView hideHudView];
    [TYAlertView showFailWithTitle:status completion:^{
        
    }];
}

+ (void)showSuccessWithStatus:(NSString *)status{
    [TYAlertView hideHudView];
    [TYAlertView showSuccessWithTitle:status
                           completion:^{
                               
                           }];
}

/**
 成功提示
 
 @param status 提示语
 */
+ (void)showSuccessWithStatus:(NSString *)status
             dismissWithDelay:(NSTimeInterval)delay
                   completion:(HUDBlock)completion{
    [TYAlertView hideHudView];
    [TYAlertView showSuccessWithTitle:status
                           completion:^{
                               completion();
                           }];
}
@end
