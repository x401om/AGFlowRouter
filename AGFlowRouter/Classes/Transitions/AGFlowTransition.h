//
//  AGFlowTransition.h
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

@import UIKit;

@protocol AGFlowTransition <NSObject>

- (void)performTrasitionForController:( UIViewController * _Nonnull )viewController
                   previousController:( UIViewController * _Nonnull )previousController
                               window:( UIWindow * _Nonnull )window
                       withCompletion:(void (^ __nonnull)(BOOL finished))completion;

@end
