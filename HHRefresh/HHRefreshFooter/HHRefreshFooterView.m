//
//  HHRefreshFooterView.m
//  HHRefreshDemo
//
//  Created by water on 2018/3/8.
//  Copyright © 2018年 water. All rights reserved.
//

#import "HHRefreshFooterView.h"
#import "HHRefreshConst.h"
#import "UIScrollView+HHExtension.h"
#import "UIView+HHExtension.h"
#import <objc/message.h>
@interface HHRefreshFooterView ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInset;
@property (assign, nonatomic) HHFooterRefreshState state;
@property (nonatomic, strong)  UILabel *footerTextLabel;

@end
@implementation HHRefreshFooterView
#pragma mark 控件的getter方法
- (UILabel *)footerTextLabel{
    if (!_footerTextLabel) {
        UILabel *footerTextLabel = [[UILabel alloc] init];
        footerTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        footerTextLabel.font = [UIFont boldSystemFontOfSize:13];
        footerTextLabel.textColor = [UIColor blackColor];
        footerTextLabel.backgroundColor = [UIColor blueColor];
        footerTextLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_footerTextLabel = footerTextLabel];
    }
    return _footerTextLabel;
}
+ (instancetype)footer{
    return [[self alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame{
    //1 设置footer的高度
    frame.size.height = 64;
    if (self = [super initWithFrame:frame]) {
        //2 设置属性
        self.hasNoMoreData = NO;
        //3 设置默认状态
        self.state = HHRefreshStateNormal;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setFrame:CGRectMake(self.x, self.y, self.width, 64)];
    
    self.footerTextLabel.frame = self.bounds;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    //1 移除旧的父控件
    [self.superview removeObserver:self forKeyPath:HHRefreshContentSize context:nil];
    
    if (newSuperview) {
        
        //2 设置宽度
        self.width = newSuperview.width;
        
        //3 记录最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
        _scrollView = (UIScrollView *)newSuperview;
        
        //4 监听新的父控件
        [newSuperview addObserver:self forKeyPath:HHRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:HHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        //5 重新调整frame
        [self adjustFrameWithContentSize];
        
        //记录UIScrollView最开始的contentInset
        
        self.scrollViewOriginalInset = self.scrollView.contentInset;
        
        
    }
}
#pragma mark 监听UIScrollview的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) {
        return;
    }
    
    if ([HHRefreshContentSize isEqualToString:keyPath]) {
        [self adjustFrameWithContentSize];
    }else if ([HHRefreshContentOffset isEqualToString:keyPath]){
        if (self.state == HHRefreshStateRefreshing) {
            return;
        }
        
        if (self.hasNoMoreData) {
            self.state = HHRefreshStateNoMoreData;
            return;
        }
        
        //调整状态
        [self adjustStateWithContentOff];
        
    }
    
}
#pragma mark 调整状态
- (void)adjustStateWithContentOff{
    
    //当前的contentOffset
    CGFloat currentOffSetY = self.scrollView.contentOffsetY;
    
    //尾部控件刚好出现的offSetY
    CGFloat happenOffSetY = [self happenOffsetY];
    
    //如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffSetY <= happenOffSetY) {
        return;
    }
    if (self.scrollView.isDragging) {
        //普通和即将刷新的临界点
        CGFloat normalPullingOffset = happenOffSetY + self.height;
        if (self.state == HHRefreshStateNormal && currentOffSetY > normalPullingOffset) {
            //转为即将刷新状态
            self.state = HHRefreshStatePulling;
        }else if (self.state == HHRefreshStatePulling && currentOffSetY <= normalPullingOffset){
            //转为普通状态
            self.state = HHRefreshStateNormal;
        }
    }else if (self.state == HHRefreshStatePulling){
        //开始刷新
        self.state = HHRefreshStateRefreshing;
    }
}

/**
 获取刚好看到上拉刷新控件是的contentOffSet.y
 
 @return 刚好看到上拉刷新控件是的contentOffSet.y
 */
- (CGFloat)happenOffsetY{
    
    CGFloat currentDistance = [self heightForContentBreakView];
    
    if (currentDistance > 0) {
        return  currentDistance-self.scrollViewOriginalInset.bottom-self.scrollViewOriginalInset.top;
    }else{
        return -self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    }
}


/**
 contentSize.height和展示内容高度的差值
 
 @return  contentSize.height和展示内容高度的差值
 */
- (CGFloat)heightForContentBreakView{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark 重新调整frame的y
- (void)adjustFrameWithContentSize{
    
    //内容的高度
    CGFloat contentHeight = self.scrollView.contentSizeHeight;
    
    //当contentHeight为0，footer应该在底部
    CGFloat scrollHeight = self.scrollView.height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
    //设置位置
    self.y = MAX(contentHeight, scrollHeight);
}


/**
 设置状态，根据状态，设置文字和contetInset的bottom
 
 @param state 状态
 */
- (void)setState:(HHFooterRefreshState)state{
    //1 一样的状态就直接返回
    if (self.state == state) {
        return;
    }
    //2 保存旧状态
    HHFooterRefreshState oldState = self.state;
    
    if (self.state != HHRefreshStateRefreshing) {
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
    switch (state) {
        case HHRefreshStateNormal:
        {
            self.footerTextLabel.text = RefreshFooterPullNormal;
            if (HHRefreshStateRefreshing == oldState) {
                [UIView animateWithDuration:0.4 animations:^{
                    if (self.hasNoMoreData) {
                        self.scrollView.contentInsetBottom = 0;
                    }else{
                        self.scrollView.contentInsetBottom = self.scrollViewOriginalInset.bottom;
                    }
                }];
            }else{
                
            }
        }
            break;
        case HHRefreshStatePulling:{
            
            self.footerTextLabel.text = RefreshFooterReleaseToRefresh;
            
        } break;
        case HHRefreshStateRefreshing:{
            
            //1 修改显示文字
            self.footerTextLabel.text = RefreshFooterRefreshing;
            
            //2 发送消息
            if (self.beginRefreshingTarget && [self.beginRefreshingTarget respondsToSelector:self.beginRefreshingAction]) {
                ((void(*)(id,SEL)) objc_msgSend)(self.beginRefreshingTarget,self.beginRefreshingAction);
            }
            
            //3 修改下边距
            [UIView animateWithDuration:0.4 animations:^{
                CGFloat bottom =  self.height;
                self.scrollView.contentInsetBottom = bottom;
            }];
            
        } break;
        case HHRefreshStateNoMoreData:{
            self.footerTextLabel.text = RefreshFooterNoMoreData;
        } break;
        default:
            break;
    }
    
    _state = state;
}

- (void)footerEndRefreshing{
    double delayInSeconds = 0.3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state =  HHRefreshStateNormal;
    });
}

- (void)setHasNoMoreData:(BOOL)hasNoMoreData{
    _hasNoMoreData = hasNoMoreData;
    if (hasNoMoreData) {
        self.state = HHRefreshStateNoMoreData;
    }else{
        self.state = HHRefreshStateNormal;
        self.scrollView.contentInsetBottom = self.height;
    }
}
@end
