//
//  AGTabBarItemRotationAnimator.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 27.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGTabBarItemRotationAnimator.h"

@implementation AGTabBarItemRotationAnimator

- (void)performAnimationForImageView:(UIImageView *)imageView textLabel:(UILabel *)textLabel {
  CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
  rotateAnimation.fromValue = @0.0f;
  rotateAnimation.toValue = @(-2.0f * M_PI);
  rotateAnimation.duration = 0.5f;
  
  [imageView.layer addAnimation:rotateAnimation forKey:nil];
}

@end
