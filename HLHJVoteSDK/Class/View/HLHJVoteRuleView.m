//
//  HLHJVoteRuleView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteRuleView.h"

#import "HLHJVoteRuleTableCell.h"

@interface HLHJVoteRuleView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) CGFloat  allHeight;

@property (nonatomic, strong) UITableView  *tableView;

@end

static const CGFloat Kmargin = 10;

@implementation HLHJVoteRuleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        ///报名规则
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"活动规则";
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        self.titleLab = titleLabel;
        [self addSubview:titleLabel];
 
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).mas_offset(Kmargin);
        }];
        
        UIImageView *leftImg = [UIImageView new];
        leftImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/nav_left"];
        [self addSubview:leftImg];

        UIImageView *rightImg = [UIImageView new];
        rightImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/nav_right"];
        [self addSubview:rightImg];
        
        [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLabel);
            make.right.equalTo(titleLabel.mas_left).mas_offset(-Kmargin);
        }];
        [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLabel);
            make.left.equalTo(titleLabel.mas_right).mas_offset(Kmargin);
        }];
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(titleLabel.mas_bottom).mas_offset(Kmargin *2);
        }];
        _allHeight = 0;
    }
    return self;
    
}

- (void)setRuleArray:(NSArray *)ruleArray {
    _ruleArray = ruleArray;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ruleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLHJVoteRuleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HLHJVoteRuleTableCell"];
    cell.titleLab.text = _ruleArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1f;
}
#pragma lazy
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.estimatedRowHeight = 34;
        [_tableView registerClass:[HLHJVoteRuleTableCell class] forCellReuseIdentifier:@"HLHJVoteRuleTableCell"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

@end
