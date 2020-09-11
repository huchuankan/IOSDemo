//
//  BaseInfoShowViewController.h
//  ConnectorDemo
//
//  Created by huck on 2020/9/11.
//  Copyright © 2020 huck. All rights reserved.
//

//用来显示信息的底层类

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseInfoShowVC : BaseVC

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;



- (void)setBtn1Name:(NSString *)name;

- (void)setBtn2Name:(NSString *)name;

- (void)hideBtn2:(BOOL)isHide;

- (void)setInfo:(NSString *)info;


@end

NS_ASSUME_NONNULL_END
