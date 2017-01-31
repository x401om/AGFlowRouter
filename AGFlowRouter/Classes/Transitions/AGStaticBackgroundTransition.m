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

#import "UIView+AGSnapshot.h"

#import "AGStaticBackgroundTransition.h"

@interface AGStaticBackgroundTransition ()

@property (nonatomic, strong) UIImage *backgroundImage;

@end

@implementation AGStaticBackgroundTransition

- (instancetype)initWithStaticView:(UIView *)staticView {
  self = [super init];
  if (self) {
    _backgroundImage = [staticView snapshotImage];
  }
  return self;
}

- (NSString *)transitionIdentifier {
  return @"AGStaticBackgroundTransition";
}

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  
  UIImageView *backgroundView = [[UIImageView alloc] initWithImage:self.backgroundImage];
  [window insertSubview:backgroundView atIndex:0];
  backgroundView.frame = window.bounds;
  
  CGRect frame = window.bounds;
  frame.origin.x = CGRectGetWidth(frame);
  viewController.view.frame = frame;
  viewController.view.layer.zPosition = 0.5f;
  viewController.view.backgroundColor = [UIColor clearColor];
  
  [window addSubview:viewController.view];
  
  [UIView animateWithDuration:0.4f
                        delay:0.0f
       usingSpringWithDamping:0.8f
        initialSpringVelocity:0.0f
                      options:kNilOptions
                   animations:^{
                     viewController.view.frame = window.bounds;
                     
                     CGRect previousFrame = window.bounds;
                     previousFrame.origin.x = -previousFrame.size.width;
                     previousController.view.frame = previousFrame;
                     
                   } completion:^(BOOL finished) {
                     [backgroundView removeFromSuperview];
                     [viewController.view removeFromSuperview];
                     completion(finished);
                   }];
}

@end
