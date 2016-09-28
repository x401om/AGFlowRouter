//
//  AGControllersFabric.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 26.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGControllersFabric.h"
#import "AGFlowRouter.h"

@implementation AGControllersFabric

+ (instancetype)sharedInstance {
  static id _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[self alloc] init];
  });
  return _sharedInstance;
}

- (void)registerControllersCreation {
  [[AGFlowRouter sharedRouter] registerRootControllerCreationBlock:^UIViewController<AGFlowController> *{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TreeController"];
  }];
  
  [[AGFlowRouter sharedRouter] registerControllerCreationBlock:^UIViewController<AGFlowController> *(NSString *identifier, id userInfo) {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
  } forIdentifier:@"TreeController"];
  
  [[AGFlowRouter sharedRouter] registerControllerCreationBlock:^UIViewController<AGFlowController> *(NSString *identifier, id userInfo) {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
  } forIdentifier:@"TaskController"];
  
  [[AGFlowRouter sharedRouter] registerControllerCreationBlock:^UIViewController<AGFlowController> *(NSString *identifier, id userInfo) {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
  } forIdentifier:@"FeedController"];
  
  [[AGFlowRouter sharedRouter] registerControllerCreationBlock:^UIViewController<AGFlowController> *(NSString *identifier, id userInfo) {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
  } forIdentifier:@"CloudController"];
  
  [[AGFlowRouter sharedRouter] registerControllerCreationBlock:^UIViewController<AGFlowController> *(NSString *identifier, id userInfo) {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
  } forIdentifier:@"ProfileController"];
  [[AGFlowRouter sharedRouter] registerControllerCreationBlock:^UIViewController<AGFlowController> *(NSString *identifier, id userInfo) {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
  } forIdentifier:@"LeaderboardController"];
  
  [[AGFlowRouter sharedRouter] registerControllerCreationBlock:^UIViewController<AGFlowController> *(NSString *identifier, id userInfo) {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
  } forIdentifier:@"PushController"];
}

@end
