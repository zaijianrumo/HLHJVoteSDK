//
//  HLHJVoteRuleTableCell.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteRuleTableCell.h"

@implementation HLHJVoteRuleTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = 0;
        UILabel *label = [[UILabel alloc] init];
        label.text = @"1";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).mas_offset(10);
            make.width.mas_equalTo(0);
        }];
        label.clipsToBounds = YES;
        label.layer.cornerRadius = 20 / 2;
        self.numberLab = label;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"报名是否通过将以短信发送到您的手机，请注意查收。";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        self.titleLab = titleLabel;
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).mas_offset(10);
            make.right.equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.equalTo(self.contentView.mas_top).mas_offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-5);
        }];
        
        
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
