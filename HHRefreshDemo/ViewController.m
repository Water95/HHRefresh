//
//  ViewController.m
//  HHRefreshFianl
//
//  Created by water on 2018/3/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "ViewController.h"
#import "UIRefreshTableView.h"

@interface ViewController()<UITableViewDelegate,UITableViewDataSource,HHRefreshDelegate>
@property (nonatomic,strong) UIRefreshTableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) BOOL noMoreData;

@property (nonatomic,assign) NSInteger current;

@end

@implementation ViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noMoreData = NO;
    
    [self refrehsData];
    
    [self configUI];
}

/**
   模拟下拉刷新
 */
- (void)refrehsData{
    self.current = 0;
    [self loadData];
}

/**
   模拟上拉加载数据
 */
- (void)loadMore{
    if (!self.noMoreData) {
        [self loadData];
    }
}

/**
  模拟网络请求数据
 */
- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSInteger i = self.current; i < self.current + 10; i++) {
            [tempArray addObject:[NSString stringWithFormat:@"%ld - %d ",i,arc4random()]];
        }
        
        if (self.current == 0) {
            self.noMoreData = NO;
            self.tableView.hasNoMoreData = NO;
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:tempArray];
        }else{
            [self.dataArray addObjectsFromArray:tempArray];
        }
        
        self.current += 10;
        
       
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        //模拟没有更多数据了
        if (self.current == 40) {
            self.noMoreData = YES;
            self.tableView.hasNoMoreData = YES;
        }
        
    });
 
}
- (void)configUI{
    
    self.tableView = [[UIRefreshTableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-200)];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"123"];
}
#pragma mark HHRefreshDelegate
- (void)refreshViewHeaderDidStartRefresh:(id)refreshView{
    [self refrehsData];
}

- (void)refreshViewLoadMoreDidStartFrefreh:(id)refreshView{
    [self loadMore];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

