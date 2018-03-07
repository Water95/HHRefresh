//
//  UIScrollView+HHExtension.m
//  HHRefresh2.0
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "UIScrollView+HHExtension.h"

@implementation UIScrollView (HHExtension)
- (void)setContentInsetTop:(CGFloat)contentInsetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)contentInsetTop
{
    return self.contentInset.top;
}

- (void)setContentInsetBottom:(CGFloat)contentInsetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)contentInsetBottom
{
    return self.contentInset.bottom;
}

- (void)setContentInsetLeft:(CGFloat)contentInsetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)contentInsetLeft
{
    return self.contentInset.left;
}

- (void)setContentInsetRight:(CGFloat)contentInsetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)contentInsetRight
{
    return self.contentInset.right;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setContentSizeWidth:(CGFloat)contentSizeWidth
{
    CGSize size = self.contentSize;
    size.width = contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}

- (void)setContentSizeHeight:(CGFloat)contentSizeHeight
{
    CGSize size = self.contentSize;
    size.height = contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}

- (void)setScrollIndicatorInsetTop:(CGFloat)scrollIndicatorInsetTop
{
    UIEdgeInsets inset = self.scrollIndicatorInsets;
    inset.top = scrollIndicatorInsetTop;
    self.scrollIndicatorInsets = inset;
}

- (CGFloat)scrollIndicatorInsetTop {
    return self.scrollIndicatorInsets.top;
}

- (void)setScrollIndicatorInsetBottom:(CGFloat)scrollIndicatorInsetBottom
{
    UIEdgeInsets inset = self.scrollIndicatorInsets;
    inset.bottom = scrollIndicatorInsetBottom;
    self.scrollIndicatorInsets = inset;
}

- (CGFloat)scrollIndicatorInsetBottom {
    return self.scrollIndicatorInsets.bottom;
}
@end
