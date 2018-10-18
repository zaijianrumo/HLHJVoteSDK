//
//  HLHJVoteController.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 投票页面
 */
@interface HLHJVoteController : HLHJBaseController

///活动ID
@property (nonatomic, copy) NSString  *activity_id;

///活动状态 0已结束 1进行中 2报名中
@property (nonatomic, assign) NSInteger  state;

@end
