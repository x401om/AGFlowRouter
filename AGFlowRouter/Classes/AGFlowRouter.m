//
//  AGFlowRouter.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 26.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

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

- (void)presentControllerId:(NSString *)identifier userInfo:(id)userInfo transition:(id<AGFlowTransition>)transition {
  AGFlowRouterCreationBlock creationBlock = self.creationBlocks[identifier];
  [self.transitionManager presentViewController:creationBlock(identifier, userInfo)
                                     transition:transition];
}


@end
