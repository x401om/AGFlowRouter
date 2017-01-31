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
