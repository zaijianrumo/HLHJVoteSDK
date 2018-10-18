//
//  HLHJVoteActivityDetilModel.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteActivityDetilModel.h"

@implementation HLHJVoteActivityDetilModel
/// YYModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"user":[VoteUserModel class]};
}

@end

@implementation VoteUserModel

@end

