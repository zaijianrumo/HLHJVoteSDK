//
//  HLHJNavBarView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJNavBarView.h"

@interface HLHJNavBarView()
@property (nonatomic, strong) UILabel  *titleLabel;
@end

@implementation HLHJNavBarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        CGFloat Kmargin = 5;
        ///报名规则
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"投票报名";
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
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
    }
    return self;
    
}
- (void)setTitleFont:(UIFont *)titleFont {
    self.titleLabel.font  = titleFont;
}
- (void)setTitleString:(NSString *)titleString {
    self.titleLabel.text = titleString;
}
- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}
@end
