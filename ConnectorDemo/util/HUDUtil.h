//
//  HUDUtil.h
//  Coulisse
//
//  Created by moorgen on 2017/9/4.
//  Copyright © 2017年 Coulisse. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void(^HUDBlock)(void);

@interface HUDUtil : NSObject
/**
 *  显示操作等待
 **/
+(void)showWating;

/**
 *  dismiss
 **/
+(void)dismiss;

/**
 *  显示等待框
 **/
+(void)showWithStatus:(NSString*) status;


/**
 *  错误提示
 **/
+(void)showErrorWithStatus:(NSString*) status;

/**
 成功提示

 @param status 提示语
 */
+ (void)showSuccessWithStatus:(NSString *)status;

/**
 成功提示
 
 @param status 提示语
 */
+ (void)showSuccessWithStatus:(NSString *)status
             dismissWithDelay:(NSTimeInterval)delay
                   completion:(HUDBlock)completion;
@end
