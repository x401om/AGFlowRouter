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

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (BOOL)prefersStatusBarHidden {
  return YES;
}

#pragma mark - Actions

- (IBAction)closePressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentControllerId:@"MainViewController"
                                          userInfo:nil
                                        transition:[AGDefaultDismissTransition new]];
}

- (IBAction)showPopoverPressed:(UIButton *)sender {
  [[AGFlowRouter sharedRouter] presentInPopoverControllerId:@"PopoverViewController"
                                                   userInfo:nil ];
}

#pragma mark - AGFlowController

- (void)willPresentWithTransition:(id<AGFlowTransition>)transition
             previousControllerId:(NSString *)previousControllerId {
  
}

- (void)willDismissWithTransition:(id<AGFlowTransition>)transition
                 nextControllerId:(NSString *)nextControllerId {
  
}

- (void)flowViewDidAppear:(BOOL)animated {
  
}

- (void)flowViewWillDisappear:(BOOL)animated {
  
}

- (BOOL)prefersHideFlowBarWithIdentifier:(NSString *)identifier {
  return [identifier isEqual:@"tab"];
}

@end
