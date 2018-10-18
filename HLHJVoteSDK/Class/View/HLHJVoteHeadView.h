//
//  HLHJVoteHeadView.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 页面顶部
 */
@interface HLHJVoteHeadView : UIView

@property (nonatomic, strong) UIImageView  *bgImg;

@property (nonatomic, strong) UILabel  *titleLab;

@property (nonatomic, strong) UILabel  *timeLab;

@property (nonatomic, strong) UILabel  *voteNumLab;

@property (nonatomic, strong) UIButton  *singUpBtn;
@end
