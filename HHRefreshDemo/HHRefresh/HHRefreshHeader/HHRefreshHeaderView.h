//
//  HHRefreshHeaderView.h
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark 控件的刷新状态
typedef  NS_ENUM(NSInteger,HHRefreshState){
    HHRefreshStateNormal  = 1,     //下拉可以刷新
    HHRefreshStatePulling,         //释放可以刷新的状态
    HHRefreshStateRefreshing,      //正在刷新中的状态
    HHRefreshStateWillRefreshing,  //即将进入刷新的状态
};

@interface HHRefreshHeaderView : UIView

/**
 设置是UIRefreshTableView的实例对象
 */
@property (nonatomic, weak)  id headerRefreshTarget;

/**
 设置是UIRefreshTableView的实现的方法
 */
@property (nonatomic, assign) SEL headerRefreshAction;

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

+ (instancetype)header;

- (void)headerBeginRefreshing;

- (void)headerEndRefreshing;

@end
