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

#import "AGPopoverController.h"

#import "AGPopoverToPopoverTransition.h"

@interface AGPopoverToPopoverTransition ()

@property (nonatomic, strong) UIVisualEffect *visualEffect;
@property (nonatomic, strong) UIImage *snapshotImage;
@property (nonatomic) AGPopoverReplacementAnimation animation;

@end

@implementation AGPopoverToPopoverTransition

- (instancetype)initWithVisualEffect:(UIVisualEffect *)visualEffect
                       snapshotImage:(UIImage *)snapshotImage
                           animation:(AGPopoverReplacementAnimation)animation {
  self = [super init];
  if (self) {
    _visualEffect = visualEffect;
    _snapshotImage = snapshotImage;
    _animation = animation;
  }
  return self;
}

- (NSString *)transitionIdentifier {
  return @"AGPopoverToPopoverTransition";
}

- (void)performTrasitionForController:(AGPopoverController *)viewController
                   previousController:(AGPopoverController *)previousController
                               window:(UIWindow *)window
                       withCompletion:(void (^)(BOOL))completion {
  NSAssert([viewController isKindOfClass:[AGPopoverController class]],
           @"Presenting ViewController must be a AGPopoverController class");
  NSAssert([previousController isKindOfClass:[AGPopoverController class]],
           @"Dismissing ViewController must be a AGPopoverController class");
  
  previousController.view.layer.zPosition = 0.6f;
  
  CGRect frame = window.bounds;
  
  UIImageView *snapshotView = [[UIImageView alloc] initWithImage:self.snapshotImage];
  snapshotView.frame = frame;
  snapshotView.layer.zPosition = 0.5f;
  [window addSubview:snapshotView];
  
  UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:self.visualEffect];
  blurView.frame = frame;
  blurView.layer.zPosition = 0.5f;
  [window addSubview:blurView];
  
  viewController.blurView.alpha = 0.0f;
  viewController.backgroundView.alpha = 0.0f;
  
  previousController.blurView.alpha = 0.0f;
  previousController.backgroundView.alpha = 0.0f;
  
  switch (self.animation) {
    case AGPopoverReplacementAnimationLeft:
      frame.origin.x = CGRectGetWidth(frame);
      break;
    case AGPopoverReplacementAnimationRight:
      frame.origin.x = -CGRectGetWidth(frame);
      break;
    case AGPopoverReplacementAnimationTop:
      frame.origin.y = CGRectGetHeight(frame);
      break;
    case AGPopoverReplacementAnimationBottom:
      frame.origin.y = -CGRectGetHeight(frame);
      break;
    default:
      break;
  }
  viewController.view.frame = frame;
  
  viewController.view.layer.zPosition = 0.5f;
  [window addSubview:viewController.view];
  
  __weak typeof(self) weakSelf = self;

  [UIView animateWithDuration:0.4f
                        delay:0.0f
       usingSpringWithDamping:0.8f
        initialSpringVelocity:0.0f
                      options:kNilOptions
                   animations:^{
                     CGRect frame = previousController.view.frame;
                     switch (weakSelf.animation) {
                       case AGPopoverReplacementAnimationLeft:
                         frame.origin.x = -CGRectGetWidth(frame);
                         break;
                       case AGPopoverReplacementAnimationRight:
                         frame.origin.x = CGRectGetWidth(frame);
                         break;
                       case AGPopoverReplacementAnimationTop:
                         frame.origin.y = -CGRectGetHeight(frame);
                         break;
                       case AGPopoverReplacementAnimationBottom:
                         frame.origin.y = CGRectGetHeight(frame);
                         break;
                       default:
                         break;
                     }
                     previousController.view.frame = frame;
                     
                     viewController.view.frame = window.bounds;
                   } completion:^(BOOL finished) {
                     viewController.blurView.alpha = 1.0f;
                     viewController.backgroundView.alpha = 1.0f;
                     
                     [snapshotView removeFromSuperview];
                     [blurView removeFromSuperview];
                     [viewController.view removeFromSuperview];
                     completion(finished);
                   }];
}

@end
