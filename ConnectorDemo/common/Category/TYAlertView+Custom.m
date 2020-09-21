//
//  TYAlertView+Custom.m
//  Connect
//
//  Created by moorgen on 2017/12/22.
//  Copyright © 2017年 MoorgenSmartHome. All rights reserved.
//

#import "TYAlertView+Custom.h"
#import "UIImage+Custom.h"
#import "UIView+TYAutoLayout.h"
#import "UIView+TYAlertView.h"
#import "UIImageView+Connector.h"


#define kMaximumDismissTimeInterval  10
#define kMinimumDismissTimeInterval  1.5

TYAlertViewDismissCompletion dismissBlock;
TYAlertView* hudAlertView = nil;

@implementation TYAlertView (Custom)
+(instancetype)customAlertViewWithTitle:(NSString*)title
                                content:(NSString*)content{
    TYAlertView* alertView = [TYAlertView alertViewWithTitle:title
                                                     message:content];
    alertView.alertViewWidth = 300.f;
    alertView.contentViewSpace = 21.f;
    alertView.textLabelSpace = 21.f;//title与message间距
    alertView.textLabelContentViewEdge = 14.f;//text距离左右两边的间隔
    [alertView.titleLable setFont:Font(18)];
    [alertView.titleLable setTextColor:colorFor29456F];
    [alertView.messageLabel setFont: Font(14)];

    [alertView.messageLabel setTextColor:colorFor7E91AD];
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 10.f;
    
    alertView.buttonHeight = 64.f;
    alertView.buttonSpace = .0f;
    alertView.buttonCornerRadius = 0.0f;
    alertView.buttonContentViewEdge = 1.f;
    alertView.buttonDefaultBgColor = [UIColor whiteColor];
    alertView.buttonCancelBgColor = [UIColor whiteColor];
    
    return alertView;
}

+(instancetype)customAlertViewWithTitle:(NSString*)title
                                content:(NSString*)content
                               btnTitle:(NSString*)btnTitle
                               btnClick:(void(^)(TYAlertView* alertView))btnClick{
    
    TYAlertView* alertView = [self customAlertViewWithTitle:title
                                                   content:content];
    
    TYAlertAction* doneAction = [TYAlertAction actionWithTitle:title
                                                         style:1
                                                       handler:^(TYAlertAction *action) {
                                                           btnClick(alertView);
                                                       }];
    [alertView addAction:doneAction];
    
    for (UIView* view in alertView.subviews) {
        for (UIView* subView in view.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton* btn = (UIButton*)subView;
                if ([btn.titleLabel.text isEqualToString:btnTitle]) {
                    [btn setTitleColor:colorFor438AF3 forState:UIControlStateNormal];
                    [btn.titleLabel setFont:Font(16)];
                    [btn.superview.superview removeConstraintWithView:btn.superview attribute:NSLayoutAttributeBottom];
                    [btn.superview.superview removeConstraintWithView:btn.superview attribute:NSLayoutAttributeRight];
                    [btn.superview.superview removeConstraintWithView:btn.superview attribute:NSLayoutAttributeLeft];
                    [btn.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(btn.superview.superview).with.offset(0);
                        make.right.equalTo(btn.superview.superview).with.offset(0);
                        make.bottom.equalTo(btn.superview.superview).with.offset(0);
                        make.height.mas_equalTo(@64);
                    }];
                    
                    UIView* hLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.alertViewWidth, 1)];
                    [hLineView setBackgroundColor:HexRGB(0xD1D8E0)];
                    [alertView addSubview:hLineView];
                    [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(alertView).with.offset(0);
                        make.bottom.equalTo(btn.superview.mas_top).with.offset(0);
                        make.size.mas_equalTo(CGSizeMake(alertView.alertViewWidth, 0.5));
                    }];
                    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(alertView.alertViewWidth, 64)] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(alertView.alertViewWidth, 64)] forState:UIControlStateHighlighted];
                }
            }
        }
    }
    
    return alertView;
}

+(instancetype)customAlertViewWithTitle:(NSString*)title
                                content:(NSString*)content
                           leftBtnTitle:(NSString*)leftBtnTitle
                           leftBtnClick:(void(^)(TYAlertView* alertView))leftBtnClick
                          rightBtnTitle:(NSString*)rightBtnTitle
                          rightBtnClick:(void(^)(TYAlertView* alertView))rightBtnClick{
    TYAlertView* alertView = [self customAlertViewWithTitle:title content:content];
    TYAlertAction* leftAction = [TYAlertAction actionWithTitle:leftBtnTitle
                                                         style:1
                                                       handler:^(TYAlertAction *action) {
                                                           leftBtnClick(alertView);
                                                       }];
    TYAlertAction* rightAction = [TYAlertAction actionWithTitle:rightBtnTitle
                                                          style:1
                                                        handler:^(TYAlertAction *action) {
                                                             rightBtnClick(alertView);
                                                        }];
    [alertView addAction:leftAction];
    [alertView addAction:rightAction];
    
    for (UIView* view in alertView.subviews) {
        for (UIView* subView in view.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton* btn = (UIButton*)subView;
                if ([btn.titleLabel.text isEqualToString:leftBtnTitle]) {
                    [btn setTitleColor:colorFor7E91AD forState:UIControlStateNormal];
                    [btn.titleLabel setFont:Font(16)];
                    [btn.superview.superview removeConstraintWithView:btn.superview attribute:NSLayoutAttributeBottom];
                    [btn.superview.superview removeConstraintWithView:btn.superview attribute:NSLayoutAttributeRight];
                    [btn.superview.superview removeConstraintWithView:btn.superview attribute:NSLayoutAttributeLeft];
                    [btn.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(btn.superview.superview).with.offset(0);
                        make.right.equalTo(btn.superview.superview).with.offset(0);
                        make.bottom.equalTo(btn.superview.superview).with.offset(0);
                        make.height.mas_equalTo(@64);
                    }];
                    
                    UIView* hLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.alertViewWidth, 1)];
                    [hLineView setBackgroundColor:HexRGB(0xD1D8E0)];
                    [alertView addSubview:hLineView];
                    [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(alertView).with.offset(0);
                        make.bottom.equalTo(btn.superview.mas_top).with.offset(0);
                        make.size.mas_equalTo(CGSizeMake(alertView.alertViewWidth, 0.5));
                    }];
                    
                    if (btn.superview) {
                        UIView* vLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.alertViewWidth, 1)];
                        [btn.superview addSubview:vLineView];
                        [vLineView setBackgroundColor:HexRGB(0xD1D8E0)];
                        [btn.superview bringSubviewToFront:vLineView];
                        [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(btn.superview).with.offset(0);
                            make.bottom.equalTo(btn.superview).with.offset(0);
                            make.width.mas_equalTo(@0.5);
                            make.left.equalTo(btn.mas_right).with.offset(0);
                        }];
                    }
                    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(150, 64)] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageWithColor:HexRGB(0xcccccc) size:CGSizeMake(150, 64)] forState:UIControlStateHighlighted];
                }else if([btn.titleLabel.text isEqualToString:rightBtnTitle]) {
                    [btn setTitleColor:colorFor438AF3 forState:UIControlStateNormal];
                    [btn.titleLabel setFont:Font(16)];
                    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(150, 64)] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageWithColor:HexRGB(0xcccccc) size:CGSizeMake(150, 64)] forState:UIControlStateHighlighted];
                }
            }
        }
    }
    
    return alertView;
}


+(void)showHudWithTitle:(NSString*) title
                   type:(NSInteger) type //0 - 成功 1 - 失败 2 - 等待
             completion:(TYAlertViewDismissCompletion) completion{
    
    if (hudAlertView) {
        dismissBlock();
        [self hideHudView];
        [NSObject cancelPreviousPerformRequestsWithTarget:hudAlertView];
    }
    dismissBlock = completion;

    hudAlertView = [self customAlertViewWithTitle:title
                                          content:@"\n\n\n"];

    if (type == 0) {
        UIImageView* succesIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
        [succesIV setImage:[UIImage imageNamed:@"Tip_Success_Proc"]];
        [hudAlertView addSubview:succesIV];
        [succesIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
            make.centerX.equalTo(hudAlertView);
            make.top.equalTo(hudAlertView).with.offset(82);
        }];
    }else if (type == 1) {
        UIImageView* failIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
        [failIV setImage:[UIImage imageNamed:@"Tip_Fail_Proc"]];
        [hudAlertView addSubview:failIV];
        [failIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
            make.centerX.equalTo(hudAlertView);
            make.top.equalTo(hudAlertView).with.offset(82);
        }];
    }else if (type == 2) {
        UIImageView* waitIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
        [waitIV setImage:[UIImage imageNamed:@"Tip_Wait_For_Scene_Hud"]];
        [waitIV beginCircleAnimation];
        [hudAlertView addSubview:waitIV];
        [waitIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerX.equalTo(hudAlertView);
            make.top.equalTo(hudAlertView).with.offset(76);
        }];
    }
    hudAlertView.titleLable.text = title;
    [hudAlertView showInWindow];
    if (type != 2) {
        [hudAlertView performSelector:@selector(hideHudAlertView:) withObject:completion afterDelay:[self displayDurationForString:title]];
    }
}

+(void)showSuccessWithTitle:(NSString*)title
                 completion:(TYAlertViewDismissCompletion) completion{
    [self showHudWithTitle:title
                      type:0
                completion:^{
                    completion();
                }];
}

+(void)showFailWithTitle:(NSString*)title
              completion:(TYAlertViewDismissCompletion) completion{
    [self showHudWithTitle:title
                      type:1
                completion:^{
                    completion();
                }];
}

+(void)showWatingWithTitle:(NSString *)title{
    [self showHudWithTitle:title
                      type:2
                completion:^{
                    
                }];
}

-(void)hideHudAlertView:(TYAlertViewDismissCompletion) completion{
    completion();
    [hudAlertView hideView];
    hudAlertView = nil;
}

+(void)hideHudView{
    if (hudAlertView) {
        [hudAlertView hideView];
        hudAlertView = nil;
    }
}

+ (NSTimeInterval)displayDurationForString:(NSString*)string {
    CGFloat minimum = MAX((CGFloat)string.length * 0.06 + 0.5, kMinimumDismissTimeInterval);
    return MIN(minimum, kMaximumDismissTimeInterval);
}
@end
