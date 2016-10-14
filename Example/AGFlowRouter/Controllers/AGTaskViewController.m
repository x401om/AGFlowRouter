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
#import "AGPopoverToPopoverTransition.h"

@interface AGTaskViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurEffectView;

@end

@implementation AGTaskViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.layer.cornerRadius = 20.0f;
  self.view.clipsToBounds = YES;
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}
- (IBAction)closePressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] dismissCurrentPopoverController];
}

- (IBAction)showPopoverPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentInPopoverControllerId:@"TaskController"
                                                   userInfo:nil
                              replacingCurrentWithAnimation:arc4random() % 4];
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

#pragma mark - AGPopoverContent

- (CGSize)sizeForContentInPopoverController:(AGPopoverController *)popoverController {
  return CGSizeMake(300.0f, 300.0f);
}

- (void)popoverControllerDidTapBackground:(AGPopoverController *)popoverController {
  [[AGFlowRouter sharedRouter] dismissCurrentPopoverController];
}

@end
