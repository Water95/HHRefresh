//
//  UIScrollView+HHRefresh.h
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HHRefresh)
/**
 添加一个下拉刷新头部控件
 
 @param target 目标
 @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action;

/**
 移除下拉刷新头部控件
 */
- (void)removeHeader;

/**
 下拉刷新停止刷新状态
 */
- (void)headerEndRefreshing;
@end
