//
//  AGFlowRouter.h
//  AGFlowController
//
//  Created by Aleksey Goncharov on 26.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGPopoverContent.h"
#import "AGFlowTransition.h"
#import "AGFlowController.h"

#import "AGPopoverReplacementAnimation.h"

typedef  UIViewController<AGFlowController> * _Nonnull (^AGFlowRouterRootCreationBlock)();
typedef UIViewController<AGFlowController> * _Nullable (^AGFlowRouterCreationBlock)( NSString * _Nonnull identifier, id _Nullable userInfo);

NS_ASSUME_NONNULL_BEGIN

@interface AGFlowRouter : NSObject

+ (instancetype)sharedRouter;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)registerFlowBar:(UIView<AGFlowBar> *)flowBar;
- (void)registerRootControllerCreationBlock:(AGFlowRouterRootCreationBlock)creationBlock;
- (void)registerControllerCreationBlock:(AGFlowRouterCreationBlock)creationBlock
                          forIdentifier:(NSString *)identifier;

- (void)presentController:(UIViewController<AGFlowController> *)controller
               transition:(nullable id<AGFlowTransition>)transition;
- (void)presentControllerId:(NSString *)identifier
                   userInfo:(nullable id)userInfo
                 transition:(nullable id<AGFlowTransition>)transition;

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller;

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo;

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller
     replacingCurrentWithAnimation:(AGPopoverReplacementAnimation)animation;

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
       replacingCurrentWithAnimation:(AGPopoverReplacementAnimation)animation;

- (void)dismissCurrentPopoverController;

@end

NS_ASSUME_NONNULL_END
