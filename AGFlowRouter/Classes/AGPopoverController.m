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

@import PureLayout;

#import "AGPopoverController.h"
#import "AGPopoverPresentTransition.h"
#import "AGPopoverDismissTransition.h"

@interface AGPopoverController ()

@property (weak, nonatomic) UIImageView *backgroundView;
@property (weak, nonatomic) UIVisualEffectView *blurView;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;

@end

@implementation AGPopoverController

- (UIVisualEffect *)visualEffect {
  if (!_visualEffect) {
    _visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  }
  return _visualEffect;
}

- (id<AGFlowTransition>)presentTransition {
  if (!_presentTransition) {
    _presentTransition = [[AGPopoverPresentTransition alloc] initWithVisualEffect:self.visualEffect];
  }
  return _presentTransition;
}

- (id<AGFlowTransition>)dismissTransition {
  if (!_dismissTransition) {
    _dismissTransition = [[AGPopoverDismissTransition alloc] initWithVisualEffect:self.visualEffect];
  }
  return _dismissTransition;
}

- (instancetype)initWithContentCotroller:(UIViewController<AGPopoverContent, AGFlowController> *)contentController
                          baseController:(UIViewController<AGFlowController> *)baseController
                       presentTransition:(nullable id<AGFlowTransition>)presentTransition
                       dismissTransition:(nullable id<AGFlowTransition>)dismissTransition
                          windowSnapshot:(UIImage *)windowSnapshot {
  self = [super init];
  if (self) {
    _contentController = contentController;
    if ([_contentController respondsToSelector:@selector(registerParentPopoverController:)]) {
      [_contentController registerParentPopoverController:self];
    }    
    _baseController = baseController;
    _presentTransition = presentTransition;
    _dismissTransition = dismissTransition;
    _windowSnapshot = windowSnapshot;
  }
  return self;
}

- (BOOL)prefersStatusBarHidden {
  return [self.contentController prefersStatusBarHidden];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self layoutBackground];
  [self layoutContent];
  [self layoutHeader];
  [self layoutFooter];
}

- (void)layoutBackground {
  UIImageView *backgroundView = [[UIImageView alloc] initWithImage:self.windowSnapshot];
  [self.view addSubview:backgroundView];
  [backgroundView autoPinEdgesToSuperviewEdges];
  self.backgroundView = backgroundView;
  
  UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:self.visualEffect];
  [self.view addSubview:blurView];
  [blurView autoPinEdgesToSuperviewEdges];
  self.blurView = blurView;
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
  [self.blurView addGestureRecognizer:tap];
  
  self.backgroundView.hidden = YES;
  self.blurView.hidden = YES;
}

- (void)layoutContent {
  [self.contentController willMoveToParentViewController:self];
  
  CGSize contentSize = [self.contentController sizeForContentInPopoverController:self];
  [self.view addSubview:self.contentController.view];
  
  CGPoint offset = CGPointZero;
  if ([self.contentController respondsToSelector:@selector(offsetForContentInPopoverController:)]) {
    offset = [self.contentController offsetForContentInPopoverController:self];
  }
  
  [self.contentController.view autoSetDimensionsToSize:contentSize];
  [self.contentController.view autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:offset.y];
  [self.contentController.view autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view withOffset:offset.x];
  
  [self.contentController didMoveToParentViewController:self];
}

- (void)layoutHeader {
  
  CGSize headerSize = CGSizeZero;
  if ([self.contentController respondsToSelector:@selector(sizeForHeaderInPopoverController:)]) {
    headerSize = [self.contentController sizeForHeaderInPopoverController:self];
  }
  
  CGFloat overlay = 0.0f;
  if ([self.contentController respondsToSelector:@selector(overlayForHeaderInPopoverController:)]) {
    overlay = [self.contentController overlayForHeaderInPopoverController:self];
  }

  UIView *headerView = nil;
  if ([self.contentController respondsToSelector:@selector(viewForHeaderInPopoverController:)]) {
    headerView = [self.contentController viewForHeaderInPopoverController:self];
  }
  
  if (headerView && CGSizeEqualToSize(headerSize, CGSizeZero) == NO) {
    
    [self.view addSubview:headerView];
    
    [headerView autoSetDimensionsToSize:headerSize];
    [headerView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentController.view];
    [headerView autoPinEdge:ALEdgeBottom
                     toEdge:ALEdgeTop
                     ofView:self.contentController.view
                 withOffset:overlay];
    
    self.headerView = headerView;
  }
  
}

- (void)layoutFooter {
  
  CGSize footerSize = CGSizeZero;
  if ([self.contentController respondsToSelector:@selector(sizeForFooterInPopoverController:)]) {
    footerSize = [self.contentController sizeForFooterInPopoverController:self];
  }
  
  CGFloat overlay = 0.0f;
  if ([self.contentController respondsToSelector:@selector(overlayForFooterInPopoverController:)]) {
    overlay = [self.contentController overlayForFooterInPopoverController:self];
  }
  
  UIView *footerView = nil;
  if ([self.contentController respondsToSelector:@selector(viewForFooterInPopoverController:)]) {
    footerView = [self.contentController viewForFooterInPopoverController:self];
  }
  
  if (footerView && CGSizeEqualToSize(footerSize, CGSizeZero) == NO) {
    
    [self.view addSubview:footerView];
    
    [footerView autoSetDimensionsToSize:footerSize];
    [footerView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentController.view];
    [footerView autoPinEdge:ALEdgeTop
                     toEdge:ALEdgeBottom
                     ofView:self.contentController.view
                 withOffset:-overlay];
    self.footerView = footerView;
  }
  
}

#pragma mark - Actions

- (void)tap:(UITapGestureRecognizer *)sender {
  if ([self.contentController respondsToSelector:@selector(popoverControllerDidTapBackground:)]) {
    [self.contentController popoverControllerDidTapBackground:self];
  }
}

#pragma mark - AGFlowController

- (void)flowViewDidAppear:(BOOL)animated {
  self.backgroundView.hidden = NO;
  self.blurView.hidden = NO;
  
  if ([self.contentController respondsToSelector:@selector(flowViewDidAppear:)]) {
    [self.contentController flowViewDidAppear:animated];
  }
}

- (void)flowViewWillDisappear:(BOOL)animated {
  self.backgroundView.hidden = YES;
  self.blurView.hidden = YES;
  
  if ([self.contentController respondsToSelector:@selector(flowViewWillDisappear:)]) {
    [self.contentController flowViewWillDisappear:animated];
  }
}

- (BOOL)prefersHideFlowBarWithIdentifier:(NSString *)identifier {
  if ([self.contentController respondsToSelector:@selector(prefersHideFlowBarWithIdentifier:)]) {
    return [self.contentController prefersHideFlowBarWithIdentifier:identifier];
  } else {
    return YES;
  }
}

@end
