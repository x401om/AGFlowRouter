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
#import "UIView+AGSnapshot.h"
#import "AGFlowRouter.h"
#import "AGFlowTransitionManager.h"

#import "AGPopoverPresentTransition.h"
#import "AGPopoverDismissTransition.h"
#import "AGPopoverToPopoverTransition.h"

@interface AGFlowRouter ()

@property (nonatomic, strong) AGFlowTransitionManager *transitionManager;

@property (nonatomic, strong) NSMutableDictionary<NSString *, AGFlowRouterCreationBlock> *creationBlocks;
@property (nonatomic, strong) AGFlowRouterRootCreationBlock rootControllerCreation;
@property (nonatomic, strong) NSMutableArray *flowBars;

@end

@implementation AGFlowRouter

- (NSMutableDictionary<NSString *,AGFlowRouterCreationBlock> *)creationBlocks {
  if (!_creationBlocks) {
    _creationBlocks = [NSMutableDictionary dictionary];
    _flowBars = [NSMutableArray array];
  }
  return _creationBlocks;
}

+ (instancetype)sharedRouter {
  static id _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[self alloc] init];
  });
  return _sharedInstance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.transitionManager = [[AGFlowTransitionManager alloc] initWithRootViewController:self.rootControllerCreation()
                                                                                window:[application.windows firstObject]];

  if (self.flowBars.count) {
    for (UIView<AGFlowBar> *flowBar in self.flowBars) {
      [self.transitionManager registerFlowBar:flowBar];
    }
    [self.flowBars removeAllObjects];
  }
  
  return YES;
}

- (void)registerRootControllerCreationBlock:(AGFlowRouterRootCreationBlock)creationBlock {
  self.rootControllerCreation = creationBlock;
}

- (void)registerControllerCreationBlock:(AGFlowRouterCreationBlock)creationBlock forIdentifier:(NSString *)identifier {
  self.creationBlocks[identifier] = creationBlock;
}

- (void)presentController:(UIViewController<AGFlowController> *)controller transition:(id<AGFlowTransition>)transition {
  [self.transitionManager presentViewController:controller
                                     transition:transition];
}

- (void)presentControllerId:(NSString *)identifier userInfo:(id)userInfo transition:(id<AGFlowTransition>)transition {
  UIViewController<AGFlowController> *vc = [self instantiateControllerId:identifier userInfo:userInfo];
  AGFlowRouterCreationBlock creationBlock = self.creationBlocks[identifier];
  if (vc) {
    [self presentController:vc transition:transition];
  }
}

- (UIViewController<AGFlowController> *)rootViewController {
  return self.transitionManager.rootViewController;
}

- (nullable UIViewController<AGFlowController> *)instantiateControllerId:(NSString *)identifier
                                                       userInfo:(nullable id)userInfo {
  AGFlowRouterCreationBlock creationBlock = self.creationBlocks[identifier];
  if (creationBlock) {
    UIViewController<AGFlowController> *vc = creationBlock(identifier, userInfo);
    return vc;
  } else {
    return nil;
  }
}

#pragma mark - FlowBars

- (void)registerFlowBar:(nonnull UIView<AGFlowBar> *)flowBar {
  if (self.transitionManager) {
    [self.transitionManager registerFlowBar:flowBar];
  } else {
    [self.flowBars addObject:flowBar];
  }
}

- (UIView<AGFlowBar> *)flowBarWithIdentifier:(NSString *)identifier {
  return [self.transitionManager flowBarWithIdentifier:identifier];
}

#pragma mark - Popovers

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller
                 presentTransition:(nullable id<AGFlowTransition>)presentTransition
                 dismissTransition:(nullable id<AGFlowTransition>)dismissTransition {
  AGPopoverController *popoverController =
  [[AGPopoverController alloc] initWithContentCotroller:controller
                                         baseController:self.transitionManager.rootViewController
                                      presentTransition:presentTransition ?: [AGPopoverPresentTransition new]
                                      dismissTransition:dismissTransition ?: [AGPopoverDismissTransition new]
                                         windowSnapshot:[self.transitionManager.window snapshotImage]];
  
  [self presentController:popoverController transition:popoverController.presentTransition];
}

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
                   presentTransition:(nullable id<AGFlowTransition>)presentTransition
                   dismissTransition:(nullable id<AGFlowTransition>)dismissTransition {
  UIViewController<AGFlowController> *vc = [self instantiateControllerId:identifier userInfo:userInfo];
  if (vc) {
    [self presentInPopoverController:vc
                   presentTransition:presentTransition
                   dismissTransition:dismissTransition];
  }
}

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller {
  [self presentInPopoverController:controller
                 presentTransition:nil
                 dismissTransition:nil];
}

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo {
  [self presentInPopoverControllerId:identifier
                            userInfo:userInfo
                   presentTransition:nil
                   dismissTransition:nil];
}

//// DEPRECATED !!!!!

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller
                        transition:(nullable id<AGFlowTransition>)transition {
  [self presentInPopoverController:controller presentTransition:transition dismissTransition:nil];
}



- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
                          transition:(nullable id<AGFlowTransition>)transition {
  [self presentInPopoverControllerId:identifier userInfo:userInfo presentTransition:transition dismissTransition:nil];
}

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller
     replacingCurrentWithAnimation:(AGPopoverReplacementAnimation)animation {
  AGPopoverController *currentPopoverController = nil;
  
  if ([self.transitionManager.rootViewController isKindOfClass:[AGPopoverController class]]) {
    currentPopoverController = (AGPopoverController *)self.transitionManager.rootViewController;
  } else {
    return;
  }

  
  AGPopoverToPopoverTransition *transition =
  [[AGPopoverToPopoverTransition alloc] initWithVisualEffect:currentPopoverController.visualEffect
                                               snapshotImage:currentPopoverController.windowSnapshot
                                                   animation:animation];
  
  AGPopoverController *popoverController =
  [[AGPopoverController alloc] initWithContentCotroller:controller
                                         baseController:currentPopoverController.baseController
                                      presentTransition:transition
                                      dismissTransition:currentPopoverController.dismissTransition
                                         windowSnapshot:currentPopoverController.windowSnapshot];
  [[AGFlowRouter sharedRouter] presentController:popoverController transition:transition];
}

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
       replacingCurrentWithAnimation:(AGPopoverReplacementAnimation)animation {
  UIViewController<AGFlowController, AGPopoverContent> *vc = [self instantiateControllerId:identifier userInfo:userInfo];
  if (vc) {
    [self presentInPopoverController:vc replacingCurrentWithAnimation:animation];
  }
}

- (void)dismissCurrentPopoverController {
  if ([self.transitionManager.rootViewController isKindOfClass:[AGPopoverController class]]) {
    AGPopoverController *currentPopoverController = (AGPopoverController *)self.transitionManager.rootViewController;
    if (currentPopoverController.baseController) {
      [self presentController:currentPopoverController.baseController
                   transition:currentPopoverController.dismissTransition];
    }
  }
}
@end
