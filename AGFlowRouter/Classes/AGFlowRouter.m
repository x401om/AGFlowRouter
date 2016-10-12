//
//  AGFlowRouter.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 26.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowRouter.h"
#import "AGFlowTransitionManager.h"

#import "AGPopoverController.h"
#import "UIView+AGSnaphot.h"

@interface AGFlowRouter ()

@property (nonatomic, strong) AGFlowTransitionManager *transitionManager;

@property (nonatomic, strong) NSMutableDictionary<NSString *, AGFlowRouterCreationBlock> *creationBlocks;
@property (nonatomic, strong) AGFlowRouterRootCreationBlock rootControllerCreation;
@property (nonatomic, strong) NSMutableArray *flowBars;

@property (nonatomic, strong) UIViewController<AGFlowController> *underlyingController;
@property (nonatomic, strong) AGPopoverController *currentPopover;

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

- (void)registerFlowBar:(nonnull UIView<AGFlowBar> *)flowBar {
  if (self.transitionManager) {
    [self.transitionManager registerFlowBar:flowBar];
  } else {
    [self.flowBars addObject:flowBar];
  }
}

- (void)registerRootControllerCreationBlock:(AGFlowRouterRootCreationBlock)creationBlock {
  self.rootControllerCreation = creationBlock;
}

- (void)registerControllerCreationBlock:(AGFlowRouterCreationBlock)creationBlock forIdentifier:(NSString *)identifier {
  self.creationBlocks[identifier] = creationBlock;
}

- (void)presentController:(UIViewController<AGFlowController> *)controller transition:(id<AGFlowTransition>)transition {
  self.underlyingController = nil;
  self.currentPopover = nil;
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

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller {
  self.underlyingController = self.transitionManager.rootViewController;

  AGPopoverController *popoverController = [AGPopoverController new];
  popoverController.contentController = controller;
  popoverController.visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  popoverController.windowSnapshot = [self.transitionManager.window snapshotImage];
  
  [self.transitionManager presentViewController:popoverController
                                     transition:[popoverController presentTransition]];
  self.currentPopover = popoverController;
}

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo {
  AGFlowRouterCreationBlock creationBlock = self.creationBlocks[identifier];
  if (creationBlock) {
    UIViewController<AGFlowController, AGPopoverContent> *vc = creationBlock(identifier, userInfo);
    if (vc) {
      [self presentInPopoverController:vc];
    }
  }
}

- (void)dismissCurrentPopoverController {
  if (self.underlyingController) {
   [self presentController:self.underlyingController transition:[self.currentPopover dismissTransition]];
    self.underlyingController = nil;
    self.currentPopover = nil;
  }
}


@end
