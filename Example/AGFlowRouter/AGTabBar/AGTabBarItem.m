//
//  AGTabBarItem.m
//  AGFlowController
//
//  Created by Aleksey Goncharov on 27.09.16.
//  Copyright © 2016 Easy Ten LLC. All rights reserved.
//

#import "AGTabBarItem.h"

@interface AGTabBarItem ()

@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation AGTabBarItem

- (void)setImage:(UIImage *)image {
  _image = image;
  self.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setDefaultColor:(UIColor *)defaultColor {
  _defaultColor = defaultColor;
  
  if (!self.selected) {
    self.textLabel.textColor = defaultColor;
    self.imageView.tintColor = defaultColor;
  }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
  _selectedColor = selectedColor;
  
  if (self.selected) {
    self.textLabel.textColor = selectedColor;
    self.imageView.tintColor = selectedColor;
  }
}

- (void)setText:(NSString *)text {
  _text = text;
  self.textLabel.text = text;
}

- (void)setSelected:(BOOL)selected {
  _selected = selected;
  
  self.textLabel.textColor = selected ? self.selectedColor : self.defaultColor;
  self.imageView.tintColor = selected ? self.selectedColor : self.defaultColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self customInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self customInit];
  }
  return self;
}

- (void)prepareForInterfaceBuilder {
  [self customInit];
}

- (void)drawRect:(CGRect)rect {
  CGFloat h = 20.0f;
  self.textLabel.frame = CGRectMake(0.0f, rect.size.height - h, rect.size.width, h);
  self.imageView.frame = CGRectMake(0.0f, 2.0f, rect.size.width, rect.size.height - h);
  self.button.frame = rect;
}

- (void)customInit {
  UILabel *label = [UILabel new];
  label.text = @"text";
  label.font = [UIFont systemFontOfSize:10.0f];
  label.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
  label.textAlignment = NSTextAlignmentCenter;
  [self addSubview:label];

  self.textLabel = label;
  
  UIImageView *imageView = [UIImageView new];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  [self addSubview:imageView];
  self.imageView = imageView;
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [self addSubview:button];
  self.button = button;
}

- (void)showAnimation:(id<AGTabBarItemAnimator>)animation {
  [animation performAnimationForImageView:self.imageView textLabel:self.textLabel];
}

@end
