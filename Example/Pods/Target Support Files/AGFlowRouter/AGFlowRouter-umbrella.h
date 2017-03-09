#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
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

