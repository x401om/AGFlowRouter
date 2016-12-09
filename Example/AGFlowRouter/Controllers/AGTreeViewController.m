//
//  AGTreeViewController.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//


#import "AGTreeViewController.h"

#import "AGPopoverPresentTransition.h"

@interface AGTreeViewController ()

@end

@implementation AGTreeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}
- (IBAction)sunPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"FeedController" userInfo:nil transition:[AGDefaultPresentTrasition new]];
}
- (IBAction)applePressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentInPopoverControllerId:@"TaskController" userInfo:nil];
}
- (IBAction)pushPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"PushController" userInfo:nil transition:[AGDefaultPushTransition new]];
}

#pragma mark - AGFlowController

- (void)flowViewDidAppear:(BOOL)animated {
  
}

- (void)flowViewWillDisappear:(BOOL)animated {
  
}

@end
