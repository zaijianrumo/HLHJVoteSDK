//
//  HLHJSignupController.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJSignupController.h"

/** Controllers **/
#import "HLHJVotePayController.h"
/** Model **/
#import "HLHJVoteActivityDetilModel.h"
/** Views**/
#import "HLHJVoteHeadView.h"
#import "HLHJSingupHeadView.h"
#import "HLHJSingupContentView.h"
#import "SVProgressHUD.h"
#import "HLHJSingupSuccesView.h"
/** #define **/
#import "UIView+HLHJGradient.h"
#import "UIColor+HLHJVoteHex.h"
#import "NSString+HLHJExtention.h"
@interface HLHJSignupController ()

@property  (nonatomic ,strong) HLHJVoteHeadView *voteView;

@property  (nonatomic ,strong) HLHJSingupHeadView  *singupHeadView;

@property  (nonatomic ,strong) HLHJSingupContentView  *singupContentView;

@property (nonatomic, strong) UIImageView  *rightImgaView;

@property (nonatomic, strong) UIImageView  *rightBottomImgaView;

@property (nonatomic, assign) CGFloat  allHeight;

@property UIScrollView * scrollView;

@end

@implementation HLHJSignupController

@synthesize allHeight;

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    HLHJNavBarView *navTitView = [[HLHJNavBarView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    navTitView.titleColor = [UIColor whiteColor];
    self.navigationItem.titleView = navTitView;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height-kNavBarHeight)];
    
    [self.scrollView addSubview:self.voteView];
    self.voteView.voteNumLab.hidden = YES;
    [self.scrollView addSubview:self.rightImgaView];
    
    [self.scrollView addSubview:self.singupHeadView];
    
    [self.scrollView addSubview:self.singupContentView];
    
    [self.scrollView addSubview:self.rightBottomImgaView];

    [self.view addSubview: self.scrollView];
    
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self initData];
    
    MJWeakSelf;
    self.singupContentView.tiJiaoBlock = ^(NSDictionary *dict, NSData *imgageData) {
      
        ///不需要交报名费的情况
        if(weakSelf.model.entry_fee == 0.00){
        
            [SVProgressHUD showWithStatus:@"请稍后"];
            [HLHJVoteNetWorkTool uploadImageWithPath:get_post_enroll_api imageData:imgageData params:dict successComplete:^(id  _Nonnull responseObject) {
                [SVProgressHUD dismiss];

                
                HLHJSingupSuccesView *success = [HLHJSingupSuccesView new];
                [success showView];
                success.cancelBlock = ^{
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [weakSelf.navigationController popViewControllerAnimated:YES];
                                    });
                };
                } failureComplete:^(NSError * _Nonnull error) {
                  [SVProgressHUD dismiss];
                }];

        }else {
            HLHJVotePayController *pay = [[HLHJVotePayController alloc]init];
            pay.native = YES;
            pay.entry_fee = [@(_model.entry_fee) stringValue];
            pay.prama = dict;
            pay.imgageData = imgageData;
            [weakSelf.navigationController pushViewController:pay animated:YES];
        }
    };

    allHeight = 570;
    for (NSString *str in _model.enroll_rule) {
        allHeight = allHeight + [str  getHeightLineWithString:str withWidth:weakSelf.view.frame.size.width-50 withFont:[UIFont systemFontOfSize:14]];
    }
    allHeight = allHeight + _model.enroll_rule.count *10;
    

}
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    _singupHeadView.frame = CGRectMake(10, CGRectGetMaxY(self.voteView.timeLab.frame)+15, self.view.frame.size.width-20, 244);
    
    _singupContentView.frame = CGRectMake(10, CGRectGetMaxY(self.singupHeadView.frame)+10, self.view.frame.size.width-20, allHeight);
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.singupContentView.frame)+30);
    
    self.rightBottomImgaView.frame = CGRectMake(self.view.frame.size.width-80, CGRectGetMaxY(self.singupContentView.frame)- 80, 80, 100);
    
}
#pragma mark - Delegate/DataSource Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - Public Methods
- (void)initData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.voteView.titleLab.text = self.model.title;
        
        self.voteView.timeLab.text  = [NSString stringWithFormat:@"活动时间:%@至%@",self.model.start_time,self.model.end_time];
        
        self.singupContentView.singUpTimeLab.text = [NSString stringWithFormat:@"报名时间:%@至%@",self.model.enroll_start,self.model.enroll_end];
        
        self.singupContentView.voteTimeLab.text = [NSString stringWithFormat:@"投票时间:%@至%@",self.model.start_time,self.model.end_time];
        
        self.singupContentView.model = self.model;
    });
    
}

#pragma mark - Private Methods

#pragma mark - Action Methods

#pragma mark - Getter Methods

#pragma mark - Setter Methods

- (HLHJVoteHeadView *)voteView {
    if(!_voteView){
        _voteView = [[HLHJVoteHeadView alloc]init];
        _voteView.frame = CGRectMake(0, 0, self.view.frame.size.width, 328);
    }
    return _voteView;
}

- (HLHJSingupHeadView *)singupHeadView {
    if(!_singupHeadView){
        _singupHeadView = [[HLHJSingupHeadView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.voteView.timeLab.frame)-kNavBarHeight+20, self.view.frame.size.width-20, 244)];
        _singupHeadView.layer.cornerRadius = 8;
        _singupHeadView.clipsToBounds = YES;
    }
    return _singupHeadView;
}
- (HLHJSingupContentView *)singupContentView {
    if(!_singupContentView){ ///410;
        _singupContentView = [[HLHJSingupContentView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.singupHeadView.frame)+10, self.view.frame.size.width-20, allHeight)];
        _singupContentView.layer.cornerRadius = 8;
        if ([GetDefaults isEqualToString:@"red"]) {
               [_singupContentView setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        }else {
               [_singupContentView setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"#347DE0"],[UIColor colorWithHexString:@"#2FCBFF"]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        }
        _singupContentView.backgroundColor = [UIColor whiteColor];
        _singupContentView.clipsToBounds = YES;
    }
    return _singupContentView;
}
-(UIImageView *)rightImgaView {
    if (!_rightImgaView) {
        _rightImgaView = [UIImageView new];
        _rightImgaView.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_bg_first_right"];
        _rightImgaView.frame = CGRectMake(self.view.frame.size.width-80, 400, 80, 100);
    }
    return _rightImgaView;
}
-(UIImageView *)rightBottomImgaView {
    if (!_rightBottomImgaView) {
        _rightBottomImgaView = [UIImageView new];
        _rightBottomImgaView.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_bg_second_right"];
        _rightBottomImgaView.frame = CGRectMake(self.view.frame.size.width-80, CGRectGetMaxY(self.singupContentView.frame)+60, 80, 100);
    }
    return _rightBottomImgaView;
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
