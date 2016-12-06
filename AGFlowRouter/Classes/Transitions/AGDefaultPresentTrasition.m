//
//  AGDefaultPresentTrasition.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGDefaultPresentTrasition.h"

@implementation AGDefaultPresentTrasition

- (NSString *)transitionIdentifier {
  return @"AGDefaultPresentTrasition";
}

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  CGRect frame = window.bounds;
  frame.origin.y = CGRectGetHeight(frame);
  viewController.view.frame = frame;
  viewController.view.layer.zPosition = 0.5f;
  [window addSubview:viewController.view];
  
  [UIView animateWithDuration:0.4f
                        delay:0.0f
       usingSpringWithDamping:0.8f
        initialSpringVelocity:0.0f
                      options:kNilOptions
                   animations:^{
                     viewController.view.frame = window.bounds;
                   } completion:^(BOOL finished) {
                     [viewController.view removeFromSuperview];
                     completion(finished);
                   }];
}

@end
