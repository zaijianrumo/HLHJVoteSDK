//
//  HLHJVoteListCell.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteListCell.h"
#import "HLHJVoteActivtyListModel.h"
#import "UIColor+HLHJVoteHex.h"
#import "UIImageView+HLHJExtension.h"
@interface HLHJVoteListCell()


@property (nonatomic, strong) UIImageView  *bgImg;

@property (nonatomic, strong) UIImageView  *listImg;

@property (nonatomic, strong) UILabel  *titleLab;

@property (nonatomic, strong) UILabel  *timeLab;

@end

@implementation HLHJVoteListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = 0;
    
        self.contentView.backgroundColor = [UIColor whiteColor];

        self.bgImg = [[UIImageView alloc] init];
        self.bgImg.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImg.clipsToBounds = YES;
        self.bgImg.backgroundColor = [UIColor clearColor];


        if ([GetDefaults isEqualToString:@"red"]) {
                    self.bgImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/list_bg_red"];
        }else {
                    self.bgImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/list_bg"];
        }

        //开始绘制图片
        [self.contentView addSubview:self.bgImg];
        self.listImg = [[UIImageView alloc] init];
        self.listImg.contentMode = UIViewContentModeScaleAspectFill;
        self.listImg.clipsToBounds = YES;
        self.listImg.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.bgImg addSubview:self.listImg];


        self.titleLab  = [UILabel new];
        self.titleLab.text = @"你最喜欢的女明星是谁？";
        self.titleLab.font = [UIFont systemFontOfSize:15];
        //阴影颜色
        if ([GetDefaults isEqualToString:@"red"]) {
            self.titleLab.shadowColor = [UIColor colorWithHexString:@"#ff0000"];
        }else {
            self.titleLab.shadowColor = [UIColor colorWithHexString:@"#0657c5"];
        }
        //阴影偏移  x，y为正表示向右下偏移
        self.titleLab.shadowOffset = CGSizeMake(.5, .5);
        self.titleLab.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        self.titleLab.numberOfLines = 2;
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        [self.bgImg addSubview:self.titleLab];


        self.timeLab = [[UILabel alloc] init];
        self.timeLab.frame = CGRectMake(145,146,199.5,11.5);
        self.timeLab.text = @"活动时间:2018-2-20至2018-3-20";
        self.timeLab.font = [UIFont systemFontOfSize:12];
        self.timeLab.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self.bgImg addSubview:self.timeLab];


        CGFloat Kmargin = 10;

        [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).mas_offset(Kmargin/2);
            make.left.equalTo(self.contentView).mas_offset(Kmargin);
            make.bottom.mas_equalTo(self.contentView).mas_offset(-Kmargin/2);
            make.right.equalTo(self.contentView).mas_offset(-Kmargin);
        }];


        [self.listImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.bgImg).mas_offset(Kmargin);
            make.centerY.equalTo(self.bgImg);
            make.height.mas_equalTo(68);
            make.width.mas_equalTo(109);
        }];

        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.listImg.mas_top);
            make.left.equalTo(self.listImg.mas_right).mas_offset(Kmargin);
            make.right.equalTo(self.bgImg).mas_offset(-Kmargin);
        }];

        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.listImg.mas_bottom);
            make.left.equalTo(self.listImg.mas_right).mas_offset(Kmargin);
            make.right.equalTo(self.bgImg).mas_offset(-Kmargin);
        }];

    }
    return self;
}

-(void)setModel:(HLHJVoteActivtyListModel *)model {
    
    _model = model;
    [self.listImg hlhj_setSixSideHeaderWithUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,model.activity_cover] placeholder:@""];
    self.titleLab.text = model.title;
    NSString *time1 = [NSString stringWithFormat:@"活动时间:%@至%@",model.start_time,model.end_time];
    NSString *time2 = [NSString stringWithFormat:@"报名时间:%@至%@",model.enroll_start,model.enroll_end];
    self.timeLab.text = model.state == 1 ? time1:time2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
