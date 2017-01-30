//
//  AGFeedViewController.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowRouter.h"

#import "AGFeedViewController.h"

#import "AGDefaultPresentTrasition.h"
#import "AGDefaultDismissTransition.h"
#import "AGPopoverPresentTransition.h"

@interface AGFeedViewController ()

@end

@implementation AGFeedViewController

- (BOOL)prefersStatusBarHidden {
  return YES;
}
- (IBAction)closePressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"TreeController" userInfo:nil transition:[AGDefaultDismissTransition new]];
}
- (IBAction)cloudPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentInPopoverControllerId:@"TaskController" userInfo:nil ];
}

#pragma mark - AGFlowController

- (void)flowViewDidAppear:(BOOL)animated {
  
}

- (void)flowViewWillDisappear:(BOOL)animated {
  
}

- (BOOL)prefersHideFlowBarWithIdentifier:(NSString *)identifier {
  return [identifier isEqual:@"tab"];
}

@end
