//
//  AGDefaultPopTransition.m
//  Pods
//
//  Created by Aleksey Goncharov on 28.09.16.
//
//

#import "AGDefaultPopTransition.h"

@implementation AGDefaultPopTransition

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {

  previousController.view.layer.zPosition = 0.5f;
  
  CGRect frame = previousController.view.bounds;
  frame.origin.x = -frame.size.width/2.0f;
  viewController.view.frame = frame;
  [window insertSubview:viewController.view belowSubview:previousController.view];
  
  [UIView animateWithDuration:0.4f
                   animations:^{
                     CGRect frame = previousController.view.bounds;
                     frame.origin.x = CGRectGetWidth(frame);
                     previousController.view.frame = frame;
                     
                     viewController.view.frame = window.bounds;
                   } completion:^(BOOL finished) {
                     [viewController.view removeFromSuperview];
                     completion(finished);
                   }];
}

@end
