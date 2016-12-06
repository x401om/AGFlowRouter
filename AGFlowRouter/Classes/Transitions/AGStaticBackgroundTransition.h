//
//  AGStaticBackgroundTransition.h
//  Pods
//
//  Created by Aleksey Goncharov on 06.12.16.
//
//

#import "AGFlowTransition.h"

@interface AGStaticBackgroundTransition : NSObject<AGFlowTransition>

- (instancetype)initWithStaticView:(UIView *)staticView;

@end
