//
//  AGPopoverController.h
//  Upmind
//
//  Created by Aleksey Goncharov on 04.10.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGPopoverContent.h"
#import "AGFlowController.h"
#import "AGFlowTransition.h"

@class AGPopoverController;

NS_ASSUME_NONNULL_BEGIN

@interface AGPopoverController : UIViewController<AGFlowController>

@property (nonatomic, strong) UIViewController<AGFlowController> *baseController;

@property (nonatomic, strong) UIViewController<AGPopoverContent, AGFlowController> *contentController;
@property (nonatomic, strong) UIImage *windowSnapshot;
@property (nonatomic, strong) UIVisualEffect *visualEffect;

@property (nonatomic, readonly) UIView *headerView;
@property (nonatomic, readonly) UIView *footerView;

@property (nonatomic, strong) id<AGFlowTransition> presentTransition;
@property (nonatomic, strong) id<AGFlowTransition> dismissTransition;

- (instancetype)initWithContentCotroller:(UIViewController<AGPopoverContent, AGFlowController> *)contentController
                          baseController:(UIViewController<AGFlowController> *)baseController
                       presentTransition:(nullable id<AGFlowTransition>)presentTransition
                       dismissTransition:(nullable id<AGFlowTransition>)dismissTransition
                          windowSnapshot:(UIImage *)windowSnapshot;

@end

NS_ASSUME_NONNULL_END
