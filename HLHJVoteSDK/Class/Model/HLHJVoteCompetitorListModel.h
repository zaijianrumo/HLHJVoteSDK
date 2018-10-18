//
//  HLHJVoteCompetitorListModel.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 选手列表
 */
@interface HLHJVoteCompetitorListModel : NSObject

//list->competitor_id 选手ID
//list->competitor_name 选手姓名
//list->avatar 选手图片
//list->phone 联系电话
//list->profile 个人简介
//list->ballot 票数
//list->add_time 参赛时间


@property (nonatomic, copy) NSString  *competitor_id;

@property (nonatomic, copy) NSString  *competitor_name;

@property (nonatomic, copy) NSString  *avatar;

@property (nonatomic, copy) NSString  *phone;

@property (nonatomic, copy) NSString  *profile;

@property (nonatomic, copy) NSString  *activity_id;

@property (nonatomic, copy) NSString  *ballot;

@property (nonatomic, copy) NSString  *add_time;




@end
