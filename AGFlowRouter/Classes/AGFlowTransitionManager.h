//
//  AGFlowTransitionManager.h
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 22.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowTransition.h"
#import "AGFlowController.h"
#import "AGFlowBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface AGFlowTransitionManager : NSObject

- (instancetype)initWithRootViewController:(UIViewController<AGFlowController> *)rootViewController
                                    window:(UIWindow *)window;

- (void)registerFlowBar:(UIView<AGFlowBar> *)flowBar;

- (void)presentViewController:(UIViewController<AGFlowController> *)viewController
                   transition:(nullable id<AGFlowTransition>)transition;

@end

NS_ASSUME_NONNULL_END
