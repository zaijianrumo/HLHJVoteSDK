//
//  HLHJVoteHeadView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteHeadView.h"

@interface HLHJVoteHeadView()




@end

@implementation HLHJVoteHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        self.bgImg = [[UIImageView alloc] init];
        self.bgImg.userInteractionEnabled = YES;
        self.bgImg.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImg.clipsToBounds = YES;
        self.bgImg.backgroundColor = [UIColor clearColor];
        if ([GetDefaults isEqualToString:@"red"]) {
            self.bgImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_bg_first_red"];
        }else {
            self.bgImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_bg_first"];
        }

        [self addSubview:self.bgImg];
        
        //你最喜欢的女明星是谁？
        UILabel *label = [[UILabel alloc] init];
        label.text = @"                 ";
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"FZXHJW--GB1-0" size:26];
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.bgImg addSubview:label];
        self.titleLab = label;
        
        //每人最多可投10票，您已投1票
        UIButton *baomingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [baomingBtn setTitle:@"我要报名" forState:UIControlStateNormal];
        [baomingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        baomingBtn.titleLabel.font = [UIFont fontWithName:@"FZXHJW--GB1-0" size:14];
        [self.bgImg addSubview:baomingBtn];
        self.singUpBtn = baomingBtn;
        self.singUpBtn.hidden = YES;
        
    
        ///活动时间 ：2018-2-20至2018-3-20
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"            ";
        timeLabel.numberOfLines = 0;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.bgImg addSubview:timeLabel];
        self.timeLab = timeLabel;
        
        ///每人最多可投10票，您已投1票
        UILabel *voteNumLab = [[UILabel alloc] init];
        voteNumLab.text = @"           ";
        voteNumLab.font = [UIFont boldSystemFontOfSize:13];
        voteNumLab.numberOfLines = 0;
        voteNumLab.textAlignment = NSTextAlignmentCenter;
        voteNumLab.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.bgImg addSubview:voteNumLab];
        self.voteNumLab = voteNumLab;
      
        
        [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.equalTo(self);
            make.height.mas_equalTo(328);
        }];
        
        [baomingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImg).mas_offset(5);
            make.right.equalTo(self.bgImg).mas_offset(-15);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgImg);
            make.top.equalTo(self.bgImg.mas_top).mas_offset(30);
        }];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgImg);
            make.top.equalTo(self.titleLab.mas_bottom).mas_offset(20);
        }];
        [self.voteNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgImg);
            make.top.equalTo(self.timeLab.mas_bottom).mas_offset(10);
        }];

    }
    return self;
}

@end
