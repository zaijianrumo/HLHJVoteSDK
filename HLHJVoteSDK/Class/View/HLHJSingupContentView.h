//
//  HLHJSingupContentView.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TiJiaoBlock) (NSDictionary *dict,NSData *imgageData);

@class HLHJVoteActivityDetilModel;
/**
 报名填写资料页面
 */
@interface HLHJSingupContentView : UIView

@property (nonatomic, strong) UILabel  *voteTimeLab;

@property (nonatomic, strong) UILabel  *singUpTimeLab;

@property (nonatomic, strong) HLHJVoteActivityDetilModel  *model;

@property (nonatomic, copy) TiJiaoBlock  tiJiaoBlock;

@end
