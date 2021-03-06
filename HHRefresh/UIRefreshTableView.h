//
//  UIRefreshTableView.h
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+HHRefresh.h"
#import "UIScrollView+HHRefreshFooter.h"
@protocol HHRefreshDelegate <NSObject>
@required
-(void)refreshViewHeaderDidStartRefresh:(id)refreshView;
@optional
-(void)refreshViewLoadMoreDidStartFrefreh:(id)refreshView;
@end

@interface UIRefreshTableView : UITableView


/**
 是否可以下拉刷新，默认是YES
 */
@property (nonatomic,assign) BOOL canEnableRefresh;

/**
  是否可以上拉加载更多，默认是NO
 */
@property (nonatomic,assign) BOOL canEnableLoadMore;

@property (nonatomic,weak)   id<HHRefreshDelegate> refreshDelegate;

@end
