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

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#endif

#import "AGFlowRouter.h"
#import "AGFlowTransitionManager.h"
#import "AGPopoverController.h"
#import "UIView+AGSnapshot.h"
#import "UIWindow+AGSnapshot.h"
#import "AGFlowBar.h"
#import "AGFlowController.h"
#import "AGPopoverContent.h"
#import "AGDefaultDismissTransition.h"
#import "AGDefaultPopTransition.h"
#import "AGDefaultPresentTrasition.h"
#import "AGDefaultPushTransition.h"
#import "AGFlowTransition.h"
#import "AGPopoverDismissTransition.h"
#import "AGPopoverPresentTransition.h"
#import "AGPopoverReplacementAnimation.h"
#import "AGPopoverToPopoverTransition.h"
#import "AGStaticBackgroundTransition.h"

FOUNDATION_EXPORT double AGFlowRouterVersionNumber;
FOUNDATION_EXPORT const unsigned char AGFlowRouterVersionString[];

