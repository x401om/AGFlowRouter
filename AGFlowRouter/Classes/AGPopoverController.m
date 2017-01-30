//
//  AGPopoverController.m
//  Upmind
//
//  Created by Aleksey Goncharov on 04.10.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

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

- (id<AGFlowTransition>)presentTransition {
  return [[AGPopoverPresentTransition alloc] initWithVisualEffect:self.visualEffect];
}

- (id<AGFlowTransition>)dismissTransition {
  return [[AGPopoverDismissTransition alloc] initWithVisualEffect:self.visualEffect];
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
