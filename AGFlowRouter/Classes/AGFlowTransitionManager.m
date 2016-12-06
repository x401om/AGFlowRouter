//
//  AGFlowTransitionManager.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 22.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowTransitionManager.h"

@interface AGFlowTransitionManager ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIViewController<AGFlowController> *rootViewController;
@property (nonatomic, strong) NSMutableArray<UIView<AGFlowBar> *> *flowBars;

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
  }
  return self;
}

- (void)registerFlowBar:(UIView<AGFlowBar> *)flowBar {
  [self.flowBars addObject:flowBar];
  flowBar.frame = [flowBar prefferedFrame];
  [self.window addSubview:flowBar];
  [self relayoutPermanentViews];
}

- (void)presentViewController:(UIViewController<AGFlowController> *)viewController
                transition:(id<AGFlowTransition>)transition {

  if ([self.rootViewController respondsToSelector:@selector(willDismissWithTransition:)]) {
    [self.rootViewController willDismissWithTransition:transition];
  }
  if ([viewController respondsToSelector:@selector(willPresentWithTransition:)]) {
    [viewController loadViewIfNeeded];
    [viewController willPresentWithTransition:transition];
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
    __weak typeof(self) weakSelf = self;
    [transition performTrasitionForController:viewController previousController:self.window.rootViewController window:self.window withCompletion:^(BOOL finished) {
      viewController.view.layer.zPosition = 0.0f;
      weakSelf.window.rootViewController = viewController;
      weakSelf.rootViewController = viewController;
      [weakSelf relayoutPermanentViews];
      
      if ([viewController respondsToSelector:@selector(flowViewDidAppear:)]) {
        [viewController flowViewDidAppear:YES];
      }
    }];
  } else {
    viewController.view.layer.zPosition = 0.0f;
    self.window.rootViewController = viewController;
    self.rootViewController = viewController;
    [self relayoutPermanentViews];
    
    if ([viewController respondsToSelector:@selector(flowViewDidAppear:)]) {
      [viewController flowViewDidAppear:YES];
    }
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
