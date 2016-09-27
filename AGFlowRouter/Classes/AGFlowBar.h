//
//  AGFlowBar.h
//  AGFlowController
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

@import UIKit;

@protocol AGFlowBar <NSObject>

@required
+ (instancetype)instantiateFromXib;
- (CGRect)prefferedFrame;
- (NSString *)flowBarIdentifier;

@end
