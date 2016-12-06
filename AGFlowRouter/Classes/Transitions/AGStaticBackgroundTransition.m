//
//  AGStaticBackgroundTransition.m
//  Pods
//
//  Created by Aleksey Goncharov on 06.12.16.
//
//

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
