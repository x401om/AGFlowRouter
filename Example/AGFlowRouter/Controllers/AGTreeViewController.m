//
//  AGTreeViewController.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowRouter.h"

#import "AGTreeViewController.h"

#import "AGDefaultPresentTrasition.h"
#import "AGDefaultDismissTransition.h"
#import "AGPopoverPresentTransition.h"

@interface AGTreeViewController ()

@end

@implementation AGTreeViewController

- (BOOL)prefersStatusBarHidden {
  return YES;
}
- (IBAction)sunPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"FeedController" userInfo:nil transition:[AGDefaultPresentTrasition new]];
}
- (IBAction)applePressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"TaskController" userInfo:nil transition:[AGPopoverPresentTransition new]];
}

#pragma mark - AGFlowController

- (void)flowViewDidAppear:(BOOL)animated {
  
}

- (void)flowViewWillDisappear:(BOOL)animated {
  
}

@end
