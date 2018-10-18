//
//  HLHJBaseController.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJBaseController.h"

/** Controllers **/

/** Model **/

/** Views**/

/** #define **/


@interface HLHJBaseController ()


@end

@implementation HLHJBaseController


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    ///主题键值 red , bule
//     SetDefaults(@"bule");
    [self getThemeColor];
    
    
    
    
}

#pragma mark - Delegate/DataSource Methods

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - Public Methods

//获取主题颜色
- (void)getThemeColor {
    [HLHJVoteNetWorkTool requestWithType:GET requestUrl:get_style_api parameter:nil successComplete:^(id  _Nullable responseObject) {
        NSInteger type = [responseObject[@"data"] integerValue];
        NSString *themeColor = type == 1 ? @"red" : @"bule";
        SetDefaults(themeColor);
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Private Methods

#pragma mark - Action Methods

#pragma mark - Getter Methods

#pragma mark - Setter Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
