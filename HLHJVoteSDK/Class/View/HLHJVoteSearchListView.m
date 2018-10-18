//
//  HLHJVoteSearchListView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteSearchListView.h"

#import "HLHJVoteCompetitorListModel.h"
@interface HLHJVoteSearchListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation HLHJVoteSearchListView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {

        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.tableView.layer.borderWidth = 1;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight  = 44;
        self.tableView.tableFooterView = [UIView new];
        [self addSubview:self.tableView];

    }
    return self;
    
}
- (void)setScreeingArr:(NSMutableArray *)screeingArr {
    _screeingArr = screeingArr;
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _screeingArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = 0;
    }
    HLHJVoteCompetitorListModel *model = _screeingArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    cell.textLabel.text = model.competitor_name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"NO.%@",model.competitor_id];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.clickCancelBlock) {
        self.clickCancelBlock(indexPath.row);
        [self hiddenAction];
    }

}
- (void)showView {
    
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width,0);
    self.tableView.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2
                         animations:^{
                             self.tableView.alpha = 1;
                             self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                         }completion:^(BOOL finish){
                             
                         }];
    }];
}

- (void)hiddenAction {
    
    [self dismissAlertView];
}


-(void)dismissAlertView {
    [UIView animateWithDuration:.2 animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2
                         animations:^{
                             self.tableView.frame = CGRectMake(0,0, self.frame.size.width,0);
                         }completion:^(BOOL finish){
                             [self removeFromSuperview];
                         }];
    }];
}
@end
