//
//  HLHJSingupSuccesView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJSingupSuccesView.h"

@interface HLHJSingupSuccesView()
@property (nonatomic, strong) UIView  *alertView;
@end

@implementation HLHJSingupSuccesView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.alertView.frame = CGRectZero;
        
        [self addSubview:self.alertView];
        
        UIImageView *topimg = [[UIImageView alloc]init];
        topimg.userInteractionEnabled = YES;
        topimg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_pop_bg_r"];
        [self.alertView addSubview:topimg];
        [topimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.alertView);
        }];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_close_r"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [topimg addSubview:closeBtn];
        
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.top.equalTo(topimg).mas_offset(52);
            make.right.equalTo(topimg);
            make.width.height.mas_equalTo(40);
        }];
        
        
        
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/btn_qd_red"] forState:UIControlStateNormal];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [topimg addSubview:sureBtn];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(topimg).mas_offset(-32);
            make.centerX.equalTo(topimg);
        }];
        
        
        UILabel *titLab = [UILabel new];
        titLab.text = @"您已经已经报名参加本次活动咯，邀请好友一起参加吧~";
        titLab.numberOfLines = 0;
        titLab.textAlignment = NSTextAlignmentCenter;
        titLab.font = [UIFont systemFontOfSize:14];
        titLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        
        [topimg addSubview:titLab];
        [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(topimg);
            make.centerY.equalTo(topimg).mas_offset(20);
            make.width.mas_equalTo(152);
        }];
        
    }
    return self;
}

- (void)closeBtnAction:(UIButton *)sender {
    
    if(self.cancelBlock)
    [self dismissAlertView];
    self.cancelBlock();
    
}

- (void)showView {
    
    self.backgroundColor = [UIColor clearColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 0)/2,([UIScreen mainScreen].bounds.size.height - 0)/2,0,0);
    
    self.alertView.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.3
                         animations:^{
                             
                             self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
                             
                             self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2,([UIScreen mainScreen].bounds.size.height - 294-52)/2,300,294+52);
                             
                             self.alertView.alpha = 1;
                             
                         }completion:^(BOOL finish){
                             
                         }];
    }];
}

-(void)dismissAlertView {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2,([UIScreen mainScreen].bounds.size.height - 294-52)/2,300,294+52);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3
                         animations:^{
                             self.backgroundColor = [UIColor clearColor];
                             
                               self.alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 0)/2,([UIScreen mainScreen].bounds.size.height - 0)/2,0,0);
                             
                             self.alertView.alpha = 0.0;
                             
                         }completion:^(BOOL finish){
                             [self removeFromSuperview];
                         }];
    }];
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor clearColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
        _alertView.userInteractionEnabled = YES;
    }
    return _alertView;
}
@end

