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

#import "AGPopoverContent.h"
#import "AGFlowController.h"
#import "AGFlowTransition.h"

@class AGPopoverController;

NS_ASSUME_NONNULL_BEGIN

@interface AGPopoverController : UIViewController<AGFlowController>

@property (nonatomic, strong) UIViewController<AGFlowController> *baseController;

@property (nonatomic, strong) UIViewController<AGPopoverContent, AGFlowController> *contentController;
@property (nonatomic, strong) UIImage *windowSnapshot;
@property (nonatomic, strong) UIVisualEffect *visualEffect;


- (instancetype)initWithContentCotroller:(UIViewController<AGPopoverContent, AGFlowController> *)contentController
                          baseController:(UIViewController<AGFlowController> *)baseController
                          windowSnapshot:(UIImage *)windowSnapshot;

- (nullable UIImageView *)backgroundView;
- (nullable UIVisualEffectView *)blurView;

- (nullable UIView *)headerView;
- (nullable UIView *)footerView;
- (nullable UIView *)shieldView;

- (id<AGFlowTransition>)presentTransition;
- (id<AGFlowTransition>)dismissTransition;

@end

NS_ASSUME_NONNULL_END
