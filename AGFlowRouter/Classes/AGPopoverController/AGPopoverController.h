//
//  AGPopoverController.h
//  Upmind
//
//  Created by Aleksey Goncharov on 04.10.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

@import AGFlowRouter;

@class AGPopoverController;

@protocol AGPopoverContent <NSObject>

@required
- (CGSize)sizeForContentInPopoverController:(AGPopoverController *)popoverController;

@optional
- (CGPoint)offsetForContentInPopoverController:(AGPopoverController *)popoverController;

- (CGSize)sizeForHeaderInPopoverController:(AGPopoverController *)popoverController;
- (CGSize)sizeForFooterInPopoverController:(AGPopoverController *)popoverController;

- (CGFloat)overlayForHeaderInPopoverController:(AGPopoverController *)popoverController;
- (CGFloat)overlayForFooterInPopoverController:(AGPopoverController *)popoverController;

- (nullable UIView *)viewForHeaderInPopoverController:(AGPopoverController *)popoverController;
- (nullable UIView *)viewForFooterInPopoverController:(AGPopoverController *)popoverController;

- (void)popoverControllerDidTapBackground:(AGPopoverController *)popoverController;

@end

@interface AGPopoverController : UIViewController<AGFlowController>

@property (nonatomic, strong) UIViewController<AGPopoverContent, AGFlowController> *contentController;
@property (nonatomic, strong) UIImage *windowSnapshot;
@property (nonatomic, strong) UIVisualEffect *visualEffect;

@end
