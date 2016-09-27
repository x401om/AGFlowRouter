//
//  AGTabbar.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGTabBar.h"

#import "AGTabBarItemBounceAnimator.h"
#import "AGTabBarItemRotationAnimator.h"
#import "AGTabBarItemFlipAnimator.h"

@implementation AGTabBar

+ (instancetype)instantiateFromXib {
  return [[[NSBundle mainBundle] loadNibNamed:@"AGTabBar" owner:self options:nil] firstObject];
}

- (CGRect)prefferedFrame {
  CGFloat h = 65.0f;
  return CGRectMake(0.0f, CGRectGetHeight([[UIScreen mainScreen] bounds]) - h, CGRectGetWidth([[UIScreen mainScreen] bounds]), h);
}

- (NSString *)flowBarIdentifier {
  return @"tab";
}

- (void)awakeFromNib {
  [super awakeFromNib];
  UIStackView *stack = [self.subviews lastObject];
  self.items = [NSArray arrayWithArray:stack.arrangedSubviews];
}

- (void)setItems:(NSArray<AGTabBarItem *> *)items {
  _items = items;
  
  for (AGTabBarItem *item in items) {
    [item.button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
  }
}


- (void)itemPressed:(UIButton *)button {

  for (AGTabBarItem *item in self.items) {
    item.selected = (item.button == button);
    
    if (item.button == button) {
      item.selected = YES;
      
      if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.delegate tabBar:self didSelectItem:item];
      }
      
      if ([self.delegate respondsToSelector:@selector(tabBar:animationTypeForItem:)]) {
        AGTabBarItemAnimationType type = [self.delegate tabBar:self animationTypeForItem:item];
        [item showAnimation:[self animatorForType:type]];
      }
      
    } else {
      item.selected = NO;
    }
  }
}

- (id<AGTabBarItemAnimator>)animatorForType:(AGTabBarItemAnimationType)type {
  switch (type) {
    case AGTabBarItemAnimationTypeBounce:
      return [AGTabBarItemBounceAnimator new];
    case AGTabBarItemAnimationTypeRotation:
      return [AGTabBarItemRotationAnimator new];
    case AGTabBarItemAnimationTypeFlipHorizontal:
      return [AGTabBarItemFlipAnimator new];
    default:
      return nil;
  }
}

@end
