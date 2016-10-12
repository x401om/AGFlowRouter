//
//  AGPopoverContent.h
//  Pods
//
//  Created by Aleksey Goncharov on 12.10.16.
//
//

@import UIKit;

@class AGPopoverController;

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
