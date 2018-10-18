//
//  HLHJSeeDetilView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJSeeDetilView.h"

#import "HLHJVoteCompetitorListModel.h"

@interface HLHJSeeDetilView()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UIButton  *canceBtn;

@property (nonatomic, strong) UIButton  *voteBtn;

@property (nonatomic, strong) UILabel  *NOLable;

@property (nonatomic, strong) HLHJVoteCompetitorListModel  *model;

@property (nonatomic, assign)NSInteger  alertHeight;

@end

@implementation HLHJSeeDetilView

-(instancetype)initWithDateSource:(id)data showVoteBtn:(BOOL )show {
    self = [super init];
    if (self) {

        self.frame = [UIScreen mainScreen].bounds;
        
        self.model = (HLHJVoteCompetitorListModel *)data;
        
        
        _alertHeight = show == YES ? 354+40:354;
        
        self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2,[UIScreen
                                                                                           mainScreen].bounds.size.height+([UIScreen mainScreen].bounds.size.height-354)/2,300,_alertHeight);
        
        self.canceBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-40)/2, CGRectGetMaxY(self.alertView.frame)+20, 40, 40);
        
        [self addSubview:self.canceBtn];
        [self addSubview:self.alertView];
        
    
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake((self.alertView.frame.size.width-67.5)/2,25,67,15.5);
        label.text = @"个人资料";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1];
        [self.alertView addSubview:label];
        
        UIView *redview = [[UIView alloc] init];
        redview.frame = CGRectMake((self.alertView.frame.size.width-26)/2,44,26,2);
        redview.backgroundColor = [UIColor colorWithRed:223.996/255.0 green:52/255.0 blue:52/255.0 alpha:1];
        [self.alertView addSubview:redview];
        
        ///头像
        UIImageView *logo = [[UIImageView alloc] init];
        logo.contentMode = UIViewContentModeScaleAspectFill;
        logo.clipsToBounds = YES;
        logo.backgroundColor = [UIColor groupTableViewBackgroundColor];
        logo.frame = CGRectMake((self.alertView.frame.size.width-91)/2, 60, 91, 91);
        [logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,self.model.avatar]]];
        [self.alertView addSubview:logo];
        
        //头像底部修饰
        UIImageView *btmImg = [[UIImageView alloc] init];
        btmImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_caida"];
        [self.alertView addSubview:btmImg];
        [btmImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(logo);
            make.top.equalTo(logo.mas_bottom).mas_offset(-15);
        }];
        btmImg.hidden = show == YES ? NO : YES;
        //排名
        UILabel *NOlabel = [[UILabel alloc] init];
        NOlabel.text = @"10";
        NOlabel.textAlignment = NSTextAlignmentCenter;
        NOlabel.font = [UIFont systemFontOfSize:13];
        NOlabel.textColor = [UIColor redColor];
        [btmImg addSubview:NOlabel];
        
        [NOlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btmImg);
            make.centerY.equalTo(btmImg).mas_offset(8);
        }];
        self.NOLable = NOlabel;

        //姓名
        CGFloat Kmagin = show == YES ? 40:20;
        UILabel *Namelabel = [[UILabel alloc] init];
        Namelabel.frame = CGRectMake(0,CGRectGetMaxY(logo.frame)+Kmagin,self.alertView.frame.size.width,15.5);
        Namelabel.text = self.model.competitor_name;
        Namelabel.textAlignment = NSTextAlignmentCenter;
        Namelabel.font = [UIFont systemFontOfSize:16];
        Namelabel.textColor = [UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1];
        [self.alertView addSubview:Namelabel];
        
        //编号
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.frame = CGRectMake(0,CGRectGetMaxY(Namelabel.frame)+5,self.alertView.frame.size.width,15.5);
        numberLabel.text = [NSString stringWithFormat:@"NO.%@",self.model.competitor_id];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.textColor = [UIColor colorWithRed:153.003/255.0 green:153.003/255.0 blue:153.003/255.0 alpha:1];
        [self.alertView addSubview:numberLabel];
        
        
        //简介
        CGFloat bottomHeiht = show == YES ? 40:0;

        UITextView *textView = [[UITextView alloc]init];
        textView.frame = CGRectMake(10, CGRectGetMaxY(numberLabel.frame)+10, self.alertView.frame.size.width-20, self.alertView.frame.size.height-CGRectGetMaxY(numberLabel.frame)-10-bottomHeiht -30);
        textView.editable = NO;
        textView.textAlignment = NSTextAlignmentCenter;
        textView.text =  self.model.profile;
        textView.font = [UIFont systemFontOfSize:13];
        textView.textColor = [UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1];
        [self.alertView addSubview:textView];
        
    
        self.voteBtn.frame = CGRectMake(30, CGRectGetMaxY(textView.frame)+10, self.alertView.frame.size.width-60,50);
        [self.alertView addSubview:self.voteBtn];
        self.voteBtn.hidden = show == YES ? NO : YES;
 
    }
    return self;
}
- (void)setNo:(NSInteger)No {
    _No = No;
    self.NOLable.text = [NSString stringWithFormat:@"%d 名",No];
    
}
- (void)showView {
    
    self.backgroundColor = [UIColor clearColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2,[UIScreen mainScreen].bounds.size.height+([UIScreen mainScreen].bounds.size.height-354)/2, 300,_alertHeight);
    
    self.alertView.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.3
                         animations:^{
                             
                             self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
                            
                             self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2,([UIScreen mainScreen].bounds.size.height-354)/2,300,self->_alertHeight);
                             
                             self.canceBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-40)/2, CGRectGetMaxY(self.alertView.frame)+20, 40, 40);
                        
                             self.alertView.alpha = 1;
                             
                         }completion:^(BOOL finish){
                             
                         }];
    }];
}

- (void)hiddenAction {
    [self dismissAlertView];
}
- (void)voteAction:(UIButton *)sender {
    if (self.personBlock) {
        self.personBlock(_model);
        [self hiddenAction];
    }
}
-(void)dismissAlertView {
    [UIView animateWithDuration:1 animations:^{
        self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2,([UIScreen mainScreen].bounds.size.height-354)/2,300,_alertHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08
                         animations:^{
                             
                                self.canceBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-30)/2, CGRectGetMaxY(self.alertView.frame)+20,0, 0);
                         }completion:^(BOOL finish){
                             [self removeFromSuperview];
                         }];
    }];
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
        _alertView.userInteractionEnabled = YES;
    }
    return _alertView;
}

- (UIButton *)canceBtn {
    if(!_canceBtn){
        _canceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_canceBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_close"] forState:UIControlStateNormal];
        [_canceBtn addTarget:self action:@selector(hiddenAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canceBtn;
}
- (UIButton *)voteBtn {
    if(!_voteBtn){
        _voteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_voteBtn setTitle:@"投票" forState:UIControlStateNormal];
        _voteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        if ([GetDefaults isEqualToString:@"red"]) {
            [_voteBtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/Btn_tijiao_red"] forState:UIControlStateNormal];
        }else {
            [_voteBtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/Btn_tijiao"] forState:UIControlStateNormal];
        }
        [_voteBtn addTarget:self action:@selector(voteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voteBtn;
}




@end
