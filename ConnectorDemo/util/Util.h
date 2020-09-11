//
//  Util.h
//  Coulisse
//
//  Created by XMJ on 2017/8/23.
//  Copyright © 2017年 Coulisse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>

typedef void(^TipPopBlock)(void);

@interface Util : NSObject

/**
 * 将JSON字符串转成对象
 */
+ (id)parseJSON:(NSString *)value;

/**
 * 将对象转成JSON字符串
 */
+ (NSString *)toJSONString:(id)object;

+ (void)log:(id)object;

+ (void)showTipPopViewTitle:(NSString *)title content:(NSString *)content;

+ (void)showTipPopViewTitle:(NSString *)title
                    content:(NSString *)content
               leftBtnTitle:(NSString *)leftBtnTitle
               leftBtnClick:(TipPopBlock)leftClick
              rightBtnTitle:(NSString *)rightBtnTitle
              rightBtnClick:(TipPopBlock)rightClick;


+ (NSString *)whenWithCom:(NSDateComponents*)dataComponets;

/**
 把NSdate转化成NSdateComponets

 @param date NSdate
 @return NSdateComponents
 */
+ (NSDateComponents *)compointsWithDate:(NSDate *)date;
/**
 *  @brief	获取当前VC控制器
 *
 *  @since 2017.04.25
 */
+ (UIViewController*)utilsViewController:(UIView*)view;

/**
 *  @brief  校验邮箱合法性
 *
 **/
+ (BOOL)validateEmail:(NSString *)email;


/**
 获取app版本号

 @return 发布版本号与build版本号拼接
 */
+ (NSString *)getAPPVersion;


/**
 获取当前链接WIFI帐号
 
 @return WI-FI帐号
 */
+ (NSString *)getSSID;

/**
 *  NSDate转NSDateComponents
 */
+(NSDateComponents*)convertTimeDateComponents:(NSDate*) time;

/**
 *  定时器时间值转date
 **/
+(NSDate*)convertTimerTimeValueToNSDate:(NSDateComponents*) timeValue;


/**
 *  @brief  获取采集图像
 *
 *  @para   image   原始图像
 *          percent  裁剪百分比
 *          isVertical 是否是垂直方向裁剪:YES垂直方向 NO水平方向
 */
+(UIImage*)clipImage:(UIImage*)image percent:(CGFloat)percent isVertical:(BOOL)isVertical;

/**
 *  @brief  获取反向采集图像
 *
 *  @para   image   原始图像
 *          percent  裁剪百分比
 *          isVertical 是否是垂直方向裁剪:YES垂直方向 NO水平方向
 */
+(UIImage*)clipFlipImage:(UIImage*)image percent:(CGFloat)percent isVertical:(BOOL)isVertical;
@end
