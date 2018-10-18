//
//  HLHJVoteController.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteController.h"

/** Controllers **/
#import "HLHJSignupController.h"

/** Model **/
#import "HLHJVoteCompetitorListModel.h"
#import "HLHJVoteActivityDetilModel.h"
#import "HLHJVoteShareModel.h"
/** Views**/
#import "HLHJVoteHeadView.h"
#import "HLHJVoteCollectionCell.h"
#import "HLHJSeeDetilView.h"
#import "HLHJVoteRuleView.h"
#import "UIView+HLHJGradient.h"
#import "UIColor+HLHJVoteHex.h"
#import "HLHJVoteSearchListView.h"
#import "UIScrollView+EmptyDataSet.h"
#import "NSString+HLHJExtention.h"


/** #define **/
#import "HLHJUUID.h"
#import "HLHJAlertViewTools.h"
#import <TMShare/TMShareInstance.h>
#import "SVProgressHUD.h"

@interface HLHJVoteController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

///
@property (nonatomic, strong) HLHJVoteHeadView *voteView;

@property (nonatomic, strong) HLHJVoteRuleView  *voteRuleView;

@property (nonatomic, strong) HLHJVoteSearchListView *listView;

@property (nonatomic, strong) HLHJVoteActivityDetilModel  *model;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIImageView  *rightImgaView;

@property (nonatomic, strong) UIImageView  *rightBottomImgaView;

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, strong) UITextField  *searchFiled;

@property (nonatomic, strong) UIView  *contentView;

@property (nonatomic, assign) NSInteger  page;

///选手列表数据
@property (nonatomic, strong) NSMutableArray  *competitorArr;

@property (nonatomic, strong) NSMutableArray  *screeningArr;

@property (nonatomic, assign) CGFloat  ruleHeight;

@property (nonatomic, strong) HLHJVoteShareModel  *shareModel;

@end

@implementation HLHJVoteController

@synthesize shareModel;

@synthesize collectionView;
#pragma mark - LifeCycle
- (void)viewWillDisappear:(BOOL)animated {
    [self.listView dismissAlertView];
    [super viewWillDisappear:animated];
 
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    HLHJNavBarView *navTitView = [[HLHJNavBarView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    navTitView.titleColor = [UIColor whiteColor];
    self.navigationItem.titleView = navTitView;
 

    _ruleHeight = 50;
    
    [self initUI];
    
    [self loadActivityDetilData];
    
    [self loadShareData];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat height = _state == 1 ? 10:-5;
    _contentView.frame = CGRectMake(15, CGRectGetMaxY(self.voteView.voteNumLab.frame)+height, self.view.frame.size.width-30, self.view.frame.size.height-CGRectGetMaxY(self.voteView.voteNumLab.frame)-20);
    collectionView.frame = CGRectMake(0, 60, _contentView.frame.size.width,_contentView.frame.size.height - 60);
}
#pragma mark - Delegate/DataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.competitorArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HLHJVoteCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HLHJVoteCollectionCell" forIndexPath:indexPath];
    NSString *title = _state == 1 ? @"投票" : @"查看资料";
    HLHJVoteCompetitorListModel *model = self.competitorArr[indexPath.row];
    if (_state == 1) {
        NSString *titleString = [NSString stringWithFormat:@"%@ %@ 票 ",model.competitor_name,model.ballot];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleString];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(model.competitor_name.length+1, model.ballot.length)];
        cell.numberLab.attributedText =  str;
        cell.leftTopImageView.hidden = NO;
        cell.rankingLab.text = [NSString stringWithFormat:@"TOP\n%ld",(long)indexPath.row+1];
    }else {
        cell.numberLab.text = model.competitor_name;
        cell.leftTopImageView.hidden = YES;
    }
    cell.model = model;
    cell.voteBtn.tag = indexPath.row;
    [cell.voteBtn setTitle:title forState:UIControlStateNormal];
    [cell.voteBtn addTarget:self action:@selector(viewInformationAction:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
           MJWeakSelf;
            HLHJVoteCompetitorListModel *model = self.competitorArr[indexPath.row];
            HLHJSeeDetilView *see = [[HLHJSeeDetilView alloc]initWithDateSource:model showVoteBtn:self->_state == 1 ? YES:NO];
            see.personBlock = ^(id data) {
            HLHJVoteCompetitorListModel *votemModel = (HLHJVoteCompetitorListModel *)data;
                [weakSelf startVoteAction:votemModel button:nil];
            };
            see.No =  indexPath.row+1;
            [see showView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.searchFiled isFirstResponder]) {
        [self.searchFiled resignFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([self.searchFiled isFirstResponder]) {
        [self.searchFiled resignFirstResponder];
    }
    if (self.searchFiled.text.length == 0) {
        [HLHJVoteToast hsShowBottomWithText:@"请输入选手姓名/编号"];
        return NO;
    }
    [self voteSearchName:self.searchFiled.text];
    return YES;

}


#pragma DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if ([GetDefaults isEqualToString:@"red"]) {
          return [UIImage imageNamed:@"HLHJVoteResource.bundle/img_def_red"];
    }else {
          return [UIImage imageNamed:@"HLHJVoteResource.bundle/img_def"];
    }
}
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    NSString *text = @"";
//
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
//     //设置所有字体大小为 #15
//    [attStr addAttribute:NSFontAttributeName
//                   value:[UIFont systemFontOfSize:14.0]
//                   range:NSMakeRange(0, text.length)];
//    // 设置所有字体颜色为浅灰色
//    [attStr addAttribute:NSForegroundColorAttributeName
//                   value:[UIColor lightGrayColor]
//                   range:NSMakeRange(0, text.length)];
////    // 设置指定2个字体为蓝色
////    [attStr addAttribute:NSForegroundColorAttributeName
////                   value:[UIColor colorWithHexString:@"#007EE5"]
////                   range:NSMakeRange(10, 2)];
//    return attStr;
//}

#pragma mark - DZNEmptyDataSetDelegate

//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
//
//    if (_state == 2) {
//        HLHJSignupController *sing = [HLHJSignupController new];
//        sing.model = self.model;
//        [self.navigationController pushViewController:sing animated:YES];
//    }
//}

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - Public Methods
- (void)initUI {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height-kNavBarHeight)];
    [self.view addSubview: self.scrollView];
    
    [self.scrollView addSubview:self.voteView];
    [self.scrollView addSubview:self.rightImgaView];
    [self.scrollView addSubview:self.contentView];
    [self.scrollView addSubview:self.voteRuleView];
    [self.scrollView addSubview:self.rightBottomImgaView];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,CGRectGetMaxY(self.voteRuleView.frame) + 30);
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_nav_fx"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    containView.backgroundColor = [UIColor clearColor];
    [containView addSubview:btn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:containView];
 
    [self.voteView.singUpBtn addTarget:self action:@selector(singUpAction:) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];

}

///加载活动详情
- (void)loadActivityDetilData {

    MJWeakSelf;
    [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_activity_api parameter:@{@"activity_id":_activity_id,@"user_sign":[HLHJUUID getDeviceIDInKeychain]} successComplete:^(id  _Nullable responseObject) {
        
        HLHJVoteActivityDetilModel *model = [HLHJVoteActivityDetilModel yy_modelWithJSON:responseObject[@"data"]];
        
          dispatch_async(dispatch_get_main_queue(), ^{
              
              weakSelf.voteView.titleLab.text = model.title;
              
                if (model.state == 1 ) {
                  weakSelf.voteView.timeLab.text  = [NSString stringWithFormat:@"活动时间:%@至%@",model.start_time,model.end_time];
                    
                }else {
                      weakSelf.voteView.timeLab.text  = [NSString stringWithFormat:@"报名时间:%@至%@",model.enroll_start,model.enroll_end];
                }
              
              weakSelf.voteRuleView.ruleArray = model.rule;
              
              for (NSString *str in model.rule) {
                  self->_ruleHeight = self->_ruleHeight + [str  getHeightLineWithString:str withWidth:weakSelf.view.frame.size.width-50 withFont:[UIFont systemFontOfSize:14]];
              }
              self->_ruleHeight = self->_ruleHeight + model.rule.count *10;
            
              ///更新frame
              weakSelf.voteRuleView.frame = CGRectMake(15, CGRectGetMaxY(weakSelf.contentView.frame)+10, weakSelf.view.frame.size.width-30, self->_ruleHeight);
              weakSelf.scrollView.contentSize = CGSizeMake(weakSelf.view.frame.size.width,CGRectGetMaxY(weakSelf.voteRuleView.frame) + 30);
              weakSelf.rightBottomImgaView.frame = CGRectMake(self.view.frame.size.width-80, CGRectGetMaxY(self.voteRuleView.frame)-80, 80, 100);
       
              if (model.state != 1 ) {
                  
                  weakSelf.voteView.voteNumLab.hidden = YES;
            
              }else {
                weakSelf.voteView.voteNumLab.hidden = NO;
                  weakSelf.voteView.voteNumLab.text = [NSString stringWithFormat:@"每人最多可以投%@票，您剩余%ld票",model.ballot_number,(long)model.user.ballot];
              }
              
              if (model.is_enroll == 1 && model.state == 2) {
                  weakSelf.voteView.singUpBtn.hidden = NO;
              }
          });
        
        weakSelf.model = model;
 
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
    
}

///加载分享数据;
- (void )loadShareData {
    
    [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_share_url_api parameter:@{@"activity_id":_activity_id} successComplete:^(id  _Nullable responseObject) {
        self->shareModel = [HLHJVoteShareModel yy_modelWithJSON:responseObject[@"data"]];
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
    
}
///加载选手数据
- (void)getCompetitorListDataSource:(NSInteger)page {
    
    MJWeakSelf;
    [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_competitor_list_api parameter:@{@"page":[@(page)  stringValue],@"limit":@"20",@"activity_id":_activity_id} successComplete:^(id  _Nullable responseObject) {
        if (weakSelf.page == 1 && weakSelf.competitorArr.count != 0) {
            [weakSelf.competitorArr removeAllObjects];
        }
        NSArray *tmpArr = responseObject[@"data"][@"list"];
        if (tmpArr.count > 0) {
            weakSelf.collectionView.mj_footer.hidden = NO;
            [weakSelf.collectionView.mj_footer resetNoMoreData];
            
            NSArray *dataArray = [NSArray yy_modelArrayWithClass:[HLHJVoteCompetitorListModel class]
                                                            json:tmpArr];
            
            [weakSelf.competitorArr addObjectsFromArray:dataArray];
        }else {
             weakSelf.collectionView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        [weakSelf.collectionView reloadData];
        [weakSelf endRefreshing];
        
    } failureComplete:^(NSError * _Nonnull error) {
        [weakSelf endRefreshing];
    }];
    
    
}
- (void)endRefreshing {
    if ([collectionView.mj_header isRefreshing]) {
        [collectionView.mj_header endRefreshing];
    }
    if ([collectionView.mj_footer isRefreshing]) {
        [collectionView.mj_footer endRefreshing];
    }
}

///搜索
- (void)voteSearchName:(NSString *)name {
    

    MJWeakSelf;
    [SVProgressHUD showWithStatus:@"查询中"];
    [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_search_competitor_api parameter:@{@"activity_id":_activity_id,@"name":name} successComplete:^(id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSArray *tmpArr = [NSArray yy_modelArrayWithClass:[HLHJVoteCompetitorListModel class] json:responseObject[@"data"][@"list"]];
        if(tmpArr.count > 0){
            [weakSelf.screeningArr removeAllObjects];
            [weakSelf.screeningArr addObjectsFromArray:tmpArr];
            [self showSerachListView];
        }else {
            [HLHJVoteToast hsShowBottomWithText:@"未查询到结果"];
        }
    } failureComplete:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
    
}
- (void)showSerachListView {
    
    if ([self.searchFiled isFirstResponder]) {
        
        [self.searchFiled resignFirstResponder];
    }
    
    if(![self.listView isDisplayedInScreen]) {
        
        self.searchFiled.layer.cornerRadius = 0;
        
         self.listView.screeingArr  = self.screeningArr;
        [self.listView showView];
       
        
        self.scrollView.scrollEnabled = NO;
        
        self.collectionView.scrollEnabled = NO;
    }
    MJWeakSelf;
    
    self.listView.clickCancelBlock = ^(NSInteger chooseIndex) {
        
        weakSelf.searchFiled.layer.cornerRadius = 20;
        
        weakSelf.scrollView.scrollEnabled = YES;
        
        weakSelf.collectionView.scrollEnabled = YES;
    
        
        
        HLHJVoteCompetitorListModel *votemModel = weakSelf.screeningArr[chooseIndex];
        
        if (_state == 1) {
             [weakSelf startVoteAction:votemModel button:nil];
        }else {
            HLHJSeeDetilView *see = [[HLHJSeeDetilView alloc]initWithDateSource:votemModel showVoteBtn:NO];
            [see showView];
        }
        
        
       
    };
}
#pragma mark - Private Methods

#pragma mark - Action Methods

///投票 或者查看详情
- (void)viewInformationAction:(UIButton *)sender {
    
     HLHJVoteCompetitorListModel *model = self.competitorArr[sender.tag];
    if (_state == 1) {
        [self startVoteAction:model button:sender];
    }else {
        HLHJSeeDetilView *see = [[HLHJSeeDetilView alloc]initWithDateSource:model showVoteBtn:NO];
        [see showView];
    }
}
- (void)startVoteAction:(HLHJVoteCompetitorListModel *)model button:(UIButton *)sender {
    
    MJWeakSelf;
    // 通常的alert
    NSString *str = [NSString stringWithFormat:@"确定给 \"%@\" 投上一票?",model.competitor_name];
    
    [[HLHJAlertViewTools shareInstance] showAlert:@"提示"
                                          message:str
                                      cancelTitle:@"点错了"
                                       titleArray:@[@"确定"]
                                   viewController:self
                                          confirm:^(NSInteger buttonTag) {
                                              // cancel按钮的index（buttonTag）是-1 cancelIndex
                                              if (buttonTag != -1) {
                                                  
                                                  [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_put_enroll_api parameter:@{@"competitor_id":model.competitor_id,@"user_id":self->_model.user.user_id} successComplete:^(id  _Nullable responseObject) {
                                                      
                                                      [HLHJVoteToast hsShowBottomWithText:@"投票成功"];
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          
                                                          HLHJVoteActivityDetilModel *dmdoel = weakSelf.model;
                                                          dmdoel.user.ballot = dmdoel.user.ballot-1;
                                                          weakSelf.model = dmdoel;
                                                          weakSelf.voteView.voteNumLab.text = [NSString stringWithFormat:@"每人最多可以投%@票，您剩余%ld票",self.model.ballot_number,(long)weakSelf.model.user.ballot];
                                                          
                                                          
                                                      });
                                                      
                                                      ///票数手动+1
                                                      model.ballot = [NSString stringWithFormat:@"%ld",(long)[model.ballot integerValue]+1];
                                                      
                                                      [weakSelf.competitorArr replaceObjectAtIndex:sender.tag withObject:model];
                                                      
                                                      ///冒泡排序
                                                      BOOL swapped = NO;
                                                      do {
                                                          swapped = NO;
                                                          for (int i = 1; i< self.competitorArr.count; i++) {
                                                              HLHJVoteCompetitorListModel *modelNum1 = self.competitorArr[i-1];
                                                              HLHJVoteCompetitorListModel *modelNum2 = self.competitorArr[i];
                                                              NSInteger num1 = [modelNum1.ballot integerValue];
                                                              NSInteger  num2 = [modelNum2.ballot integerValue];
                                                              if (num1 < num2) {
                                                                  [weakSelf.competitorArr replaceObjectAtIndex:i-1 withObject:modelNum2];
                                                                  [weakSelf.competitorArr replaceObjectAtIndex:i withObject:modelNum1];
                                                                  swapped = YES;
                                                              }
                                                          }
                                                      } while (swapped);
                                                      
                                                      [weakSelf.collectionView reloadData];
                                                      
                                                      
                                                      
                                                  } failureComplete:^(NSError * _Nonnull error) {
                                                      
                                                  }];
                                              }
                                              
                                          }];
    
    
}
- (void)searcAction:(UIButton *)sender{
    
    if ([self.searchFiled isFirstResponder]) {
        [self.searchFiled resignFirstResponder];
    }
    if (self.searchFiled.text.length == 0) {
        [HLHJVoteToast hsShowBottomWithText:@"请输入选手姓名"];
        return;
    }
    [self voteSearchName:self.searchFiled.text];
    
}

- (void)shareAction:(UIButton *)sender {

   
     TMShareConfig *config = [[TMShareConfig alloc] initWithTMBaseConfig];

     [[TMShareInstance instance] configWith:config];
    
     [[TMShareInstance instance]  showShare:shareModel.url thumbUrl:shareModel.image  title:shareModel.share_title descr:shareModel.share_title currentController:self finish:nil];
    

}
- (void)singUpAction:(UIButton *)sender {
    
    HLHJSignupController *sing = [HLHJSignupController new];
    sing.model = self.model;
    [self.navigationController pushViewController:sing animated:YES];
}

#pragma mark - Getter Methods

#pragma mark - Setter Methods

- (NSMutableArray *)competitorArr {
    if (!_competitorArr) {
        _competitorArr = [NSMutableArray array];
     }
    return _competitorArr;
}

- (NSMutableArray *)screeningArr {
    if (!_screeningArr) {
        _screeningArr = [NSMutableArray array];
    }
    return _screeningArr;
}


- (UIView *)contentView {
    
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.frame = CGRectMake(15, CGRectGetMaxY(self.voteView.timeLab.frame)-kNavBarHeight+20, self.view.frame.size.width-30, self.view.frame.size.height-CGRectGetMaxY(self.voteView.timeLab.frame)-20);
        _contentView.backgroundColor  = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8;
        _contentView.clipsToBounds = YES;
        
        ///搜索框
        UITextField *searchFiled = [[UITextField alloc]init];
        searchFiled.placeholder = @"请输入选手姓名/编号";
        searchFiled.textColor = [UIColor blackColor];
        searchFiled.font = [UIFont systemFontOfSize:15];
        searchFiled.frame = CGRectMake(15, 15, _contentView.frame.size.width-30, 40);
        searchFiled.layer.cornerRadius = 20;
        searchFiled.clipsToBounds = YES;
        searchFiled.layer.borderColor = [UIColor colorWithHexString:@"#C3C3C3"].CGColor;
        searchFiled.layer.borderWidth = 1;
        searchFiled.delegate = self;
        searchFiled.returnKeyType = UIReturnKeySearch;
        [_contentView addSubview:searchFiled];
        self.searchFiled = searchFiled;
        
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 10, 30);
        searchFiled.leftViewMode = UITextFieldViewModeAlways;
        searchFiled.leftView = leftView;

        UIButton *searchLogo = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchLogo setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic-search"] forState:UIControlStateNormal];
        searchLogo.frame = CGRectMake(0, 0, 40, 40);
        [searchLogo addTarget:self action:@selector(searcAction:) forControlEvents:UIControlEventTouchUpInside];
        searchFiled.rightViewMode = UITextFieldViewModeAlways;
        searchFiled.rightView = searchLogo;
        
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;//设置每个item之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0);
        layout.itemSize = CGSizeMake(self.view.frame.size.width/2-30,self.view.frame.size.width/2-30 + 90);
        
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, _contentView.frame.size.width,_contentView.frame.size.height - 60) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.emptyDataSetSource = self;
        collectionView.emptyDataSetDelegate = self;
        [collectionView registerClass:[HLHJVoteCollectionCell class] forCellWithReuseIdentifier:@"HLHJVoteCollectionCell"];
        [_contentView addSubview:collectionView];
        
        MJWeakSelf;
        collectionView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1 ;
            [weakSelf getCompetitorListDataSource:weakSelf.page];
        }];
        collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.page ++ ;
            [weakSelf getCompetitorListDataSource:weakSelf.page];
        }];
        collectionView.mj_footer.tintColor = [UIColor colorWithHexString:@"999999"];
        collectionView.mj_footer.hidden = YES;
        
    }
    return _contentView;
    
}


- (HLHJVoteHeadView *)voteView {
    if(!_voteView){
        _voteView = [[HLHJVoteHeadView alloc]init];
        _voteView.frame = CGRectMake(0, 0, self.view.frame.size.width, 328);
    }
    return _voteView;
}
- (HLHJVoteRuleView *)voteRuleView {
    if (!_voteRuleView) {
        
        _voteRuleView = [[HLHJVoteRuleView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.contentView.frame)+10, self.view.frame.size.width-30, _ruleHeight)];
        
        if ([GetDefaults isEqualToString:@"red"]) {
            [_voteRuleView setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]]
                                                 locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        }else {
          [_voteRuleView setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"#347DE0"],[UIColor colorWithHexString:@"#2FCBFF"]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        }
        _voteRuleView.layer.cornerRadius = 8;
        _voteRuleView.clipsToBounds = YES;
        
    }
    return _voteRuleView;
}
- (HLHJVoteSearchListView *)listView {
    if (!_listView) {
        _listView =  [[HLHJVoteSearchListView alloc]initWithFrame:CGRectMake(30,CGRectGetMinY(self.contentView.frame)+15+kNavBarHeight+40, self.searchFiled.frame.size.width, 44*6)];
    }
    return _listView;
}
-(UIImageView *)rightImgaView {
    if (!_rightImgaView) {
        _rightImgaView = [UIImageView new];
        _rightImgaView.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_bg_first_right"];
        _rightImgaView.frame = CGRectMake(self.view.frame.size.width-80, 400, 80, 100);
    }
    return _rightImgaView;
}
-(UIImageView *)rightBottomImgaView {
    if (!_rightBottomImgaView) {
        _rightBottomImgaView = [UIImageView new];
        _rightBottomImgaView.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_bg_second_right"];
        _rightBottomImgaView.frame = CGRectMake(self.view.frame.size.width-80, CGRectGetMaxY(self.voteRuleView.frame)-80, 80, 100);
    }
    return _rightBottomImgaView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
