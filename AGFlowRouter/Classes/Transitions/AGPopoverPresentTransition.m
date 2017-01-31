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

#import "AGPopoverPresentTransition.h"

@interface AGPopoverPresentTransition ()

@property (nonatomic, strong) UIVisualEffect *visualEffect;

@end

@implementation AGPopoverPresentTransition

- (UIVisualEffect *)visualEffect {
  if (!_visualEffect) {
    _visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  }
  return _visualEffect;
}

- (instancetype)initWithVisualEffect:(UIVisualEffect *)visualEffect {
  self = [super init];
  if (self) {
    _visualEffect = visualEffect;
  }
  return self;
}

- (NSString *)transitionIdentifier {
  return @"AGPopoverPresentTransition";
}

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
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.3f animations:^{
    blurView.effect = weakSelf.visualEffect;
  }];
  
  [UIView animateWithDuration:0.3f
                        delay:0.2f
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
