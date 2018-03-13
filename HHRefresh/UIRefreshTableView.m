//
//  UIRefreshTableView.m
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "UIRefreshTableView.h"
@implementation UIRefreshTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self addHeaderWithTarget:self action:@selector(headerRefreshing)];
        [self addFooterWithTarget:self action:@selector(footerRefreshing)];
        self.canEnableRefresh = YES;
        self.canEnableLoadMore = NO;
    }
    return self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate{
    [super setDelegate:delegate];
    if (delegate) {
        self.refreshDelegate  = (id<HHRefreshDelegate>)delegate;
    }
}

- (void)headerRefreshing{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(refreshViewHeaderDidStartRefresh:)]) {
        [self.refreshDelegate refreshViewHeaderDidStartRefresh:self];
    }
}

- (void)footerRefreshing{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(refreshViewLoadMoreDidStartFrefreh:)]) {
        [self.refreshDelegate refreshViewLoadMoreDidStartFrefreh:self];
    }
}

- (void)setCanEnableRefresh:(BOOL)canEnableRefresh{
    
}
- (void)setCanEnableLoadMore:(BOOL)canEnableLoadMore{
    
}

@end
