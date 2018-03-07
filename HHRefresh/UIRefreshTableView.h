//
//  UIRefreshTableView.h
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+HHRefresh.h"

@protocol HHRefreshDelegate <NSObject>
@required
-(void)refreshViewHeaderDidStartRefresh:(id)refreshView;
@optional
-(void)refreshViewLoadMoreDidStartFrefreh:(id)refreshView;
@end

@interface UIRefreshTableView : UITableView

@property (nonatomic,assign) BOOL canEnableLoadMore;
@property (nonatomic,assign) BOOL canEnableRefresh;
@property (nonatomic,weak)   id<HHRefreshDelegate> refreshDelegate;

@end
