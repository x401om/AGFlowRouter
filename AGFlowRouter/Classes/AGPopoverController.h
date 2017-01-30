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

@property (nonatomic, strong) UIViewController<AGPopoverContent, AGFlowController> *contentController;
@property (nonatomic, strong) UIImage *windowSnapshot;
@property (nonatomic, strong) UIVisualEffect *visualEffect;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

- (id<AGFlowTransition>)presentTransition;
- (id<AGFlowTransition>)dismissTransition;

@end

NS_ASSUME_NONNULL_END
