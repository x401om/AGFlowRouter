//
//  AGStatusBar.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 23.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGInfoBar.h"

@implementation AGInfoBar

+ (instancetype)instantiateFromXib {
  return [[[NSBundle mainBundle] loadNibNamed:@"AGInfoBar" owner:self options:nil] firstObject];
}

- (CGRect)prefferedFrame {
  return CGRectMake(0.0f, 0.0f, CGRectGetWidth([[UIScreen mainScreen] bounds]), 30.0f);
}

- (NSString *)flowBarIdentifier {
  return @"info";
}

@end
