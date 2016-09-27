//
//  AGFlowRouter.h
//  AGFlowController
//
//  Created by Aleksey Goncharov on 26.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowTransition.h"
#import "AGFlowController.h"

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

- (void)presentControllerId:(NSString *)identifier
                   userInfo:(nullable id)userInfo
                 transition:(nullable id<AGFlowTransition>)transition;

@end

NS_ASSUME_NONNULL_END
