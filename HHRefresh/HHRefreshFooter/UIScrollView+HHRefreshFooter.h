//
//  UIScrollView+HHRefreshFooter.h
//  HHRefreshDemo
//
//  Created by water on 2018/3/8.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HHRefreshFooter)


@property (nonatomic,assign,getter=isHasMoreData) BOOL hasNoMoreData;

/**
 UIScrollView添加脚视图

 @param target  触发上拉加载后回调的对象
 @param action  触发上拉加载后回调的方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action;


/**
  脚视图结束刷新
 */
- (void)footerEndRefreshing;

- (void)removeFooter;


@end
