//
//  AGFlowRouter.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 26.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGPopoverController.h"
#import "UIView+AGSnapshot.h"
#import "AGPopoverToPopoverTransition.h"
#import "AGFlowRouter.h"
#import "AGFlowTransitionManager.h"

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
  AGFlowRouterCreationBlock creationBlock = self.creationBlocks[identifier];
  if (creationBlock) {
    UIViewController<AGFlowController> *vc = creationBlock(identifier, userInfo);
    if (vc) {
      [self presentController:vc transition:transition];
    }
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

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller {
  [self presentInPopoverController:controller transition:nil];
}

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller
                        transition:(nullable id<AGFlowTransition>)transition {
  AGPopoverController *popoverController =
  [[AGPopoverController alloc] initWithContentCotroller:controller
                                         baseController:self.transitionManager.rootViewController
                                      presentTransition:transition
                                      dismissTransition:nil
                                         windowSnapshot:[self.transitionManager.window snapshotImage]];
  
  [self.transitionManager presentViewController:popoverController
                                     transition:popoverController.presentTransition];
}

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo {
  [self presentInPopoverControllerId:identifier
                            userInfo:userInfo
                          transition:nil];
}

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
                          transition:(nullable id<AGFlowTransition>)transition {
  AGFlowRouterCreationBlock creationBlock = self.creationBlocks[identifier];
  if (creationBlock) {
    UIViewController<AGFlowController, AGPopoverContent> *vc = (UIViewController<AGFlowController, AGPopoverContent> *)creationBlock(identifier, userInfo);
    if (vc) {
      [self presentInPopoverController:vc transition:transition];
    }
  }
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
                                         baseController:self.transitionManager.rootViewController
                                      presentTransition:transition
                                      dismissTransition:currentPopoverController.dismissTransition
                                         windowSnapshot:currentPopoverController.windowSnapshot];

  [self.transitionManager presentViewController:popoverController
                                     transition:transition];
}

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
       replacingCurrentWithAnimation:(AGPopoverReplacementAnimation)animation {
  AGFlowRouterCreationBlock creationBlock = self.creationBlocks[identifier];
  if (creationBlock) {
    UIViewController<AGFlowController, AGPopoverContent> *vc = (UIViewController<AGFlowController, AGPopoverContent> *)creationBlock(identifier, userInfo);
    if (vc) {
      [self presentInPopoverController:vc replacingCurrentWithAnimation:animation];
    }
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
