//
//  HLHJVoteCollectionCell.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLHJVoteCompetitorListModel;
@interface HLHJVoteCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIButton    *voteBtn;

@property (nonatomic, strong) UIImageView  *iconImg;

@property (nonatomic, strong) UIImageView  *leftTopImageView;

@property (nonatomic, strong) UILabel      *numberLab;

@property (nonatomic, strong) UILabel      *NOLab;

@property (nonatomic, strong) UILabel      *rankingLab;

@property (nonatomic, strong) HLHJVoteCompetitorListModel  *model;

@end
