//
//  AGTabBarItemBounceAnimation.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 27.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGTabBarItemBounceAnimator.h"

@implementation AGTabBarItemBounceAnimator

- (void)performAnimationForImageView:(UIImageView *)imageView textLabel:(UILabel *)textLabel {
  CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
  bounceAnimation.values = @[@1.0 ,@1.4, @0.9, @1.15, @0.95, @1.02, @1.0];
  bounceAnimation.duration = 0.5f;
  bounceAnimation.calculationMode = kCAAnimationCubic;
  
  [imageView.layer addAnimation:bounceAnimation forKey:nil];
}

@end
