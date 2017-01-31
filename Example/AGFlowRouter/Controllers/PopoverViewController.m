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

#import "PopoverViewController.h"

@interface PopoverViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurEffectView;

@property (nonatomic, weak) AGPopoverController *popoverController;

@end

@implementation PopoverViewController

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
  UIViewController<AGFlowController, AGPopoverContent> *controller =
  (UIViewController<AGFlowController, AGPopoverContent> *)[[AGFlowRouter sharedRouter] instantiateControllerId:@"PopoverViewController"
                                                                                                      userInfo:nil];
  
  AGPopoverToPopoverTransition *transition =
  [[AGPopoverToPopoverTransition alloc] initWithVisualEffect:self.popoverController.visualEffect
                                               snapshotImage:self.popoverController.windowSnapshot
                                                   animation:arc4random() % 4];
  
  AGPopoverController *popoverController =
  [[AGPopoverController alloc] initWithContentCotroller:controller
                                         baseController:self.popoverController.baseController
                                      presentTransition:transition
                                      dismissTransition:self.popoverController.dismissTransition
                                         windowSnapshot:self.popoverController.windowSnapshot];
  [[AGFlowRouter sharedRouter] presentController:popoverController transition:transition];
}

#pragma mark - AGPopoverContent

- (void)registerParentPopoverController:(AGPopoverController *)popoverController {
  self.popoverController = popoverController;
}

- (CGSize)sizeForContentInPopoverController:(AGPopoverController *)popoverController {
  return CGSizeMake(300.0f, 300.0f);
}

- (void)popoverControllerDidTapBackground:(AGPopoverController *)popoverController {
  [self closePressed:nil];
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
