//
//  AGAppDelegate.m
//  AGFlowRouter
//
//  Created by Aleksey Goncharov on 09/27/2016.
//  Copyright (c) 2016 Aleksey Goncharov. All rights reserved.
//

#import "AGAppDelegate.h"

#import "AGFlowRouter.h"
#import "AGControllersFabric.h"
#import "AGInfoBar.h"
#import "AGTabBar.h"

@interface AGAppDelegate ()<AGTabBarDelegate>

@property (nonatomic, strong) AGControllersFabric *fabric;

@end

@implementation AGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window makeKeyAndVisible];
  
  self.fabric = [AGControllersFabric new];
  [self.fabric registerControllersCreation];
  
  AGTabBar *tabBar = [AGTabBar instantiateFromXib];
  tabBar.delegate = self;
  [[tabBar.items objectAtIndex:1] setSelected:YES];
  
  [[AGFlowRouter sharedRouter] registerFlowBar:tabBar];
  [[AGFlowRouter sharedRouter] registerFlowBar:[AGInfoBar instantiateFromXib]];
  
  
  return [[AGFlowRouter sharedRouter] application:application didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark - AGTabBarDelegate

- (void)tabBar:(AGTabBar *)tabBar didSelectItem:(AGTabBarItem *)item {
  NSUInteger index = [tabBar.items indexOfObject:item];
  switch (index) {
    case 0:
      [[AGFlowRouter sharedRouter] presentControllerId:@"ProfileController" userInfo:nil transition:nil];
      break;
    case 1:
      [[AGFlowRouter sharedRouter] presentControllerId:@"TreeController" userInfo:nil transition:nil];
      break;
    case 2:
      [[AGFlowRouter sharedRouter] presentControllerId:@"LeaderboardController" userInfo:nil transition:nil];
      break;
    default:
      break;
  }
}

- (AGTabBarItemAnimationType)tabBar:(AGTabBar *)tabBar animationTypeForItem:(AGTabBarItem *)item {
  NSUInteger index = [tabBar.items indexOfObject:item];
  switch (index) {
    case 0:
      return AGTabBarItemAnimationTypeRotation;
    case 1:
      return AGTabBarItemAnimationTypeFlipHorizontal;
    case 2:
      return AGTabBarItemAnimationTypeBounce;
    default:
      return AGTabBarItemAnimationTypeNone;
      break;
  }
}

@end
