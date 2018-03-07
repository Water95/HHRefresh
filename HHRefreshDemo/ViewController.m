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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
- (void)configUI{
    self.tableView = [[UIRefreshTableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"123"];
}
#pragma mark HHRefreshDelegate
- (void)refreshViewHeaderDidStartRefresh:(id)refreshView{
    NSLog(@"开始刷新了");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"结束刷新了");
        [self.tableView headerEndRefreshing];
    });
}

- (void)refreshViewDidLoadMore:(id)refreshView{
    
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

