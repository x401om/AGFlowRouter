//
//  AGTabBarItemAnimation.h
//  AGFlowController
//
//  Created by Aleksey Goncharov on 27.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

@import UIKit;

@protocol AGTabBarItemAnimator <NSObject>

@required
- (void)performAnimationForImageView:(UIImageView *)imageView textLabel:(UILabel *)textLabel;

@end
