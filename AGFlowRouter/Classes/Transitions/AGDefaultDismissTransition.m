//
//  AGDefaultDismissTransition.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGDefaultDismissTransition.h"

@implementation AGDefaultDismissTransition

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  previousController.view.layer.zPosition = 0.5f;
  
  CGRect frame = previousController.view.bounds;
  viewController.view.frame = frame;
  [window insertSubview:viewController.view belowSubview:previousController.view];
  
  [UIView animateWithDuration:0.4f
                   animations:^{
                     CGRect frame = previousController.view.bounds;
                     frame.origin.y = CGRectGetHeight(frame);
                     previousController.view.frame = frame;
                   } completion:^(BOOL finished) {
                     [viewController.view removeFromSuperview];
                     completion(finished);
                   }];
}

@end
