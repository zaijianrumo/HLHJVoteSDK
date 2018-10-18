//
//  HLHJVoteActivityDetilModel.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VoteUserModel;

@interface HLHJVoteActivityDetilModel : NSObject

@property (nonatomic, copy) NSString  *activity_id;

@property (nonatomic, copy) NSString  *title;

@property (nonatomic, copy) NSString  *activity_cover;

@property (nonatomic, copy) NSString  *enroll_start;

@property (nonatomic, copy) NSString  *enroll_end;

@property (nonatomic, copy) NSString  *start_time;

@property (nonatomic, copy) NSString  *end_time;

@property (nonatomic, assign) double  entry_fee;

@property (nonatomic, copy) NSString  *enroll_check;

@property (nonatomic, copy) NSString  *ballot_way;

@property (nonatomic, copy) NSString  *ballot_number;

@property (nonatomic, strong) NSArray  *rule;

@property (nonatomic, strong) NSArray  *enroll_rule;

@property (nonatomic, assign) NSInteger  is_enroll;

@property (nonatomic, assign) NSInteger  state;

@property (nonatomic, strong) VoteUserModel  *user;

@end

@interface VoteUserModel:NSObject

@property (nonatomic, copy) NSString  *user_id;

@property (nonatomic, assign) NSInteger  ballot;

@property (nonatomic, copy) NSString  *last_time;

@end
