//
//  HLHJVotePayController.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVotePayController.h"

/** Controllers **/

/** Model **/

/** Views**/
#import "HLHJPaySowView.h"
#import "SVProgressHUD.h"
#import "UIImage+HLHJExtension.h"
/** #define **/

@interface HLHJVotePayController ()

@property (nonatomic, strong) UIButton  *wPayBtn;

@property (nonatomic, strong) UIButton  *zPayBtn;

@property (nonatomic, assign) NSInteger  pay_way;

@end

@implementation HLHJVotePayController


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    HLHJNavBarView *navTitView = [[HLHJNavBarView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    navTitView.titleColor = [UIColor whiteColor];
    self.navigationItem.titleView = navTitView;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    [self setUI];
}


- (void)setUI {
        UIView *moneyBgView = [UIView new];
        moneyBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:moneyBgView];
        [moneyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
    
        UILabel *moneylab = [UILabel new];
        moneylab.textColor = [UIColor blackColor];
        moneylab.font = [UIFont systemFontOfSize:15];
        [moneyBgView addSubview:moneylab];
        [moneylab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(moneyBgView);
            make.left.equalTo(moneyBgView.mas_left).mas_offset(10);
        }];
    NSString *text  = [NSString stringWithFormat:@"报名费用: %@ 元",_entry_fee];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:14.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor blackColor]
                   range:NSMakeRange(0, text.length)];
    // 设置指定2个字体为蓝色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor redColor]
                   range:NSMakeRange(6, _entry_fee.length)];
    moneylab.attributedText = attStr;
        ///微信支付
        UIView *weiinBgView = [UIView new];
        weiinBgView.userInteractionEnabled = YES;
        weiinBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:weiinBgView];
        [weiinBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.equalTo(moneyBgView);
            make.top.equalTo(moneyBgView.mas_bottom).mas_offset(10);
        }];

    
        UIButton *weiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [weiBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_zhifu_wechat"] forState:UIControlStateNormal];
        [weiBtn setTitle:@"    微信支付" forState:UIControlStateNormal];
        [weiBtn setTitleColor:[UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1] forState:UIControlStateNormal];
        weiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        weiBtn.userInteractionEnabled = NO;
        [weiinBgView addSubview:weiBtn];
    
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [payBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_selected"] forState:UIControlStateNormal];
        [weiinBgView addSubview:payBtn];
        _wPayBtn = payBtn;
    
        [weiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weiinBgView);
            make.left.equalTo(weiinBgView.mas_left).mas_offset(10);
        }];
        [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weiinBgView);
            make.right.equalTo(weiinBgView.mas_right).mas_offset(-10);
        }];
    
    //    ///去支付
        UIButton *zfbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([GetDefaults isEqualToString:@"red"]) {
           [zfbtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/btn_zhifu_red"] forState:UIControlStateNormal];
        }else {
            [zfbtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/btn_zhifu"] forState:UIControlStateNormal];
        }
        [zfbtn setTitle:@"去支付" forState:UIControlStateNormal];
        [zfbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        zfbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.view  addSubview:zfbtn];
    
        [zfbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view );
            make.top.equalTo(weiinBgView.mas_bottom ).mas_offset(70);
        }];
        [zfbtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
}

/////获取支付方式
//-(void)get_payData {
//
//    [SVProgressHUD showWithStatus:nil];
//    [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_pay_api parameter:nil successComplete:^(id  _Nullable responseObject) {
//        [SVProgressHUD dismiss];
//        NSDictionary *dict = responseObject[@"data"];
//
//        [self setUI:dict];
//
//    } failureComplete:^(NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//    }];
//
//}


//- (void)setUI:(NSDictionary *)dict {


//    UIView *moneyBgView = [UIView new];
//    moneyBgView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:moneyBgView];
//    [moneyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self.view);
//        make.height.mas_equalTo(50);
//    }];
//
//    UILabel *moneylab = [UILabel new];
//    moneylab.text = [NSString stringWithFormat:@"报名费用:%@元",_entry_fee];
//    moneylab.textColor = [UIColor blackColor];
//    moneylab.font = [UIFont systemFontOfSize:15];
//    [moneyBgView addSubview:moneylab];
//    [moneylab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(moneyBgView);
//        make.left.equalTo(moneyBgView.mas_left).mas_offset(10);
//    }];
//
//    ///微信支付
//    UIView *weiinBgView = [UIView new];
//    weiinBgView.userInteractionEnabled = YES;
//    weiinBgView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:weiinBgView];
//    [weiinBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(moneyBgView);
//        make.top.equalTo(moneyBgView.mas_bottom).mas_offset(10);
//    }];
//    UITapGestureRecognizer *wPayClick  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wPayAction)];
//    [weiinBgView addGestureRecognizer:wPayClick];
//
//    UIButton *weiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [weiBtn setTitleColor:[UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1] forState:UIControlStateNormal];
//    weiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    weiBtn.userInteractionEnabled = NO;
//    [weiinBgView addSubview:weiBtn];
//
//    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [payBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_normat"] forState:UIControlStateNormal];
//    [payBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_selected"] forState:UIControlStateSelected];
//    [weiinBgView addSubview:payBtn];
//    _wPayBtn = payBtn;
//
//    [weiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weiinBgView);
//        make.left.equalTo(weiinBgView.mas_left).mas_offset(10);
//    }];
//    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weiinBgView);
//        make.right.equalTo(weiinBgView.mas_right).mas_offset(-10);
//    }];
//
//
//    ///支付宝支付
//    UIView *zfbBgView = [UIView new];
//    zfbBgView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:zfbBgView];
//    [zfbBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(moneyBgView);
//        make.top.equalTo(weiinBgView.mas_bottom).mas_offset(1);
//    }];
//    UITapGestureRecognizer *zPayClick  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zPayAction)];
//    [zfbBgView addGestureRecognizer:zPayClick];
//
//
//    UIButton *zfbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [zfbBtn setTitleColor:[UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1] forState:UIControlStateNormal];
//    zfbBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    zfbBtn.userInteractionEnabled = NO;
//    [zfbBgView addSubview:zfbBtn];
//
//    UIButton *zfbPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [zfbPayBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_normat"] forState:UIControlStateNormal];
//    [zfbPayBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_selected"] forState:UIControlStateSelected];
//    [zfbBgView addSubview:zfbPayBtn];
//    _zPayBtn = zfbPayBtn;
//
//    [zfbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(zfbBgView);
//        make.left.equalTo(zfbBgView.mas_left).mas_offset(10);
//    }];
//    [zfbPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(zfbBgView);
//        make.right.equalTo(zfbBgView.mas_right).mas_offset(-10);
//    }];
//
//    ///去支付
//    UIButton *zfbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    if ([GetDefaults isEqualToString:@"red"]) {
//       [zfbtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/btn_zhifu_red"] forState:UIControlStateNormal];
//    }else {
//        [zfbtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/btn_zhifu"] forState:UIControlStateNormal];
//    }
//
//    [zfbtn setTitle:@"去支付" forState:UIControlStateNormal];
//    [zfbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    zfbtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self.view  addSubview:zfbtn];
//
//    [zfbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view );
//        make.top.equalTo(zfbBgView.mas_bottom ).mas_offset(70);
//    }];
//    [zfbtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
//
//
//    if(![dict[@"wechat"] isKindOfClass:[NSNull class]] && ![dict[@"alipay"] isKindOfClass:[NSNull class]]){
//
//        [weiBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_zhifu_wechat"] forState:UIControlStateNormal];
//        [weiBtn setTitle:[NSString stringWithFormat:@"  %@",dict[@"wechat"][@"name"]] forState:UIControlStateNormal];
//        payBtn.tag = [dict[@"wechat"][@"id"] integerValue];
//
//         [zfbBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_zhifu_zfb"] forState:UIControlStateNormal];
//         [zfbBtn setTitle:[NSString stringWithFormat:@"  %@",dict[@"alipay"][@"name"]] forState:UIControlStateNormal];
//         zfbPayBtn.tag = [dict[@"alipay"][@"id"] integerValue];
//
//    }else if ([dict[@"wechat"] isKindOfClass:[NSNull class]]){
//
//          [weiBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_zhifu_zfb"] forState:UIControlStateNormal];
//          [weiBtn setTitle:[NSString stringWithFormat:@"  %@",dict[@"alipay"][@"name"]] forState:UIControlStateNormal];
//          payBtn.tag = [dict[@"alipay"][@"id"] integerValue];
//          zfbBgView.hidden = YES;
//
//    }else if ([dict[@"alipay"] isKindOfClass:[NSNull class]]){
//
//         [weiBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_zhifu_wechat"] forState:UIControlStateNormal];
//         [weiBtn setTitle:[NSString stringWithFormat:@"  %@",dict[@"wechat"][@"name"]] forState:UIControlStateNormal];
//          payBtn.tag = [dict[@"wechat"][@"id"] integerValue];
//          zfbBgView.hidden = YES;
//    }
//}

#pragma mark - Delegate/DataSource Methods

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Action Methods
//- (void)wPayAction {
//
//    _wPayBtn.selected = YES;
//    _zPayBtn.selected = NO;
//    _pay_way = _wPayBtn.tag;
//}
//- (void)zPayAction {
//
//    _wPayBtn.selected = NO;
//    _zPayBtn.selected = YES;
//    _pay_way = _zPayBtn.tag;
//}
- (void)payAction:(UIButton *)seder {

    [SVProgressHUD showWithStatus:@"请稍后"];
    MJWeakSelf;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setDictionary:_prama];
    [dict setObject:@"1" forKey:@"pay_way"];


        [HLHJVoteNetWorkTool uploadImageWithPath:get_post_enroll_api imageData:self->_imgageData params:dict successComplete:^(id  _Nonnull responseObject) {
            
          NSString  *pay_sn = responseObject[@"data"];
       
                [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_pay_code_api parameter:@{@"pay_sn":pay_sn} successComplete:^(id  _Nullable responseObject) {
                    
                    NSString *url = responseObject[@"data"];
                    
                    HLHJPaySowView *payView = [[HLHJPaySowView alloc]initWithDateSource:url];
                    [payView showPayView];
                     payView.block = ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    };
                } failureComplete:^(NSError * _Nonnull error) {
                }];
            
            [SVProgressHUD dismiss];
            
        } failureComplete:^(NSError * _Nonnull error) {
            
            [SVProgressHUD dismiss];
        }];

}
#pragma mark - Getter Methods

#pragma mark - Setter Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
