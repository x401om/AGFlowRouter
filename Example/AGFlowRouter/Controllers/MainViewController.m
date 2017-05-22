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


#import "MainViewController.h"

#import "AGPopoverPresentTransition.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (BOOL)prefersStatusBarHidden {
  return YES;
}

#pragma mark - Actions

- (IBAction)showModalPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"ModalViewController"
                                          userInfo:nil
                                        transition:[AGDefaultPresentTrasition new]];
}

- (IBAction)showPopoverPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentInPopoverControllerId:@"PopoverViewController" userInfo:nil];
}

- (IBAction)showPushPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"PushViewController"
                                          userInfo:nil
                                        transition:[AGDefaultPushTransition new]];
}

#pragma mark - AGFlowController

#pragma mark - AGFlowController

- (void)willPresentWithTransition:(id<AGFlowTransition>)transition
             previousControllerId:(NSString *)previousControllerId {
  
}

- (void)willDismissWithTransition:(id<AGFlowTransition>)transition
                 nextControllerId:(NSString *)nextControllerId {
  
}

- (void)flowViewDidAppear:(BOOL)animated {
  NSLog(@"MainController didAppear");
}

- (void)flowViewWillDisappear:(BOOL)animated {
  NSLog(@"MainController willDisappear");
}

- (BOOL)prefersHideFlowBarWithIdentifier:(NSString *)identifier {
  return NO;
}

@end
