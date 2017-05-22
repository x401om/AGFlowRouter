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
#import "AGAppDelegate.h"

#import "AGFlowRouter.h"
#import "AGInfoBar.h"
#import "AGTabBar.h"

#import "ControllersFabric.h"

@interface AGAppDelegate ()<AGTabBarDelegate>

@property (nonatomic, strong) ControllersFabric *fabric;

@end

@implementation AGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window makeKeyAndVisible];
  
  self.fabric = [ControllersFabric new];
  [self.fabric registerControllersCreation];
  
  AGTabBar *tabBar = [AGTabBar instantiateFromXib];
  tabBar.delegate = self;
  [[tabBar.items objectAtIndex:1] setSelected:YES];
  
  [[AGFlowRouter sharedRouter] registerFlowBar:tabBar];
  [[AGFlowRouter sharedRouter] registerFlowBar:[AGInfoBar instantiateFromXib]];
  
  
  return [[AGFlowRouter sharedRouter] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [[AGFlowRouter sharedRouter] applicationDidBecomeActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  [[AGFlowRouter sharedRouter] applicationDidEnterBackground:application];
}

#pragma mark - AGTabBarDelegate

- (void)tabBar:(AGTabBar *)tabBar didSelectItem:(AGTabBarItem *)item {
  NSUInteger index = [tabBar.items indexOfObject:item];
  switch (index) {
    case 0:
      [[AGFlowRouter sharedRouter] presentControllerId:@"LeftViewController" userInfo:nil transition:nil];
      break;
    case 1:
      [[AGFlowRouter sharedRouter] presentControllerId:@"MainViewController" userInfo:nil transition:nil];
      break;
    case 2:
      [[AGFlowRouter sharedRouter] presentControllerId:@"RightViewController" userInfo:nil transition:nil];
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
