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

#import "AGFlowTransitionManager.h"

@interface AGFlowTransitionManager ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIViewController<AGFlowController> *rootViewController;
@property (nonatomic, strong) NSMutableArray<UIView<AGFlowBar> *> *flowBars;

@property (nonatomic, strong) NSString *cancellationToken;
@property (nonatomic, strong) UIViewController<AGFlowController> *pendingViewController;
@property (nonatomic, strong) id<AGFlowTransition> currentTransition;

@end

@implementation AGFlowTransitionManager

- (instancetype)init {
  self = [super init];
  if (self) {
    _flowBars = [NSMutableArray array];
  }
  return self;
}

+ (instancetype)sharedAnimator {
  static id _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[self alloc] init];
  });
  return _sharedInstance;
}

- (instancetype)initWithRootViewController:(nonnull UIViewController<AGFlowController> *)rootViewController
                                    window:(nonnull UIWindow *)window {
  self = [super init];
  if (self) {
    _flowBars = [NSMutableArray array];
    _rootViewController = rootViewController;
    _window = window;
    _window.rootViewController = rootViewController;
    
    [rootViewController loadViewIfNeeded];
    if ([rootViewController respondsToSelector:@selector(flowViewDidAppear:)]) {
      [rootViewController flowViewDidAppear:NO];
    }
  }
  return self;
}

- (void)forceFinishCurrentTransition {
  if (self.pendingViewController == nil) {
    return;
  }
  
  self.cancellationToken = [[NSUUID UUID] UUIDString];
  if ([self.currentTransition respondsToSelector:@selector(cancelWithCancellationToken:)]) {
    [self.currentTransition cancelWithCancellationToken:self.cancellationToken];
  }
  
  if (self.pendingViewController) {
    [self.rootViewController.view.layer removeAllAnimations];
    [self.pendingViewController.view.layer removeAllAnimations];
    
    [self.rootViewController.view removeFromSuperview];
    [self.pendingViewController.view removeFromSuperview];
    
    [self.window addSubview:self.pendingViewController.view];
    
    self.pendingViewController.view.layer.zPosition = 0.0f;
    self.pendingViewController.view.alpha = 1.0f;
    self.pendingViewController.view.frame = self.window.bounds;
    
    self.window.rootViewController = self.pendingViewController;
    self.rootViewController = self.pendingViewController;
    [self relayoutPermanentViews];
    
    self.pendingViewController = nil;
  }
}

- (void)cancelCurrentTransition {
  if (self.pendingViewController == nil) {
    return;
  }
  
  self.cancellationToken = [[NSUUID UUID] UUIDString];
  if ([self.currentTransition respondsToSelector:@selector(cancelWithCancellationToken:)]) {
    [self.currentTransition cancelWithCancellationToken:self.cancellationToken];
  }
}

- (void)registerFlowBar:(UIView<AGFlowBar> *)flowBar {
  [self.flowBars addObject:flowBar];
  flowBar.frame = [flowBar prefferedFrame];
  [self.window addSubview:flowBar];
  [self relayoutPermanentViews];
}

- (nullable UIView<AGFlowBar> *)flowBarWithIdentifier:(NSString *)identifier {
  for (UIView<AGFlowBar> *flowBar in self.flowBars) {
    if ([[flowBar flowBarIdentifier] isEqual:identifier]) {
      return flowBar;
    }
  }
  return nil;
}

- (void)presentViewController:(UIViewController<AGFlowController> *)viewController
                transition:(id<AGFlowTransition>)transition {

  self.cancellationToken = nil;
  self.pendingViewController = viewController;
  self.currentTransition = transition;
  
  if ([self.rootViewController respondsToSelector:@selector(willDismissWithTransition:nextControllerId:)]) {
    NSString *nextId = nil;
    if ([viewController respondsToSelector:@selector(flowIdentifier)]) {
      nextId = [viewController flowIdentifier];
    } else {
      nextId = NSStringFromClass([viewController class]);
    }
    [self.rootViewController willDismissWithTransition:transition nextControllerId:nextId];
  }
  
  [viewController loadViewIfNeeded];
  if ([viewController respondsToSelector:@selector(flowViewDidLoad)]) {
    [viewController flowViewDidLoad];
  }
  
  if ([viewController respondsToSelector:@selector(willPresentWithTransition:previousControllerId:)]) {
    NSString *prevId = nil;
    if ([self.rootViewController respondsToSelector:@selector(flowIdentifier)]) {
      prevId = [self.rootViewController flowIdentifier];
    } else {
      prevId = NSStringFromClass([self.rootViewController class]);
    }
    [viewController willPresentWithTransition:transition previousControllerId:prevId];
  }
  
  if ([self.rootViewController respondsToSelector:@selector(flowViewWillDisappear:)]) {
    [self.rootViewController flowViewWillDisappear:YES];
  }
  
  for (UIView<AGFlowBar> *flowBar in self.flowBars) {
    
    if ([self flowController:self.rootViewController prefersHideFlowBar:flowBar] !=
        [self flowController:viewController prefersHideFlowBar:flowBar]) {
      flowBar.layer.zPosition = 0.1f;
    }
  }
  
  if (transition) {
    UIViewController<AGFlowController> *previousController =
    (UIViewController<AGFlowController> *)self.window.rootViewController;
    
    __weak typeof(self) weakSelf = self;
    [transition performTrasitionForController:viewController
                           previousController:self.window.rootViewController
                                       window:self.window
                               withCompletion:^(BOOL finished) {
                                 
     if (weakSelf.cancellationToken || finished == NO) {
       weakSelf.cancellationToken = nil;
       return;
     }
                
     if ([viewController respondsToSelector:@selector(didPresentWithTransition:)]) {
       [viewController didPresentWithTransition:transition];
     }
     if ([previousController respondsToSelector:@selector(didDismissWithTransition:)]) {
       [previousController didDismissWithTransition:transition];
     }
                                 
      viewController.view.layer.zPosition = 0.0f;
      weakSelf.window.rootViewController = viewController;
      weakSelf.rootViewController = viewController;
      [weakSelf relayoutPermanentViews];
      
      if ([viewController respondsToSelector:@selector(flowViewDidAppear:)]) {
        [viewController flowViewDidAppear:YES];
      }
                                 
      weakSelf.pendingViewController = nil;
      weakSelf.currentTransition = nil;
    }];
  } else {
    viewController.view.layer.zPosition = 0.0f;
    self.window.rootViewController = viewController;
    self.rootViewController = viewController;
    [self relayoutPermanentViews];
    
    if ([viewController respondsToSelector:@selector(flowViewDidAppear:)]) {
      [viewController flowViewDidAppear:NO];
    }
    
    self.pendingViewController = nil;
    self.currentTransition = nil;
  }
}

#pragma mark - Permanent Views (InfoBar & TabBar)

- (BOOL)flowController:(UIViewController<AGFlowController> *)controller prefersHideFlowBar:(UIView<AGFlowBar> *)flowBar {
  if ([controller respondsToSelector:@selector(prefersHideFlowBarWithIdentifier:)]) {
    return [controller prefersHideFlowBarWithIdentifier:[flowBar flowBarIdentifier]];
  } else {
    return NO;
  }
}

- (void)relayoutPermanentViews {
  if (!self.rootViewController) {
    return;
  }
  for (UIView<AGFlowBar> *flowBar in self.flowBars) {
    [self hide:[self flowController:self.rootViewController prefersHideFlowBar:flowBar] flowBar:flowBar];
  }
}

- (void)hide:(BOOL)hide flowBar:(UIView<AGFlowBar> *)flowBar {
  [flowBar removeFromSuperview];
  if (hide) {
    [self.window insertSubview:flowBar belowSubview:self.rootViewController.view];
    flowBar.layer.zPosition = -1.0f;
  } else {
    [self.window insertSubview:flowBar aboveSubview:self.rootViewController.view];
    flowBar.layer.zPosition = 1.0f;
  }
}


@end
