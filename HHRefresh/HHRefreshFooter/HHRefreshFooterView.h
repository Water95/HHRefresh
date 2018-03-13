//
//  HHRefreshFooterView.h
//  HHRefreshDemo
//
//  Created by water on 2018/3/8.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark 控件的刷新状态
typedef  NS_ENUM(NSInteger,HHFooterRefreshState){
    HHRefreshStateNormal  = 1,     //正常,上拉加载更多（点击加载更多）
    HHRefreshStatePulling,         //释放可以刷新的状态
    HHRefreshStateRefreshing,      //正在刷新中的状态
    HHRefreshStateWillRefreshing,  //即将进入刷新的状态
    HHRefreshStateNoMoreData,      //没有更多数据的状态
};
@interface HHRefreshFooterView : UIView
@property (nonatomic, assign) BOOL hasNoMoreData;//没有更多数据了 YES 没有数据了 NO 有数据

/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTarget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;

+ (instancetype)footer;

- (void)footerEndRefreshing;

@end
