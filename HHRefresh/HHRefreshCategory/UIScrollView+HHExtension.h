//
//  UIScrollView+HHExtension.h
//  HHRefresh2.0
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HHExtension)
@property (assign, nonatomic) CGFloat contentInsetTop;
@property (assign, nonatomic) CGFloat contentInsetBottom;
@property (assign, nonatomic) CGFloat contentInsetLeft;
@property (assign, nonatomic) CGFloat contentInsetRight;

@property (assign, nonatomic) CGFloat contentOffsetX;
@property (assign, nonatomic) CGFloat contentOffsetY;

@property (assign, nonatomic) CGFloat contentSizeWidth;
@property (assign, nonatomic) CGFloat contentSizeHeight;

@property (assign, nonatomic) CGFloat scrollIndicatorInsetTop;
@property (assign, nonatomic) CGFloat scrollIndicatorInsetBottom;
@end
