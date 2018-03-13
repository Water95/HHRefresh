//
//  UIScrollView+HHRefreshFooter.m
//  HHRefreshDemo
//
//  Created by water on 2018/3/8.
//  Copyright © 2018年 water. All rights reserved.
//

#import "UIScrollView+HHRefreshFooter.h"
#import "HHRefreshFooterView.h"
#import <objc/message.h>

@interface UIScrollView()
@property (nonatomic, weak) HHRefreshFooterView *footer;
@end
@implementation UIScrollView (HHRefreshFooter)
static char HHRefreshFooterViewKey;

#pragma mark setter和getter方法
- (void)setFooter:(HHRefreshFooterView *)footer{
    [self willChangeValueForKey:@"HHRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &HHRefreshFooterViewKey, footer, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"HHRefreshFooterViewKey"];
}

- (HHRefreshFooterView *)footer{
    return objc_getAssociatedObject(self, &HHRefreshFooterViewKey);
}

/**
 UIScrollView添加脚视图
 
 @param target  触发上拉加载后回调的对象
 @param action  触发上拉加载后回调的方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action{
    //1 创建的footer
    if (!self.footer) {
        HHRefreshFooterView *footer = [HHRefreshFooterView footer];
        [self addSubview:footer];
        self.footer = footer;
    }
    //2 设置目标和回调方法
    self.footer.beginRefreshingTarget = target;
    self.footer.beginRefreshingAction = action;
    
}

/**
 脚视图结束刷新
 */
- (void)footerEndRefreshing{
    [self.footer footerEndRefreshing];
}

- (void)removeFooter{
    [self.footer removeFromSuperview];
    self.footer = nil;
}

#pragma mark 
- (void)setHasNoMoreData:(BOOL)hasNoMoreData{
    self.footer.hasNoMoreData = hasNoMoreData;
}
- (BOOL)isHasMoreData{
    return  self.footer.hasNoMoreData;
}
@end
