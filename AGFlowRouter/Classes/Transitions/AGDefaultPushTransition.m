//
//  AGDefaultPushTransition.m
//  Pods
//
//  Created by Aleksey Goncharov on 28.09.16.
//
//

#import "AGDefaultPushTransition.h"

@implementation AGDefaultPushTransition

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  CGRect frame = window.bounds;
  frame.origin.x = CGRectGetWidth(frame);
  viewController.view.frame = frame;
  viewController.view.layer.zPosition = 0.5f;
  
  viewController.view.layer.shadowRadius = 5.0f;
  viewController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
  viewController.view.layer.shadowOpacity = 0.5f;
  
  [window addSubview:viewController.view];
  
  [UIView animateWithDuration:0.4f
                   animations:^{
                     viewController.view.frame = window.bounds;
                     
                     CGRect previousFrame = window.bounds;
                     previousFrame.origin.x = -previousFrame.size.width/2.0f;
                     previousController.view.frame = previousFrame;
                     
                   } completion:^(BOOL finished) {
                     [viewController.view removeFromSuperview];
                     completion(finished);
                   }];
}

@end
