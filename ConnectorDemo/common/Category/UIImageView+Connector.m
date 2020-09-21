//
//  UIImageView+Connector.m
//  Connect
//
//  Created by XMJ on 2017/12/15.
//  Copyright © 2017年 MoorgenSmartHome. All rights reserved.
//

#import "UIImageView+Connector.h"

BOOL stopAnimation = 0;
@implementation UIImageView (Connector)

- (void)beginCircleAnimation{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue =  [NSNumber numberWithFloat: 0];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.8;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)beginCircleAnimationWithTime:(NSTimeInterval)time{
    [self beginCircleAnimation];
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(endCircleAnimation)
                                                   object:nil];
        [self performSelector:@selector(endCircleAnimation) withObject:nil afterDelay:time];
    });
}

- (void)endCircleAnimation{
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}

@end
