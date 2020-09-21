//
//  TYAlertView+Custom.h
//  Connect
//
//  Created by moorgen on 2017/12/22.
//  Copyright © 2017年 MoorgenSmartHome. All rights reserved.
//

#import <TYAlertController/TYAlertController.h>
typedef void (^TYAlertViewDismissCompletion)(void);

@interface TYAlertView (Custom)
+(instancetype)customAlertViewWithTitle:(NSString*)title
                                content:(NSString*)content;
+(instancetype)customAlertViewWithTitle:(NSString*)title
                                content:(NSString*)content
                               btnTitle:(NSString*)btnTitle
                               btnClick:(void(^)(TYAlertView* alertView))btnClick;

+(instancetype)customAlertViewWithTitle:(NSString*)title
                                content:(NSString*)content
                           leftBtnTitle:(NSString*)leftBtnTitle
                           leftBtnClick:(void(^)(TYAlertView* alertView))leftBtnClick
                          rightBtnTitle:(NSString*)rightBtnTitle
                          rightBtnClick:(void(^)(TYAlertView* alertView))rightBtnClick;

+(void)showSuccessWithTitle:(NSString*)title
                 completion:(TYAlertViewDismissCompletion) completion;

+(void)showFailWithTitle:(NSString*)title
              completion:(TYAlertViewDismissCompletion) completion;


+(void)showWatingWithTitle:(NSString*)title;

+(void)hideHudView;

@end
