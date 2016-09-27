//
//  AGPopeverTransition.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGPopoverPresentTransition.h"

@implementation AGPopoverPresentTransition

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  CGRect frame = window.bounds;

  UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:nil];
  blurView.frame = frame;
  blurView.layer.zPosition = 0.5f;
  [window addSubview:blurView];
  
  viewController.view.frame = frame;
  
  viewController.view.alpha = 0.0f;
  viewController.view.transform = CGAffineTransformMakeScale(0.7f, 0.7f);
  viewController.view.layer.zPosition = 0.5f;
  [window addSubview:viewController.view];
  
  [UIView animateWithDuration:0.4f animations:^{
    blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  }];
  
  [UIView animateWithDuration:0.4f
                        delay:0.3f
       usingSpringWithDamping:0.6f
        initialSpringVelocity:0.0f
                      options:kNilOptions
                   animations:^{
                     viewController.view.alpha = 1.0f;
                     viewController.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                   } completion:^(BOOL finished) {
                     [blurView removeFromSuperview];
                     [viewController.view removeFromSuperview];
                     completion(finished);
                   }];
}

@end
