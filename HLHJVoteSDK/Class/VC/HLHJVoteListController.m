//
//  HLHJVoteListController.m
//  
//
//  Created by mac on 2018/8/6.
//

#import "HLHJVoteListController.h"

/** Controllers **/
#import "HLHJVoteController.h"
#import "HLHJSignupController.h"
#import "HLHJVotePayController.h"
/** Model **/
#import "HLHJVoteActivtyListModel.h"
/** Views**/
#import "HLHJVoteListCell.h"
/** #define **/

@interface HLHJVoteListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, assign) NSInteger  page;

@property (nonatomic, strong) NSMutableArray  *activtyListArr;
@end

@implementation HLHJVoteListController


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.page = 1;
    
    HLHJNavBarView *navTitView = [[HLHJNavBarView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    navTitView.titleColor = [UIColor whiteColor];
    self.navigationItem.titleView = navTitView;
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Delegate/DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activtyListArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   HLHJVoteListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HLHJVoteListCell"];
   cell.model = self.activtyListArr[indexPath.row];
   return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    HLHJVoteController *vote = [HLHJVoteController new];
    HLHJVoteActivtyListModel *model = self.activtyListArr[indexPath.row];
    vote.activity_id = model.activity_id;
    vote.state = model.state;
    vote.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vote animated:YES];
    
}
#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - Public Methods
- (void)getActivityListDataSource:(NSInteger)page {
    MJWeakSelf;
    [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_activity_list_api parameter:@{@"page":[@(page)  stringValue],@"limit":@"20"} successComplete:^(id  _Nullable responseObject) {
        if (weakSelf.page == 1 && weakSelf.activtyListArr.count != 0) {
            [weakSelf.activtyListArr removeAllObjects];
        }
        NSArray *tmpArr = responseObject[@"data"][@"list"];
        if (tmpArr.count > 0) {
            weakSelf.tableView.mj_footer.hidden = NO;
            [weakSelf.tableView.mj_footer resetNoMoreData];
             NSArray *dataArray = [NSArray yy_modelArrayWithClass:[HLHJVoteActivtyListModel class]
                                                            json:tmpArr];
 
            [weakSelf.activtyListArr addObjectsFromArray:dataArray];
            
        }else {
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshing];
        
    } failureComplete:^(NSError * _Nonnull error) {
        [weakSelf endRefreshing];
    }];
    
}
- (void)endRefreshing {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}
#pragma mark - Private Methods

#pragma mark - Action Methods

#pragma mark - Getter Methods


#pragma mark - Setter Methods

#pragma lazy

- (NSMutableArray *)activtyListArr {
    if (!_activtyListArr) {
        _activtyListArr = [NSMutableArray array];
    }
    return _activtyListArr;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[HLHJVoteListCell class] forCellReuseIdentifier:@"HLHJVoteListCell"];
        
        MJWeakSelf;
        _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1 ;
            [weakSelf getActivityListDataSource:weakSelf.page];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.page ++ ;
            [weakSelf getActivityListDataSource:weakSelf.page];
        }];
        _tableView.mj_footer.hidden = YES;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
