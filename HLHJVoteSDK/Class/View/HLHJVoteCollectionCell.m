//
//  HLHJVoteCollectionCell.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteCollectionCell.h"
#import "HLHJVoteCompetitorListModel.h"
@interface HLHJVoteCollectionCell()


@end

@implementation HLHJVoteCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        

        CGFloat Kmargin = 10;

        self.iconImg = [[UIImageView alloc] init];
        self.iconImg.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImg.clipsToBounds = YES;
        self.iconImg.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.iconImg];
        
        
        UIImageView *leftTopImageView = [[UIImageView alloc] init];
        leftTopImageView.backgroundColor = [UIColor clearColor];
        leftTopImageView.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_mask_mingci"];
        [self.iconImg addSubview:leftTopImageView];
        self.leftTopImageView = leftTopImageView;
        
        
        _rankingLab = [UILabel new];
        _rankingLab.font = [UIFont systemFontOfSize:10];
        _rankingLab.textColor = [UIColor colorWithRed:255/255.0 green:254.069/255.0 blue:254/255.0 alpha:1];
        _rankingLab.numberOfLines = 0;
        _rankingLab.textAlignment = NSTextAlignmentCenter;
        [leftTopImageView addSubview:_rankingLab];
        
        
        self.numberLab = [[UILabel alloc] init];
        self.numberLab.frame = CGRectMake(100,397,30.5,10);
        self.numberLab.text = @"9999";
        self.numberLab.font = [UIFont systemFontOfSize:15];
        self.numberLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.numberLab];
        
        self.NOLab = [[UILabel alloc] init];
        self.NOLab.frame = CGRectMake(84.5,417,48,9);
        self.NOLab.text = @"NO.1001";
        self.NOLab.font = [UIFont systemFontOfSize:13];
        self.NOLab.textColor = [UIColor colorWithRed:243.997/255.0 green:67.0038/255.0 blue:53.9988/255.0 alpha:1];
        [self.contentView addSubview:self.NOLab];
        
        self.voteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.voteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.voteBtn setTitle:@"投票" forState:UIControlStateNormal];
        self.voteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        if ([GetDefaults isEqualToString:@"red"]) {
             [self.voteBtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/btn_tijiao_red"] forState:UIControlStateNormal];
        }else {
            [self.voteBtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/Btn_tijiao"] forState:UIControlStateNormal];
        }
       
        [self.contentView addSubview:self.voteBtn];
        
        CGFloat width  = self.frame.size.width-5;
        [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).mas_offset(Kmargin);
            make.centerX.equalTo(self.contentView);
            
            make.width.height.mas_equalTo(width);
        }];

        [leftTopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.iconImg);
        }];
        [_rankingLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(leftTopImageView).mas_offset(5);
        }];
        
        
        [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImg);
            make.top.equalTo(self.iconImg.mas_bottom).mas_offset(Kmargin/2+5);
        }];
        
        [self.NOLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImg);
            make.top.equalTo(self.numberLab.mas_bottom).mas_offset(Kmargin/2 );
        }];
        
        [self.voteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImg);
            make.top.equalTo(self.NOLab.mas_bottom).mas_offset(Kmargin/2);
            make.width.mas_equalTo(124);
            make.height.mas_equalTo(36);
        }];
        
    }
    return self;
}

- (void)setModel:(HLHJVoteCompetitorListModel *)model {
    _model = model;
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,model.avatar]]];

    self.NOLab.text = [NSString stringWithFormat:@"NO.%@",model.competitor_id];
    
    if ([GetDefaults isEqualToString:@"red"]) {
        self.NOLab.textColor = [UIColor redColor];
    }else {
        self.NOLab.textColor = [UIColor blueColor];
    }
    
}

@end
