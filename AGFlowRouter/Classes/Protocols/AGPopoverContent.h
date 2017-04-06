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

@import UIKit;

@class AGPopoverController;
@protocol AGFlowTransition;

NS_ASSUME_NONNULL_BEGIN

@protocol AGPopoverContent <NSObject>

@required

- (CGSize)sizeForContentInPopoverController:(AGPopoverController *)popoverController;

@optional

- (void)registerParentPopoverController:(AGPopoverController *)popoverController;

- (CGPoint)offsetForContentInPopoverController:(AGPopoverController *)popoverController;

- (CGSize)sizeForHeaderInPopoverController:(AGPopoverController *)popoverController;
- (CGSize)sizeForFooterInPopoverController:(AGPopoverController *)popoverController;
- (CGSize)sizeForShieldInPopoverController:(AGPopoverController *)popoverController;

- (CGFloat)overlayForHeaderInPopoverController:(AGPopoverController *)popoverController;
- (CGFloat)overlayForFooterInPopoverController:(AGPopoverController *)popoverController;
- (CGFloat)overlayForShieldInPopoverController:(AGPopoverController *)popoverController;

- (nullable UIView *)viewForHeaderInPopoverController:(AGPopoverController *)popoverController;
- (nullable UIView *)viewForFooterInPopoverController:(AGPopoverController *)popoverController;
- (nullable UIView *)viewForShieldInPopoverController:(AGPopoverController *)popoverController;

- (void)popoverControllerDidTapBackground:(AGPopoverController *)popoverController;

- (id<AGFlowTransition>)presentTransition;
- (id<AGFlowTransition>)dismissTransition;

@end

NS_ASSUME_NONNULL_END
