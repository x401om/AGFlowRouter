//
//  AGTabBarItemFlipAnimator.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 27.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGTabBarItemFlipAnimator.h"

@implementation AGTabBarItemFlipAnimator

- (void)performAnimationForImageView:(UIImageView *)imageView textLabel:(UILabel *)textLabel {
  [UIView transitionWithView:imageView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}

@end
