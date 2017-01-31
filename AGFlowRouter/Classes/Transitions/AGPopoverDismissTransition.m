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

#import "AGPopoverDismissTransition.h"

@interface AGPopoverDismissTransition ()

@property (nonatomic, strong) UIVisualEffect *visualEffect;

@end

@implementation AGPopoverDismissTransition

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
  return @"AGPopoverDismissTransition";
}

- (void)performTrasitionForController:(UIViewController *)viewController
                   previousController:(UIViewController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  previousController.view.layer.zPosition = 0.5f;
  
  CGRect frame = previousController.view.bounds;
  viewController.view.frame = frame;
  [window insertSubview:viewController.view belowSubview:previousController.view];
  
  UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:self.visualEffect];
  blurView.frame = frame;
  blurView.layer.zPosition = 0.5f;
  [window insertSubview:blurView belowSubview:previousController.view];
  
  [UIView animateWithDuration:0.2f
                        delay:0.1f
                      options:kNilOptions
                   animations:^{
    blurView.effect = nil;
  } completion:^(BOOL finished) {
    [blurView removeFromSuperview];
    [viewController.view removeFromSuperview];
    completion(finished);
  }];
  
  [UIView animateWithDuration:0.2f
                   animations:^{
                     previousController.view.alpha = 0.0f;
                     previousController.view.transform = CGAffineTransformMakeScale(0.7f, 0.7f);
                   } completion:^(BOOL finished) {
                     
                   }];
}

@end
