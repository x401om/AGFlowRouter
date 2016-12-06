//
//  AGPushViewController.m
//  AGFlowRouter
//
//  Created by Aleksey Goncharov on 28.09.16.
//  Copyright © 2016 Aleksey Goncharov. All rights reserved.
//

#import "AGPushViewController.h"

@interface AGPushViewController ()

@end

@implementation AGPushViewController

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (IBAction)popButtonPressed:(id)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"TreeController" userInfo:nil transition:[AGDefaultPopTransition new]];
}

#pragma mark - AGFlowController

- (void)prepareForFlowTransition:(id<AGFlowTransition>)transition {
  
}

- (void)flowViewDidAppear:(BOOL)animated {
  
}

- (void)flowViewWillDisappear:(BOOL)animated {
  
}

- (BOOL)prefersHideFlowBarWithIdentifier:(NSString *)identifier {
  return NO;
}

@end
