//
//  Util.m
//  Coulisse
//
//  Created by XMJ on 2017/8/23.
//  Copyright © 2017年 Coulisse. All rights reserved.
//

#import "Util.h"
#import "TYAlertView+Custom.h"
#import "UIView+TYAlertView.h"


@implementation Util

+ (id)parseJSON:(NSString *)value
{
    id object = nil;
    @try {
        NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
        object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] JSON字符串转成对象出错，原因：%@",  __PRETTY_FUNCTION__, __LINE__, exception);
    }
    return object;
}

+ (NSString *)toJSONString:(id)object
{
    NSString *jsonStr = @"";
    @try {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] 对象转成JSON字符串出错，原因：%@", __PRETTY_FUNCTION__, __LINE__, exception);
    }
    return jsonStr;
}

+ (void)log:(id)object {
    NSLog(@"%@", [Util toJSONString:object]);
}

+ (void)showTipPopViewTitle:(NSString *)title
                    content:(NSString *)content
               leftBtnTitle:(NSString *)leftBtnTitle
               leftBtnClick:(TipPopBlock)leftClick
              rightBtnTitle:(NSString *)rightBtnTitle
              rightBtnClick:(TipPopBlock)rightClick{
    TYAlertView* alertView = [TYAlertView customAlertViewWithTitle:title
                                                           content:content
                                                      leftBtnTitle:leftBtnTitle
                                                      leftBtnClick:^(TYAlertView *alertView) {
                                                          leftClick();
                                                      }
                                                     rightBtnTitle:rightBtnTitle
                                                     rightBtnClick:^(TYAlertView *alertView) {
                                                         rightClick();
                                                     }];
    [alertView showInWindow];
}



+ (NSString *)whenWithCom:(NSDateComponents*)dataComponets{
    if (dataComponets == nil) {
        return @"";
    }
    NSString *whenStr;
    NSInteger hour = dataComponets.hour;
    NSInteger minite = dataComponets.minute;
//    NSString *amOrPm = @"AM";
    NSString *hourZeroStr = @"";
    NSString *miniteZeroStr = @"";
//    if (hour>12) {
//        amOrPm = @"PM";
//        hour = hour-12;
//    }
    if (hour<10) {
        hourZeroStr = @"0";
    }
    if (minite<10) {
        miniteZeroStr = @"0";
    }
//    whenStr = [NSString stringWithFormat:@"%@ %@%ld:%@%ld",amOrPm,hourZeroStr,hour,miniteZeroStr,minite];
    whenStr = [NSString stringWithFormat:@"%@%ld:%@%ld",hourZeroStr,(long)hour,miniteZeroStr,(long)minite];

    return whenStr;
}


+ (NSDateComponents *)compointsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    return components;
}

/**
 *  @brief	获取当前VC控制器
 *
 *  @since 2017.04.25
 */
+ (UIViewController*)utilsViewController:(UIView*)view {
    
    for (UIView* next = [view superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)nextResponder;
        }
    }
    
    return  nil;
}

/**
 *  @brief  校验邮箱合法性
 *
 **/
+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 获取app版本号
 
 @return 发布版本号与build版本号拼接
 */
+ (NSString *)getAPPVersion{
    
    NSString *versionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"Version %@(%@)",versionStr,build];
}

/**
 获取当前链接WIFI帐号
 
 @return WI-FI帐号
 */
+ (NSString *)getSSID{
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSString *ssid = @"";
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        ssid = info[@"SSID"];
    }
    return ssid;
}

/**
 *  NSDate转NSDateComponents
 */
+(NSDateComponents*)convertTimeDateComponents:(NSDate*) time{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:time];
    comps.year = 2017;
    comps.month = 12;
    comps.day = 25;
    
    return comps;
}

/**
 *  定时器时间值转date
 **/
+(NSDate*)convertTimerTimeValueToNSDate:(NSDateComponents*) timeValue{
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    comps.year = 2017;
    comps.day = 12;
    comps.month = 25;
    comps.hour = timeValue.hour;
    comps.minute = timeValue.minute;
    comps.second = 0;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar dateFromComponents:comps];
}

/**
 *  @brief  获取采集图像
 *
 *  @para   image   原始图像
 *          percent  裁剪百分比
 *          isVertical 是否是垂直方向裁剪:YES垂直方向 NO水平方向
 */
+(UIImage*)clipImage:(UIImage*)image percent:(CGFloat)percent isVertical:(BOOL)isVertical {
    
    if (percent == 0) {
        return image;
    }else {
        CGSize subImageSize;
        CGRect subImageRect;
        
        if (isVertical) {
            subImageSize = CGSizeMake(image.size.width*2,image.size.height*percent*2);
            subImageRect = CGRectMake(0, 0,image.size.width*2,image.size.height*percent*2);
        }else{
            subImageSize = CGSizeMake(image.size.width*percent*2,image.size.height*2);
            subImageRect = CGRectMake(0, 0,image.size.width*percent*2,image.size.height*2);
        }
        
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, subImageRect);
        UIGraphicsBeginImageContext(subImageSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, subImageRect, subImageRef);
        UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        CGImageRelease(subImageRef);
        
        return subImage;
    }
}

/**
 *  @brief  获取反向采集图像
 *
 *  @para   image   原始图像
 *          percent  裁剪百分比
 *          isVertical 是否是垂直方向裁剪:YES垂直方向 NO水平方向
 */
+(UIImage*)clipFlipImage:(UIImage*)image percent:(CGFloat)percent isVertical:(BOOL)isVertical {
    
    if (percent == 0) {
        return image;
    }else {
        CGSize subImageSize;
        CGRect subImageRect;
        
        if (isVertical) {
            subImageSize = CGSizeMake(image.size.width*2,image.size.height*percent*2);
            subImageRect = CGRectMake(0, image.size.height*(1-percent)*2,image.size.width*2,image.size.height*percent*2);
        }else{
            subImageSize = CGSizeMake(image.size.width*percent*2,image.size.height*2);
            subImageRect = CGRectMake(image.size.width*(1-percent)*2, 0,image.size.width*percent*2,image.size.height*2);
        }
        
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, subImageRect);
        UIGraphicsBeginImageContext(subImageSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, subImageRect, subImageRef);
        UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        CGImageRelease(subImageRef);
        
        return subImage;
    }
}
@end
