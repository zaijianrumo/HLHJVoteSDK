//
//  HLHJIPManager.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLHJIPManager : NSObject

+(instancetype)sharedManager;


/**
 *
 *  获取具体的ip地址
 */
-(NSString *)currentIpAddress;


/**
 * 
 *  获取ip地址的详细信息
 */
-(void)currentIPAdressDetailInfo;

@end
