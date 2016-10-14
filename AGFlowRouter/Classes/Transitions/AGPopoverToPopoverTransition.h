//
//  AGPopoverToPopoverTransition.h
//  Pods
//
//  Created by Aleksey Goncharov on 14.10.16.
//
//

#import "AGFlowTransition.h"
#import "AGPopoverReplacementAnimation.h"

@interface AGPopoverToPopoverTransition : NSObject<AGFlowTransition>

- (instancetype)initWithVisualEffect:(UIVisualEffect *)visualEffect
                       snapshotImage:(UIImage *)snapshotImage
                           animation:(AGPopoverReplacementAnimation)animation;

@end
