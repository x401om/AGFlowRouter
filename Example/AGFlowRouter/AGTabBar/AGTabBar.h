//
//  AGTabbar.h
//  AGFlowController
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowBar.h"
#import "AGTabBarItem.h"

NS_ASSUME_NONNULL_BEGIN

@class AGTabBar;

typedef NS_ENUM(NSUInteger, AGTabBarItemAnimationType) {
  AGTabBarItemAnimationTypeNone,
  AGTabBarItemAnimationTypeBounce,
  AGTabBarItemAnimationTypeRotation,
  AGTabBarItemAnimationTypeFlipHorizontal
};

@protocol AGTabBarDelegate<NSObject>
@optional

- (void)tabBar:(AGTabBar *)tabBar didSelectItem:(AGTabBarItem *)item;
- (AGTabBarItemAnimationType)tabBar:(AGTabBar *)tabBar animationTypeForItem:(AGTabBarItem *)item;

@end

@interface AGTabBar : UIView<AGFlowBar>

@property (nonatomic, weak) id<AGTabBarDelegate> delegate;
@property (nonatomic, strong) NSArray<AGTabBarItem *> *items;

@end

NS_ASSUME_NONNULL_END
