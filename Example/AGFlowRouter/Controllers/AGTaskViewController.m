//
//  AGTaskViewController.m
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowRouter.h"

#import "AGTaskViewController.h"

#import "AGDefaultPresentTrasition.h"
#import "AGDefaultDismissTransition.h"
#import "AGPopoverDismissTransition.h"

@interface AGTaskViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurEffectView;

@end

@implementation AGTaskViewController

- (BOOL)prefersStatusBarHidden {
  return YES;
}
- (IBAction)closePressed:(UIButton *)sender {

  [[AGFlowRouter sharedRouter] presentControllerId:@"TreeController" userInfo:nil transition:[AGPopoverDismissTransition new]];
}

#pragma mark - AGFlowController

- (void)flowViewDidAppear:(BOOL)animated {
  
  self.backgroundImageView.hidden = NO;
  self.blurEffectView.hidden = NO;
  
}

- (void)flowViewWillDisappear:(BOOL)animated {
  
  self.backgroundImageView.hidden = YES;
  self.blurEffectView.hidden = YES;

}

- (BOOL)prefersHideFlowBarWithIdentifier:(NSString *)identifier {
  return YES;
}

@end
