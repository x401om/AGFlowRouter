//  https://github.com/x401om/AGFlowRouter
//
//  MIT License
//
//  Copyright (c) 2017 Alexey Goncharov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
  
  [UIView animateWithDuration:3.4f
                   animations:^{
                     CGRect frame = previousController.view.bounds;
                     frame.origin.x = CGRectGetWidth(frame);
                     previousController.view.frame = frame;
                     
                     viewController.view.frame = window.bounds;
                   } completion:^(BOOL finished) {
                     [previousController.view removeFromSuperview];
                     
                     viewController.view.layer.shadowRadius = 0.0f;
                     viewController.view.layer.shadowColor = [[UIColor clearColor] CGColor];
                     viewController.view.layer.shadowOpacity = 0.0f;
                     
                     completion(finished);
                   }];
}

@end
