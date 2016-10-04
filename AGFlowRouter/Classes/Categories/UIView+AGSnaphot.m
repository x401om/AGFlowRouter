//
//  UIView+AGSnaphot.m
//  Pods
//
//  Created by Aleksey Goncharov on 04.10.16.
//
//

#import "UIView+AGSnaphot.h"

@implementation UIView (AGSnaphot)

- (UIImage *)snapshotImage {
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
  [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}

@end
