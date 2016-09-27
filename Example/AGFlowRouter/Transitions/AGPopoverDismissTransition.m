//
//  AGPopoverDismissTransition.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGPopoverDismissTransition.h"

@implementation AGPopoverDismissTransition

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  previousController.view.layer.zPosition = 0.5f;
  
  CGRect frame = previousController.view.bounds;
  viewController.view.frame = frame;
  [window insertSubview:viewController.view belowSubview:previousController.view];
  
  UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
  blurView.frame = frame;
  blurView.layer.zPosition = 0.5f;
  [window insertSubview:blurView belowSubview:previousController.view];
  
  [UIView animateWithDuration:0.2f
                        delay:0.3f
                      options:kNilOptions
                   animations:^{
    blurView.effect = nil;
  } completion:^(BOOL finished) {
    [blurView removeFromSuperview];
    [viewController.view removeFromSuperview];
    completion(finished);
  }];
  
  [UIView animateWithDuration:0.3f
                   animations:^{
                     previousController.view.alpha = 0.0f;
                     previousController.view.transform = CGAffineTransformMakeScale(0.7f, 0.7f);
                   } completion:^(BOOL finished) {
                     
                   }];
}

@end
