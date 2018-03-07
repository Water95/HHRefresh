//
//  UIScrollView+HHRefresh.m
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "UIScrollView+HHRefresh.h"
#import "HHRefreshHeaderView.h"
#import <objc/runtime.h>

@interface UIScrollView ()
@property(nonatomic,weak) HHRefreshHeaderView *header;
@end
@implementation UIScrollView (HHRefreshHeader)
#pragma mark seter和getter方法
static char HHRefreshHeaderViewKey;
-(void)setHeader:(HHRefreshHeaderView *)header{
    [self willChangeValueForKey:@"HHRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &HHRefreshHeaderViewKey, header, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"HHRefreshHeaderViewKey"];
}

-(HHRefreshHeaderView *)header{
    return  objc_getAssociatedObject(self, &HHRefreshHeaderViewKey);
}

/**
 添加一个下拉刷新头部控件
 
 @param target 目标
 @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action{
    //1 创建新的header
    if (!self.header) {
        HHRefreshHeaderView *header = [HHRefreshHeaderView header];
        [self addSubview:header];
        self.header = header;
    }
    //2 设置目标和回调方法
    self.header.headerRefreshTarget = target;
    self.header.headerRefreshAction = action;
}
/**
 移除下拉刷新头部控件
 */
- (void)removeHeader{
    [self.header removeFromSuperview];
    self.header = nil;
}

/**
 下拉刷新停止刷新状态
 */
- (void)headerEndRefreshing{
    [self.header headerEndRefreshing];
}


@end
