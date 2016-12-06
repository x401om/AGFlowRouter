//
//  AGDefaultPopTransition.m
//  Pods
//
//  Created by Aleksey Goncharov on 28.09.16.
//
//

#import "AGDefaultPopTransition.h"

@implementation AGDefaultPopTransition

- (NSString *)transitionIdentifier {
  return @"AGDefaultPopTransition";
}

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {

  previousController.view.layer.zPosition = 0.5f;
  previousController.view.layer.shadowRadius = 5.0f;
  previousController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
  previousController.view.layer.shadowOpacity = 0.5f;
  
  
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
                     previousController.view.layer.shadowRadius = 0.0f;
                     previousController.view.layer.shadowColor = [[UIColor clearColor] CGColor];
                     previousController.view.layer.shadowOpacity = 0.0f;
                     completion(finished);
                   }];
}

@end
