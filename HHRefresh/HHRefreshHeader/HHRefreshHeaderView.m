//
//  HHRefreshHeaderView.m
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "HHRefreshHeaderView.h"
#import "HHRefreshConst.h"
#import "UIView+HHExtension.h"
#import "UIScrollView+HHExtension.h"
#import <objc/message.h>

@interface HHRefreshHeaderView()

@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, weak, readwrite) UILabel *headerTextLabel;
@property (nonatomic, assign)  UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic, assign) HHRefreshState state;
@end

@implementation HHRefreshHeaderView
#pragma mark 控件的getter方法
- (UILabel *)headerTextLabel{
    if (!_headerTextLabel) {
        UILabel *headerTextLabel = [[UILabel alloc] init];
        headerTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        headerTextLabel.font = [UIFont boldSystemFontOfSize:13];
        headerTextLabel.textColor = [UIColor blackColor];
        headerTextLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_headerTextLabel = headerTextLabel];
    }
    return _headerTextLabel;
}

+ (instancetype)header{
    return  [[self alloc] init];
}

#pragma mark 初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    //1 设置header的高度
    frame.size.height = 64;
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        //2 设置默认状态
        self.state = HHRefreshStateNormal;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.headerTextLabel.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)drawRect:(CGRect)rect{
    if (self.state == HHRefreshStateWillRefreshing) {
        self.state = HHRefreshStateRefreshing;
    }
}
/**
 即将添加到父视图
 @param newSuperview 父视图
 */
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    //1 移除旧的控件的观察者
    [self.superview removeObserver:self forKeyPath:HHRefreshContentOffset context:nil];
    if (newSuperview) {
        //2 添加观察者
        [newSuperview addObserver:self forKeyPath:HHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        self.width = newSuperview.width;
        self.x = 0;
        _scrollView = (UIScrollView *)newSuperview;
        self.scrollViewOriginalInset = _scrollView.contentInset;
        self.y = -self.height;
    }
}

#pragma  mark  监听UIScrollView的contentOffSet属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    if (self.state == HHRefreshStateRefreshing) {
        return;
    }
    
    if ([HHRefreshContentOffset isEqualToString:keyPath]) {
        [self adjustStateWithContentOffset];
    }
}

/**
 根据contentOffSet 调整状态
 */
- (void)adjustStateWithContentOffset{
    //1 当前的contentOffSet
    CGFloat currentOffsetY = self.scrollView.contentOffsetY;
    
    //2 获取初始化设置的内容的上边距
    CGFloat happendOFFsetY = self.scrollViewOriginalInset.top;
    
    //3 如果大于0证明最上部的滚动内容已经不可见了
    if (currentOffsetY >= happendOFFsetY) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        //4 获取普通状态和即将刷新的临界点
        CGFloat normalPullingOffSetY = happendOFFsetY - self.height;
        
        if (self.state == HHRefreshStateNormal && currentOffsetY < normalPullingOffSetY ) {
            //5 满足松手刷新的状态
            self.state = HHRefreshStatePulling;
        }else if (self.state == HHRefreshStatePulling && currentOffsetY >= normalPullingOffSetY){
            self.state = HHRefreshStateNormal;
        }
    } else if (self.state == HHRefreshStatePulling){
        self.state = HHRefreshStateRefreshing;
    }
    
}
/**
 设置即将进入的状态，根据状态修改UI和回调
 
 @param state 即将进入的状态
 */
- (void)setState:(HHRefreshState)state{
    
    if (self.state == state) {
        return;
    }
    
    HHRefreshState oldState = self.state;
    
    switch (state) {
        case HHRefreshStateNormal:
        {
            if (oldState == HHRefreshStateRefreshing) {
                [UIView animateWithDuration:0.4 animations:^{
                    self.scrollView.contentInsetTop = 0;
                }];
            }
            self.headerTextLabel.text =  RefreshHeaderNormal;
        }
            break;
            
        case HHRefreshStatePulling:
        {
            self.headerTextLabel.text =  RefreshHeaderReleaseToRefresh;
        }
            break;
        case HHRefreshStateRefreshing:
        {
            //进入刷新状态，业务逻辑处理
            if (self.headerRefreshTarget && [self.headerRefreshTarget respondsToSelector:self.headerRefreshAction]) {
                ((void(*)(id,SEL))objc_msgSend)(self.headerRefreshTarget,self.headerRefreshAction);
            }
            //进入刷新状态
            [UIView animateWithDuration:0.4 animations:^{
                self.scrollView.contentInsetTop =  self.height;
            }];
            self.headerTextLabel.text = RefreshHeaderRefreshing;
        }
            break;
        case HHRefreshStateWillRefreshing:
        {
            self.headerTextLabel.text = RefreshHeaderRefreshing;
            
        }  break;
        default:
            break;
    }
    _state = state;
}
#pragma mark 开始刷新
- (void)headerBeginRefreshing{
    if (self.window) {
        self.state = HHRefreshStateRefreshing;
    }else{
        _state = HHRefreshStateWillRefreshing;
        [self  setNeedsDisplay];
    }
}
#pragma mark 结束刷新
- (void)headerEndRefreshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = HHRefreshStateNormal;
    });
}
@end
