//
//  AGControllersFabric.h
//  AGFlowController
//
//  Created by Aleksey Goncharov on 26.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

@import Foundation;

@interface AGControllersFabric : NSObject

+ (instancetype)sharedInstance;

- (void)registerControllersCreation;

@end
