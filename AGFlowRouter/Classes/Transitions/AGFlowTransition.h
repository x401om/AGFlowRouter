//
//  AGFlowTransition.h
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol AGFlowTransition <NSObject>

- (NSString *)transitionIdentifier;

- (void)performTrasitionForController:( UIViewController * )viewController
                   previousController:( UIViewController * )previousController
                               window:( UIWindow * )window
                       withCompletion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
