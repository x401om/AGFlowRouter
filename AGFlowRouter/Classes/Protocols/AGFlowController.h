//
//  AGFlowController.h
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

@import UIKit;

@protocol AGFlowBar;
@protocol AGFlowTransition;

@protocol AGFlowController <NSObject>

@optional
- (void)prepareForFlowTransition:(id<AGFlowTransition>)transition;

- (void)flowViewDidAppear:(BOOL)animated;
- (void)flowViewWillDisappear:(BOOL)animated;

- (BOOL)prefersHideFlowBarWithIdentifier:(NSString *)identifier;

@end
