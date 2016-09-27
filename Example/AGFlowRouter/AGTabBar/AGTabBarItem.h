//
//  AGTabBarItem.h
//  AGFlowController
//
//  Created by Aleksey Goncharov on 27.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGTabBarItemAnimator.h"

IB_DESIGNABLE

NS_ASSUME_NONNULL_BEGIN

@interface AGTabBarItem : UIView

@property (nonatomic) BOOL selected;
@property (nonatomic, weak) UIButton *button;

- (void)showAnimation:(id<AGTabBarItemAnimator>)animation;

// IB

@property (nonatomic, strong) IBInspectable UIColor *selectedColor;
@property (nonatomic, strong) IBInspectable UIColor *defaultColor;

@property (nonatomic, strong) IBInspectable UIImage *image;
@property (nonatomic, strong) IBInspectable NSString *text;

@end

NS_ASSUME_NONNULL_END
