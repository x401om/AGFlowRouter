//
//  AGPopoverDismissTransition.h
//  AGFlowTransitionManager
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGFlowTransition.h"

@interface AGPopoverDismissTransition : NSObject<AGFlowTransition>

- (instancetype)initWithVisualEffect:(UIVisualEffect *)visualEffect;

@end
