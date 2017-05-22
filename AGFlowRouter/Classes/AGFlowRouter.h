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

#import "AGPopoverContent.h"
#import "AGFlowTransition.h"
#import "AGFlowController.h"

#import "AGPopoverReplacementAnimation.h"

typedef  UIViewController<AGFlowController> * _Nonnull (^AGFlowRouterRootCreationBlock)();
typedef UIViewController<AGFlowController> * _Nullable (^AGFlowRouterCreationBlock)( NSString * _Nonnull identifier, id _Nullable userInfo);

NS_ASSUME_NONNULL_BEGIN

@interface AGFlowRouter : NSObject

- (UIViewController<AGFlowController> *)rootViewController;

+ (instancetype)sharedRouter;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)reloadRootController;

- (void)registerRootControllerCreationBlock:(AGFlowRouterRootCreationBlock)creationBlock;
- (void)registerControllerCreationBlock:(AGFlowRouterCreationBlock)creationBlock
                          forIdentifier:(NSString *)identifier;

- (void)presentController:(UIViewController<AGFlowController> *)controller
               transition:(nullable id<AGFlowTransition>)transition;
- (void)presentControllerId:(NSString *)identifier
                   userInfo:(nullable id)userInfo
                 transition:(nullable id<AGFlowTransition>)transition;


- (nullable UIViewController<AGFlowController> *)instantiateControllerId:(NSString *)identifier
                                                       userInfo:(nullable id)userInfo;
#pragma mark - FlowBars

- (void)registerFlowBar:(UIView<AGFlowBar> *)flowBar;
- (nullable UIView<AGFlowBar> *)flowBarWithIdentifier:(NSString *)identifier;

#pragma mark - Popovers

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller
                 presentTransition:(nullable id<AGFlowTransition>)presentTransition
                     snapshotImage:(nullable UIImage *)snapshotImage;

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller
                 presentTransition:(nullable id<AGFlowTransition>)presentTransition;

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
                   presentTransition:(nullable id<AGFlowTransition>)presentTransition;

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo
                   presentTransition:(nullable id<AGFlowTransition>)presentTransition
                       snapshotImage:(nullable UIImage *)snapshotImage;

- (void)presentInPopoverController:(UIViewController<AGFlowController, AGPopoverContent> *)controller;

- (void)presentInPopoverControllerId:(NSString *)identifier
                            userInfo:(nullable id)userInfo;

- (void)dismissCurrentPopoverController;

@end

NS_ASSUME_NONNULL_END
